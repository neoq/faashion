
#include <emscripten/emscripten.h>

#include <algorithm>
#include <cstdlib>
#include <span>

std::size_t output_size;

auto foo(std::span<char> input) {
	return input;
}

// return result ptr so function may reuse memory given to it
// this function can be considered an SDK
extern "C" EMSCRIPTEN_KEEPALIVE char* function(char* p, std::size_t size) {
	auto res = foo({p, size});
	output_size = res.size();
	return res.data();
}

extern "C" EMSCRIPTEN_KEEPALIVE std::size_t get_output_size() {
	return output_size;
}

extern "C" EMSCRIPTEN_KEEPALIVE void* alloc(std::size_t size) {
	return std::malloc(size);
}

extern "C" EMSCRIPTEN_KEEPALIVE void dealloc(void* p) { std::free(p); }
