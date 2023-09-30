
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
#include <hpx/hpx_start.hpp>
#include <hpx/include/runtime.hpp>
#include <hpx/iostream.hpp>

#include <algorithm>
#include <chrono>
#include <cstdlib>
#include <ctime>
#include <filesystem>
#include <fstream>
#include <iostream>
#include <memory>
#include <span>
#include <string>
#include <unordered_map>

#define TIMING

std::array<std::chrono::time_point<std::chrono::steady_clock>, 13> timings;

namespace beast = boost::beast;   // from <boost/beast.hpp>
namespace http = beast::http;     // from <boost/beast/http.hpp>
namespace net = boost::asio;      // from <boost/asio.hpp>
using tcp = boost::asio::ip::tcp; // from <boost/asio/ip/tcp.hpp>

std::vector<hpx::id_type> localities;

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

std::vector<uint8_t>
execute_function(std::string function_path, std::vector<uint8_t> input) {
	// hpx::cout << "hello from " << hpx::get_locality_id() << std::endl;
#ifdef TIMING
	timings[3] = std::chrono::steady_clock::now();
#endif
	auto module_it = modules.find(function_path);
	if (module_it == modules.end()) {
		throw std::runtime_error{"function not found"};
	}

#ifdef TIMING
	timings[4] = std::chrono::steady_clock::now();
#endif

	std::int32_t wasm_memory_size = 2'000'000'000;
	assert(input.size() <= wasm_memory_size);
	wasmtime::Store wasmtime_store(global_wasmengine);

#ifdef TIMING
	timings[5] = std::chrono::steady_clock::now();
#endif
	// initialize module corresponding to this path
	auto wasm_instance =
		wasmtime::Instance::create(wasmtime_store, module_it->second, {})
			.unwrap();

#ifdef TIMING
	timings[6] = std::chrono::steady_clock::now();
#endif
	auto memory = std::get<wasmtime::Memory>(
		/*memory must be available*/ *wasm_instance.get(
			wasmtime_store, "memory"
		)
	);
#ifdef TIMING
	timings[7] = std::chrono::steady_clock::now();
#endif

	// allocate memory in module
	// we could allocate only the needed space in this case but it is probably
	// better to keep the determinism
	// TODO: handle module not providing alloc
	auto alloc = std::get<wasmtime::Func>(
		wasm_instance.get(wasmtime_store, "alloc").value()
	);
	std::int32_t wasm_memory_offset =
		alloc.call(wasmtime_store, {wasm_memory_size}).unwrap()[0].i32();

#ifdef TIMING
	timings[8] = std::chrono::steady_clock::now();
#endif

	assert(wasm_memory_offset != 0);
	// TODO: handle allocation failure
	//  set (to be filled) request body to allocated wasm memory
	// memory will not be invalidated between here ...
	// TODO: verify subspan in bounds, malicious module could return
	// anything from alloc, would currently segfault
	// should not buffer overflow since input.size() constrained previously
	std::ranges::copy(
		input, memory.data(wasmtime_store).begin() + wasm_memory_offset
	);

#ifdef TIMING
	timings[9] = std::chrono::steady_clock::now();
#endif
	auto function = std::get<wasmtime::Func>(
		wasm_instance.get(wasmtime_store, "function").value()
	);
	auto get_output_size = std::get<wasmtime::Func>(
		wasm_instance.get(wasmtime_store, "get_output_size").value()
	);

	// execute wasm function
	const auto offset =
		function
			.call(
				wasmtime_store, {wasm_memory_offset,
	                             int32_t(/*body can be at most wasm_memory_size,
	                                        so should never overflow*/
	                                     input.size()
	                             )}
			)
			.unwrap()[0]
			.i32();

#ifdef TIMING
	timings[10] = std::chrono::steady_clock::now();
#endif
	const auto size =
		get_output_size.call(wasmtime_store, {}).unwrap()[0].i32();

	auto output = memory.data(wasmtime_store).subspan(offset, size);
	return std::vector<uint8_t>(output.begin(), output.end());
}
HPX_PLAIN_ACTION(execute_function, execute_function_action)

