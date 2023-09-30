// Including 'hpx/hpx_main.hpp' instead of the usual 'hpx/hpx_init.hpp' enables
// to use the plain C-main below as the direct main HPX entry point.
#include <hpx/chrono.hpp>
#include <hpx/config.hpp>
#include <hpx/hpx_init.hpp>
#include <hpx/include/actions.hpp>
#include <hpx/include/components.hpp>
#include <hpx/include/lcos.hpp>
#include <hpx/include/parallel_executors.hpp>
#include <hpx/include/runtime.hpp>
#include <hpx/include/util.hpp>
#include <hpx/iostream.hpp>
#include <hpx/modules/program_options.hpp>

#include <cstddef>
#include <cstdint>

auto func(std::vector<char> data) {
	// hpx::util::format_to(
	// 	hpx::cout, "hello world on locality {} {}", hpx::get_locality_id(),
	// 	data[0]
	// ) << std::endl;
}

HPX_PLAIN_ACTION(func, func_action)

int hpx_main() {
	hpx::util::format_to(hpx::cout, "window,msg_size,i,µs,MB/s\n");

	const auto remote = hpx::find_remote_localities().at(0);
	const auto iterations = 100;

	// warmup
	hpx::async<func_action>(remote, std::vector<char>(1000000, 'a')).get();

	for (auto iteration = 0z; iteration < iterations; ++iteration) {
		for (auto window_size : {1, 8, 64}) {
			for (long msg_size = 1; msg_size <= 1'000'000'000 / window_size;
			     msg_size *= 2) {
				std::vector<std::vector<char>> data(
					window_size, std::vector<char>(msg_size, 'a')
				);
				std::vector<hpx::future<void>> results(window_size);

				auto t = hpx::chrono::high_resolution_timer{};
				for (auto task = 0z; task < window_size; ++task) {
					results[task] =
						hpx::async<func_action>(remote, std::move(data[task]));
				}
				hpx::when_all(results).get();
				const auto elapsed = t.elapsed_microseconds();

				hpx::util::format_to(
					hpx::cout, "{},{},{},{},{}\n", window_size, msg_size,
					iteration, elapsed, double(msg_size) * window_size / elapsed
				)<<std::flush;
			}
		}
	}
	return hpx::finalize();
}

int main(int argc, char* argv[]) { return hpx::init(argc, argv); }
