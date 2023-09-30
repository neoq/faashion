#include <hpx/chrono.hpp>
#include <hpx/config.hpp>
#include <hpx/hpx_init.hpp>
#include <hpx/include/actions.hpp>
#include <hpx/include/components.hpp>
#include <hpx/include/lcos.hpp>
#include <hpx/include/parallel_executors.hpp>
#include <hpx/include/post.hpp>
#include <hpx/include/runtime.hpp>
#include <hpx/include/util.hpp>
#include <hpx/iostream.hpp>

#include <array>
#include <numeric>
#include <string>
#include <vector>

HPX_REGISTER_CHANNEL(char)
using vector_t = std::vector<char>;
HPX_REGISTER_CHANNEL(vector_t)

void func_char(hpx::lcos::channel<char> input) {
	for (auto d : input) {}
}
HPX_PLAIN_ACTION(func_char, func_char_action)
void func_chunk(hpx::lcos::channel<vector_t> input) {
	for (auto d : input) {}
}
HPX_PLAIN_ACTION(func_chunk, func_chunk_action)

int hpx_main() {
	hpx::util::format_to(hpx::cout, "method,msg_size,msg_count,µs,MB/s\n");

	const auto remote = hpx::find_remote_localities().at(0);
	const auto total_size = 100'000z;
	const auto max_msg_size = 10'000'000z;

	for (long msg_size = 1; msg_size <= max_msg_size; msg_size *= 2) {
		hpx::lcos::channel<vector_t> input(hpx::find_here());

		auto res = hpx::async<func_chunk_action>(remote, input);

		const auto msg_count = std::max(100z, total_size / msg_size);
		auto t = hpx::chrono::high_resolution_timer{};
		for (auto i = 0z; i <= msg_count; ++i) {
			input.set(vector_t(msg_size, 'a'));
		}
		input.close();
		res.get();
		const auto elapsed = t.elapsed_microseconds();

		hpx::util::format_to(
			hpx::cout, "chunk channel,{},{},{},{}\n", msg_size, msg_count,
			elapsed, double(msg_count) * msg_size / elapsed
		) << std::flush;
	}
	{
		hpx::lcos::channel<char> input(hpx::find_here());

		auto res = hpx::async<func_char_action>(remote, input);

		auto t = hpx::chrono::high_resolution_timer{};
		for (auto i = 0z; i <= total_size; ++i) {
			input.set('a');
		}
		input.close();
		res.get();
		const auto elapsed = t.elapsed_microseconds();

		hpx::util::format_to(
			hpx::cout, "char channel,{},{},{},{}\n", 1, total_size, elapsed,
			double(total_size) * 1 / elapsed
		) << std::flush;
	}
	return hpx::finalize(); // Initiate shutdown of the runtime system.
}

int main(int argc, char* argv[]) {
	return hpx::init(argc, argv); // Initialize and run HPX.
}
