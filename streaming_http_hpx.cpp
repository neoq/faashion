
// Copyright (c) 2023 Jakob Hördt
// based on work an example by
// Copyright (c) 2017 Christopher M. Kohlhoff (chris at kohlhoff dot com)
//
// Distributed under the Boost Software License, Version 1.0. (See accompanying
// file LICENSE_1_0.txt or copy at http://www.boost.org/LICENSE_1_0.txt)

#include <boost/asio.hpp>
#include <boost/beast/core.hpp>
#include <boost/beast/http.hpp>
#include <boost/beast/version.hpp>

#include <hpx/hpx_start.hpp>
#include <hpx/include/actions.hpp>
#include <hpx/include/lcos.hpp>
#include <hpx/include/parallel_executors.hpp>
#include <hpx/include/post.hpp>
#include <hpx/include/runtime.hpp>
#include <hpx/iostream.hpp>

#include <algorithm>
#include <chrono>
#include <cstdlib>
#include <ctime>
#include <fstream>
#include <iostream>
#include <memory>
#include <optional>
#include <ranges>
#include <span>
#include <string>

namespace beast = boost::beast;   // from <boost/beast.hpp>
namespace http = beast::http;     // from <boost/beast/http.hpp>
namespace net = boost::asio;      // from <boost/asio.hpp>
using tcp = boost::asio::ip::tcp; // from <boost/asio/ip/tcp.hpp>

std::vector<hpx::id_type> localities;
auto get_round_robin_locality() {
	thread_local std::ptrdiff_t i = 0;
	i = (i + 1) % std::ssize(localities);
	return localities[i];
}

// boost span range constructor seems broken
template <typename T, std::size_t E>
auto std2boost(std::span<T, E> s) {
	return boost::span<T, E>{s.data(), s.size()};
}

std::string get_file_contents(const char* filename) {
	std::ifstream in(filename, std::ios::in);
	if (!in) {
		throw std::runtime_error{std::strerror(errno)};
	}

	in.seekg(0, std::ios::end);
	std::string contents(in.tellg(), 0);
	in.seekg(0);
	in.read(contents.data(), std::ranges::ssize(contents));
	return contents;
}

HPX_REGISTER_CHANNEL(uint8_t)

void execute_function(
	std::string function_path, hpx::lcos::channel<uint8_t> input,
	hpx::lcos::send_channel<uint8_t> output
) {
	// hpx::cout << "hello from " << hpx::get_locality_id() << std::endl;
	auto input_it = input.begin();
	auto input_end = input.end();

	auto more = [&] -> int32_t {
		auto result = input_it != input_end;
		return result;
	};
	auto put_byte = [&](uint32_t byte) { output.set(byte); };
	auto get_byte = [&] -> int32_t {
		if (input_it != input_end) {
			return *input_it++;
		}
		return 0;
	};

	/////"wasm" function dispatch//
	if (function_path == "/echo") {
		while (more()) {
			put_byte(get_byte());
		}
	} else if (function_path == "/noop") {
		while (more()) {
			get_byte();
		}
	} else {
		output.close();
		throw std::runtime_error{"function not found"};
	}

	//////////////////////////////

	output.close();
}
HPX_PLAIN_ACTION(execute_function, execute_function_action)

class http_connection : public std::enable_shared_from_this<http_connection> {
public:
	http_connection(tcp::socket socket) : socket_(std::move(socket)) {
		request_parser_.body_limit(boost::none);
	}

	// Initiate the asynchronous operations associated with the connection.
	void start() {
		read_request();
		check_deadline();
	}

private:
	// The socket for the currently connected client.
	tcp::socket socket_;

	// The buffer for performing reads.
	beast::flat_buffer buffer_{8192};
	std::array<uint8_t, 1024> write_buffer_;
	std::array<uint8_t, 1024> read_buffer_;

	http::response<http::empty_body> response_;
	http::response<http::string_body> string_response_;

	http::request_parser<http::buffer_body> request_parser_;

	// sessions are created on the main node, so creating sessions "here" is
	// correct
	hpx::lcos::channel<uint8_t> input_{hpx::find_here()},
		output_{hpx::find_here()};

	// The timer for putting a deadline on connection processing.
	net::steady_timer deadline_{
		socket_.get_executor(), std::chrono::seconds(60)};

	void read_request() {
		http::async_read_header(
			socket_, buffer_, request_parser_,
			[self = shared_from_this(
			 )](beast::error_code ec, std::size_t bytes_transferred) {
				boost::ignore_unused(bytes_transferred);
				if (!ec) {
					self->header_read();
				} else {
					std::cerr << "error: " << ec.message() << "\n";
				}
			}
		);
	}

