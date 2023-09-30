#include <emscripten/emscripten.h>

#include <algorithm>
#include <cstdint>
#include <cstdlib>
#include <span>

extern "C" uint8_t get_byte();
extern "C" uint8_t more();
extern "C" void put_byte(uint8_t output);

extern "C" EMSCRIPTEN_KEEPALIVE void function() {
	while (more()) {
		put_byte(get_byte());
	}
}
