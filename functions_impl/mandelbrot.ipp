
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
} // namespace

auto foo(std::span<char> /*input*/) {
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

	// throwing new unfortunately cannot be used in wasm
	auto* iters_mem =
		static_cast<unsigned char*>(std::malloc(Res.size() * Ims.size()));
	auto iters = std::span(iters_mem, Res.size() * Ims.size());

	std::int64_t idx = 0;
	for (auto im : Ims) {
		for (auto re : Res) {
			iters[idx++] = iterations_to_diverge(std::complex{re, im});
		}
	}
	auto hash = std::accumulate(
		iters.begin(), iters.end(), std::uint64_t(0), std::plus<>{}
	);
	std::free(iters_mem);

	// this memory leak is fine, since the wasm instance is terminated after
	// this function returns
	char* result_mem = static_cast<char*>(std::malloc(sizeof(hash)));
	std::memcpy(result_mem, &hash, sizeof(hash));
	return std::span(result_mem, sizeof(hash));
}