	void header_read() {
		if (request_parser_.get().method() != http::verb::post) {
			string_response_.result(http::status::bad_request);
			string_response_.set(http::field::content_type, "text/plain");
			string_response_.body() = "Invalid request-method.";
			write_response(&http_connection::string_response_);
			return;
		}

		// write response header upfront
		response_.set(http::field::content_type, "application/octet-stream");
		response_.keep_alive(false);
		http::async_write(
			socket_, response_,
			[self = shared_from_this()](beast::error_code ec, std::size_t) {
				// now we can start writing body data

				// launch output task, this is the same post as in
			    // write_partial, but we need to start with reading from the
			    // channel here
				hpx::post([self] {
					int bytes_read = 0;
					auto it = self->write_buffer_.begin();
					// this "blocks" until the worker has given us enough
				    // output to fill a buffer
					for (auto byte : self->output_) {
						*it++ = byte;
						++bytes_read;
						if (bytes_read == std::ssize(self->write_buffer_)) {
							break;
						}
					}
					self->write_partial(bytes_read);
				});
			}
		);

		// launch input task that reads from socket and puts into
		// function channel
		read_partial();

		hpx::post([self = shared_from_this()] {
			execute_function_action f;
			try {
				f(get_round_robin_locality(), self->request_parser_.get().target(),
				  self->input_, self->output_);
			} catch (const std::exception& e) {
				std::cerr << "action threw: " << e.what() << '\n';
				self->string_response_.result(http::status::not_found);
				self->string_response_.set(
					http::field::content_type, "text/plain"
				);
				self->string_response_.body() = "function not found\r\n";
				self->write_response(&http_connection::string_response_);
			}
		});
	}

	void write_partial(int bytes_read) {
		if (bytes_read == 0) {
			// there is nothing left to be written here
			socket_.shutdown(tcp::socket::shutdown_send);
			deadline_.cancel();
			return;
		}
		net::async_write(
			socket_, net::buffer(write_buffer_, bytes_read),
			[self = shared_from_this(
			 )](boost::system::error_code ec, std::size_t bytes_transferred) {
				if (ec) {
					std::cerr << "error " << ec;
					return;
				}

				hpx::post([self] {
					int bytes_read = 0;
					auto it = self->write_buffer_.begin();
					// this "blocks" until the worker has given us enough output
				    // to fill a buffer
					for (auto byte : self->output_) {
						*it++ = byte;
						++bytes_read;
						if (bytes_read == std::ssize(self->write_buffer_)) {
							break;
						}
					}
					self->write_partial(bytes_read);
				});
			}
		);
	}

	// see
	// https://www.boost.org/doc/libs/1_83_0/libs/beast/doc/html/beast/using_http/parser_stream_operations/incremental_read.html
	// for an idea of how incremental reads are supposed to be done with beast
	void read_partial() {
		request_parser_.get().body().data = read_buffer_.data();
		request_parser_.get().body().size = read_buffer_.size();
		http::async_read_some(
			socket_, buffer_, request_parser_,
			[self = shared_from_this(
			 )](boost::system::error_code ec, std::size_t bytes_transferred) {
				if (ec == http::error::need_buffer) {
					ec = {};
				}
				if (ec) {
					std::cerr << "error " << ec;
					return;
				}

				hpx::post([self] {
					// send read bytes through channel to function
					for (auto byte : std::span{
							 self->read_buffer_.data(),
							 self->read_buffer_.size() -
								 self->request_parser_.get().body().size}) {
						self->input_.set(byte);
					}

					if (self->request_parser_.is_done()) {
						// indicate that this is all the input
						self->input_.close();
						return;
					}

					self->read_partial();
				});
			}
		);
	}

	void write_response(auto http_connection::*response) {
		// may be called in hpx thread, which is fine
		(this->*response).content_length((this->*response).body().size());
		(this->*response).keep_alive(false);

		// call is by itself thread safe and handler will sync before execution
		// handler cant overlap with deadline as we are using one asio thread
		http::async_write(
			socket_, this->*response,
			[self = shared_from_this()](beast::error_code ec, std::size_t) {
				self->socket_.shutdown(tcp::socket::shutdown_send, ec);
				self->deadline_.cancel();
			}
		);
	}

	// Check whether we have spent enough time on this connection.
	void check_deadline() {
		deadline_.async_wait([self = shared_from_this(
							  )](boost::system::error_code ec) {
			if (!ec) {
				std::cerr << "taking too long :(\n";
				// Close socket to cancel any outstanding operation.
				self->socket_.close(ec);
			} else if (boost::asio::error::operation_aborted) {
				// got canceled
			} else {
				std::cerr << "unknown error when waiting for deadline\n";
			}
		});
	}
};

// "Loop" forever accepting new connections.
void http_server(tcp::acceptor& acceptor, tcp::socket& socket) {
	acceptor.async_accept(socket, [&](beast::error_code ec) {
		if (!ec)
			std::make_shared<http_connection>(std::move(socket))->start();
		http_server(acceptor, socket);
	});
}

int main(int argc, char* argv[]) {
	try {
		// Initialize HPX, don't run hpx_main
		hpx::start(nullptr, argc, argv);

		// initialize localities used for load balancing
		localities = hpx::find_all_localities();

		// we don't want to run asio on a hpx thread, but on the main thread, so
		// we cant use hpx_main
		if (hpx::find_here() == hpx::find_root_locality()) {
			auto const address = net::ip::make_address("127.0.0.1");
			unsigned short port = 32425;

			net::io_context ioc{1};
			tcp::acceptor acceptor{ioc, {address, port}};
			tcp::socket socket{ioc};
			http_server(acceptor, socket);

			ioc.run();

			// this shutdown is not clean at all, but it does not matter for our
			// purposes
			hpx::post([]() { hpx::finalize(); });
		}
		// blocks until finalize is called
		return hpx::stop();

	} catch (std::exception const& e) {
		std::cerr << "Error: " << e.what() << std::endl;
		return EXIT_FAILURE;
	}
}