class http_connection : public std::enable_shared_from_this<http_connection> {
public:
	http_connection(tcp::socket socket, std::ptrdiff_t locality_id_idx)
		: locality_id_idx(locality_id_idx), socket_(std::move(socket)) {
		request_parser_.body_limit(boost::none);
	}

	// Initiate the asynchronous operations associated with the connection.
	void start() {
		read_request();
		check_deadline();
	}

private:
	std::ptrdiff_t locality_id_idx;

	// The socket for the currently connected client.
	tcp::socket socket_;

	// The buffer for performing reads.
	beast::flat_buffer buffer_{8192};

	http::response<http::vector_body<uint8_t>> response_;
	http::response<http::string_body> string_response_;

	http::request_parser<http::vector_body<uint8_t>> request_parser_;

	// The timer for putting a deadline on connection processing.
	net::steady_timer deadline_{
		socket_.get_executor(), std::chrono::seconds(60)};

	// Asynchronously receive a complete request message.
	void read_request() {
		http::async_read(
			socket_, buffer_, request_parser_,
			[self = shared_from_this(
			 )](beast::error_code ec, std::size_t bytes_transferred) {
#ifdef TIMING
				timings[1] = std::chrono::steady_clock::now();
#endif
				boost::ignore_unused(bytes_transferred);
				if (!ec) {
					self->request_read();
				} else {
					std::cerr << "error: " << ec.message() << "\n";
				}
			}
		);
	}

	// Determine what needs to be done with the request message.
	void request_read() {
		if (request_parser_.get().method() != http::verb::post) {
			string_response_.result(http::status::bad_request);
			string_response_.set(http::field::content_type, "text/plain");
			string_response_.body() = "Invalid request-method.";
			write_response(&http_connection::string_response_);
			return;
		}

		response_.set(http::field::content_type, "application/octet-stream");

		// synchronizes with hpx thread
		hpx::post([self = shared_from_this()] {
#ifdef TIMING
			timings[2] = std::chrono::steady_clock::now();
#endif
			execute_function_action f;
			try {
				self->response_.body() =
					f(localities[self->locality_id_idx],
				      self->request_parser_.get().target(),
				      std::move(self->request_parser_.get().body()));
#ifdef TIMING
				timings[11] = std::chrono::steady_clock::now();
#endif
				self->write_response(&http_connection::response_);
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

	void write_response(auto http_connection::*response) {
		// may be called in hpx thread, which is fine
		(this->*response).content_length((this->*response).body().size());
		(this->*response).keep_alive(false);

		// call is by itself thread safe and handler will sync before execution
		// handler cant overlap with deadline as we are using one asio thread
		http::async_write(
			socket_, this->*response,
			[self = shared_from_this()](beast::error_code ec, std::size_t) {
#ifdef TIMING
				timings[12] = std::chrono::steady_clock::now();
				for (auto t : timings) {
					std::cerr
						<< std::chrono::nanoseconds{t.time_since_epoch()}.count(
						   )
						<< ",";
				}
				std::cerr << '\n';
#endif
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
void http_server(
	tcp::acceptor& acceptor, tcp::socket& socket,
	std::ptrdiff_t round_robin_index
) {
	acceptor.async_accept(socket, [&, round_robin_index](beast::error_code ec) {
#ifdef TIMING
		timings[0] = std::chrono::steady_clock::now();
#endif
		if (!ec) {
			std::make_shared<http_connection>(
				std::move(socket), round_robin_index
			)
				->start();
		}
		http_server(
			acceptor, socket, (round_robin_index + 1) % std::ssize(localities)
		);
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
			http_server(acceptor, socket, 0);

			hpx::cout << "WELCOME, bulk hpx running. Webserver locality:"
					  << std::endl;
			std::system("hostname");

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