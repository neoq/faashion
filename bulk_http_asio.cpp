
// Copyright (c) 2023 Jakob Hördt
// based on work an example by
// Copyright (c) 2017 Christopher M. Kohlhoff (chris at kohlhoff dot com)
//
// Distributed under the Boost Software License, Version 1.0. (See accompanying
// file LICENSE_1_0.txt or copy at http://www.boost.org/LICENSE_1_0.txt)

#include "wasmtime.hh"
#include <boost/asio.hpp>
#include <boost/beast/core.hpp>
#include <boost/beast/http.hpp>
#include <boost/beast/version.hpp>

#include <algorithm>
#include <chrono>
#include <cstdlib>
#include <ctime>
#include <filesystem>
#include <fstream>
#include <iostream>
#include <memory>
#include <optional>
#include <string>
#include <thread>
#include <unordered_map>
#include <vector>

namespace beast = boost::beast;   // from <boost/beast.hpp>
namespace http = beast::http;     // from <boost/beast/http.hpp>
namespace net = boost::asio;      // from <boost/asio.hpp>
using tcp = boost::asio::ip::tcp; // from <boost/asio/ip/tcp.hpp>

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

// An engine is safe to share between threads. Multiple stores can be created
// within the same engine with each store living on a separate thread. Typically
// you'll create one
// [wasm_engine_t](https://docs.wasmtime.dev/c-api/structwasm__engine__t.html
// "Compilation environment and configuration.") for the lifetime of your
// program.
wasmtime::Engine global_wasmengine = wasmtime::Engine{};

// stl containers are safe to read concurrently
const std::unordered_map<std::string, wasmtime::Module> modules = [] {
	std::unordered_map<std::string, wasmtime::Module> result;
	for (const auto& entry : std::filesystem::directory_iterator{"functions"}) {
		if (entry.is_regular_file() and entry.path().extension() == ".wat") {
			result.emplace(
				"/" + entry.path().stem().string(),
				wasmtime::Module::compile(
					global_wasmengine, get_file_contents(entry.path().c_str())
				)
					.unwrap()
			);
		}
	}
	return result;
}();

