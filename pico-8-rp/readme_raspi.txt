

PICO-8 for Raspberry Pi comes in several flavours included in this archive:

	pico8      // 32-bit with custom-built and statically linked sdl2
	pico8_dyn  // 32-bit, dynamically linked sdl2
	pico8_gpio // 32-bit, requires wiringpi for acessing gpio pins (0x5f80..0x5fff)
	pico8_64   // For 64-bit Rasperry Pi OS -- requires libsdl2.


:: Installing SDL2

	sdl2 is required for pico8_dyn, pico8_gpio and pico8_64. You can make sure it's installed with:

		$ sudo apt-get install libsdl2-dev


:: Installing wget

	PICO-8 uses wget for bbs downloads. If you have trouble download cartridges or cart listings, try:

		$ sudo apt-get install wget


:: Slow Framerate

	If you get a warning on boot "warning: running below 30fps", or PICO-8 seems to be running slowly
	in fullscreen, it might help to use the legacy OpenGL driver:

		$ raspi-config

		-> selected "Advanced" and then "GL Drivers"
		-> select the legacy gpu driver option



