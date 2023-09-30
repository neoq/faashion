
#include <hpx/hpx_init.hpp>
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
#include <thread>
#include <unordered_map>

int main(int argc, char* argv[]) { return hpx::init(argc, argv); }

int hpx_main() {
	const auto iterations = 1000000;

	for (auto iteration = 0z; iteration < iterations; ++iteration) {
		auto b = std::chrono::steady_clock::now();
		hpx::thread t([] {});
		t.join();
		auto e = std::chrono::steady_clock::now();
		hpx::util::format_to(
			hpx::cout, "{}\n", std::chrono::nanoseconds{e - b}.count()
		);
	}
	return hpx::finalize();
}