class http_connection : public std::enable_shared_from_this<http_connection> {
public:
	http_connection(tcp::socket socket)
		: socket_(std::move(socket)), wasmtime_store_(global_wasmengine) {
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

	http::response<http::span_body<uint8_t>> response_;
	http::response<http::string_body> string_response_;

	http::request_parser<http::span_body<uint8_t>> request_parser_;

	wasmtime::Store wasmtime_store_;
	std::int32_t wasm_memory_offset_, wasm_memory_size_;

	// no default constructer, can only be initialized once module is known
	std::optional<wasmtime::Instance> wasm_instance_;

	// The timer for putting a deadline on connection processing.
	net::steady_timer deadline_{
		socket_.get_executor(), std::chrono::seconds(60)};

	// Asynchronously receive a complete request message.
	void read_request() {
		// read only header to be able to load correct module and then read the
		// body into wasm memory directly.
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

	// Determine what needs to be done with the request message.
	void header_read() {
		if (request_parser_.get().method() != http::verb::post) {
			string_response_.result(http::status::bad_request);
			string_response_.set(http::field::content_type, "text/plain");
			string_response_.body() = "Invalid request-method.";
			write_response(&http_connection::string_response_);
			return;
		}

		// the precompiled modules map requires reading all modules at startup
		// but avoids concurrency issues with cache
		if (auto module_it = modules.find(request_parser_.get().target());
		    module_it != modules.end()) {
			response_.set(
				http::field::content_type, "application/octet-stream"
			);

			// initialize module corresponding to this path
			wasm_instance_ = wasmtime::Instance::create(
								 wasmtime_store_, module_it->second, {}
			)
			                     .unwrap();
			auto memory = std::get<wasmtime::Memory>(
				/*memory must be available*/ *wasm_instance_->get(
					wasmtime_store_, "memory"
				)
			);

			// allocate memory in module
			// TODO: handle module not providing alloc
			auto alloc = std::get<wasmtime::Func>(
				wasm_instance_->get(wasmtime_store_, "alloc").value()
			);
			wasm_memory_size_ = 2'000'000'000;
			wasm_memory_offset_ =
				alloc.call(wasmtime_store_, {wasm_memory_size_})
					.unwrap()[0]
					.i32();

			assert(wasm_memory_offset_ != 0);
			// TODO: handle allocation failure
			//  set (to be filled) request body to allocated wasm memory
			// memory will not be invalidated between here ...
			// TODO: verify subspan in bounds, malicious module could return
			// anything from alloc, would currently segfault
			request_parser_.get().body() =
				std2boost(memory.data(wasmtime_store_)
			                  .subspan(wasm_memory_offset_, wasm_memory_size_));

			// ... and here, where the memory is filled
			http::async_read(
				socket_, buffer_, request_parser_,
				[self = shared_from_this(
				 )](beast::error_code ec, std::size_t bytes_transferred) {
					// according to docs, bytes_transferred does not count
				    // leftover bytes in DynamicBuffer, but I could not observe
				    // it, so we assume its correct to not resort to a hack
					if (!ec) {
						self->body_read(bytes_transferred);
					} else {
						std::cerr << "error: " << ec.message() << "\n";
					}
				}
			);
			return;
		}

		string_response_.result(http::status::not_found);
		string_response_.set(http::field::content_type, "text/plain");
		string_response_.body() = "File not found\r\n";
		write_response(&http_connection::string_response_);
	}

	void body_read(std::size_t bytes_transferred) {
		auto function = std::get<wasmtime::Func>(
			wasm_instance_->get(wasmtime_store_, "function").value()
		);
		auto get_output_size = std::get<wasmtime::Func>(
			wasm_instance_->get(wasmtime_store_, "get_output_size").value()
		);

		// execute wasm function
		const auto offset =
			function
				.call(
					wasmtime_store_,
					{wasm_memory_offset_,
		             int32_t(/*body can be at most wasm_memory_size_, so should
		                        never overflow*/
		                     bytes_transferred
		             )}
				)
				.unwrap()[0]
				.i32();
		const auto size =
			get_output_size.call(wasmtime_store_, {}).unwrap()[0].i32();

		auto memory = std::get<wasmtime::Memory>(
			// memory, als well as wasm_instance are guaranteed to be there
			*wasm_instance_->get(wasmtime_store_, "memory")
		);

		// assign output body to given memory region. the Memory will not be
		// invalidated after this point, so the span is safe.
		response_.body() =
			std2boost(memory.data(wasmtime_store_).subspan(offset, size));

		write_response(&http_connection::response_);
	}

	void write_response(auto http_connection::*response) {
		(this->*response).content_length((this->*response).body().size());
		(this->*response).keep_alive(false);

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
		if (!ec) {
			std::make_shared<http_connection>(std::move(socket))->start();
		} else {
			std::cerr << "error: " << ec.message() << "\n";
		}
		http_server(acceptor, socket);
	});
}

int main(int argc, char* argv[]) {
	try {
		auto const address = net::ip::make_address("0.0.0.0");
			unsigned short port = 32425;
		auto const thread_count =
			std::stoi(std::getenv("SLURM_CPUS_PER_TASK"));
		std::cerr << "threads: " << thread_count << '\n';

		net::io_context ioc{thread_count};
		tcp::acceptor acceptor{ioc, {address, port}};
		tcp::socket socket{ioc};
		http_server(acceptor, socket);

		std::vector<std::thread> workers;
		for (auto i = 0; i < thread_count - 1; ++i) {
			workers.emplace_back([&ioc] { ioc.run(); });
		}
		ioc.run();
		for (auto& worker : workers) {
			worker.join();
		}

	} catch (std::exception const& e) {
		std::cerr << "Error: " << e.what() << std::endl;
		return EXIT_FAILURE;
	}
}