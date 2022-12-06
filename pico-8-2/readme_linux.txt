
:: PICO-8 Linux Builds

	On many linux distributions, PICO-8 will run out of the box (just unzip and run pico8), but it does
	require wget to perform BBS downloads. To make sure wget is installed:

	$ sudo apt-get install wget


	You may need to ensure the pico8 file is executable:

	$ sudo chmod +x pico8

	
	There are two different builds in this archive:

		pico8      // statically linked sdl2
		pico8_dyn  // dynamically linked sdl2


	pico8_dyn can be used if you would like to provide your own sdl2, or to use the sdl2 built for your distribution:

	$ sudo apt-get install libsdl2-dev



:: Video Configuration


	By default, PICO-8 runs fullscreen using OpenGL to blit (via SDL2). A software blitter can be used instead:

	$ pico8 -software_blit 1

	Alt+Enter can be used to toggle fullscreen, or the -windowed switch can be used to start up in in a window:

	$ pico8 -windowed 1

	There are several methods for blitting to fullscreen:

	$ pico8 -fullscreen_method 0    // Maximized Window (default)       // SDL_WINDOW_SHOWN | SDL_WINDOW_BORDERLESS | SDL_WINDOW_MAXIMIZED | SDL_WINDOW_INPUT_GRABBED;
	$ pico8 -fullscreen_method 1    // Borderless Desktop-sized window  // SDL_WINDOW_FULLSCREEN_DESKTOP
	$ pico8 -fullscreen_method 2    // Hardware Fullscreen (erratic behaviour under some drivers)

	0 and 1 are very similar, but might behave differently on some distributions. 2 is normally not recommended or needed.

	These options can also be set in ~/.lexaloffle/pico-8/config.txt, which is generated when PICO-8 closes.




