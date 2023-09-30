

#include "wasmtime.hh"
#include <benchmark/benchmark.h>

#include <algorithm>
#include <chrono>
#include <cmath>
#include <complex>
#include <cstdint>
#include <cstdlib>
#include <cstring>
#include <ctime>
#include <filesystem>
#include <fstream>
#include <functional>
#include <iostream>
#include <memory>
#include <numeric>
#include <ranges>
#include <span>
#include <string>
#include <thread>
#include <unordered_map>

#include "../functions_impl/mandelbrot.ipp"

namespace {
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

auto noop_mod = [] {
	auto module_it = modules.find("/noop");
	if (module_it == modules.end()) {
		throw std::runtime_error{"function not found"};
	}
	return module_it->second;
}();

auto compute_mod = [] {
	auto module_it = modules.find("/compute");
	if (module_it == modules.end()) {
		throw std::runtime_error{"function not found"};
	}
	return module_it->second;
}();

void thread_create_and_join(benchmark::State& state) {
	for (auto _ : state) {
		std::thread t{[] {}};
		t.join();
	}
}
BENCHMARK(thread_create_and_join);

void wasm_create_instance_and_store(benchmark::State& state) {
	for (auto _ : state) {
		wasmtime::Store wasmtime_store(global_wasmengine);
		auto wasm_instance =
			wasmtime::Instance::create(wasmtime_store, noop_mod, {}).unwrap();
	}
}
BENCHMARK(wasm_create_instance_and_store);

void wasm_run_compute_complete(benchmark::State& state) {
	for (auto _ : state) {
		wasmtime::Store wasmtime_store(global_wasmengine);
		auto wasm_instance =
			wasmtime::Instance::create(wasmtime_store, compute_mod, {}).unwrap();

		auto function = std::get<wasmtime::Func>(
			*wasm_instance.get(wasmtime_store, "function")
		);

		// execute wasm function
		function.call(wasmtime_store, {0, 0}).unwrap();
	}
}
BENCHMARK(wasm_run_compute_complete);

void wasm_run_noop_complete(benchmark::State& state) {
	for (auto _ : state) {
		wasmtime::Store wasmtime_store(global_wasmengine);
		auto wasm_instance =
			wasmtime::Instance::create(wasmtime_store, noop_mod, {}).unwrap();

		auto function = std::get<wasmtime::Func>(
			*wasm_instance.get(wasmtime_store, "function")
		);

		// execute wasm function
		function.call(wasmtime_store, {0, 0}).unwrap();
	}
}
BENCHMARK(wasm_run_noop_complete);

void wasm_run_noop_function_only(benchmark::State& state) {
	wasmtime::Store wasmtime_store(global_wasmengine);
	auto wasm_instance =
		wasmtime::Instance::create(wasmtime_store, noop_mod, {}).unwrap();

	auto function =
		std::get<wasmtime::Func>(*wasm_instance.get(wasmtime_store, "function")
	    );

	for (auto _ : state) {
		// execute wasm function
		function.call(wasmtime_store, {0, 0}).unwrap();
	}
}
BENCHMARK(wasm_run_noop_function_only);


void native_run_compute(benchmark::State& state) {
	for (auto _ : state) {
		auto hash = foo({});
		std::free(hash.data());
	}
}
BENCHMARK(native_run_compute);

} // namespace