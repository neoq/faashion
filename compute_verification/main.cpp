#include <algorithm>
#include <cmath>
#include <complex>
#include <cstdint>
#include <fstream>
#include <iostream>
#include <numeric>
#include <ranges>
#include <vector>

namespace {
using scalar_t = double;
const scalar_t inf = std::numeric_limits<scalar_t>::infinity();
const int max_iterations = 100;
const int divergent_threashold = 2;

auto iterations_to_diverge(const std::complex<scalar_t>& c) {
	unsigned char n = 0;
	auto zn = c;
	for (;; ++n) {
		auto diverges = [&] { return std::abs(zn) > divergent_threashold; };

		if (diverges() || n >= max_iterations)
			return n;
		zn = zn * zn + c;
	}
}

auto map_to_color(unsigned char iters) {
	return (iters * 255) / max_iterations;
}
} // namespace

int main() {
	namespace views = std::views;
	using namespace std::complex_literals;
	const auto im_lower = -1.0;
	const auto im_upper = 1.0;
	const auto re_lower = -2.0;
	const auto re_upper = 1.0;
	const auto samples_per_unit = 1000;

	const auto re_samples = int(samples_per_unit * (re_upper - re_lower));
	const auto im_samples = int(samples_per_unit * (im_upper - im_lower));

	auto Ims = views::iota(0, im_samples) |
	           views::transform([=](auto idx) -> scalar_t {
				   return idx * (im_upper - im_lower) / im_samples + im_lower;
			   });
	auto Res = views::iota(0, re_samples) |
	           views::transform([=](auto idx) -> scalar_t {
				   return idx * (re_upper - re_lower) / re_samples + re_lower;
			   });

	std::cout << "P2\n" << Res.size() << ' ' << Ims.size() << "\n255\n";

	std::vector<unsigned char> iters(Ims.size() * Res.size());

	std::int64_t idx = 0;
	for (auto im : Ims) {
		for (auto re : Res) {
			iters[idx++] = iterations_to_diverge(std::complex{re, im});
		}
	}

	std::ofstream hashfile("hash.bin", std::ios::binary);
	auto hash = std::accumulate(
		iters.begin(), iters.end(), std::uint64_t(0), std::plus<>{}
	);
	hashfile.write(reinterpret_cast<const char*>(&hash), sizeof(hash));

	std::ranges::copy(
		iters | views::transform(map_to_color),
		std::ostream_iterator<int>(std::cout, " ")
	);
}