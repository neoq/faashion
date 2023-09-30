
CXXFLAGS = -std=c++23 -Wall -g -I/home/neop/Documents/dev/libneop/include -O2 -march=native -fsanitize=undefined

mandelbrot.png : mandelbrot.pgm
	pamtopng $< > $@

mandelbrot.pgm : main
	./$< > $@

main : main.cpp
	g++ $(CXXFLAGS) $^ -o $@
	