#include <algorithm>
#include <boost/iostreams/device/mapped_file.hpp>
#include <iostream>
#include <span>

int main(int argc, char* argv[]) {
	std::cerr << argv[1];
	boost::iostreams::mapped_file file(
		argv[1], boost::iostreams::mapped_file::readwrite
	);

	if (!file.is_open()) {
		std::cerr << "Error opening file: " << argv[1] << std::endl;
		return EXIT_FAILURE;
	}

	char* p = file.data();
	assert(p);

	auto r = std::span<char>{p, file.size()};
	std::ranges::reverse(r);
}
