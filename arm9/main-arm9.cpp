/*---------------------------------------------------------------------------------

	Simple console print demo
	-- dovoto

---------------------------------------------------------------------------------*/

#include <nds.h>
#include <cstdio>
#include "init.hpp"
#include <starField.h>

static const int DMA_CHANNEL = 3;

int main()
{
	touchPosition touch;

	powerOn(POWER_ALL_2D);

	initVideo();
	initBackgrounds();

	auto mainBackground3Address = (uint16*) BG_BMP_RAM(0);

	// starFieldBitmap and starFieldBitmapLen generated for us by grit - see starField.h
	dmaCopyHalfWords(DMA_CHANNEL, starFieldBitmap, mainBackground3Address, starFieldBitmapLen);

	// set up the sub screen for printing
	consoleDemoInit();

	iprintf("\n\n\tThis was a triumph\n");
	iprintf("\tI'm making a note here:\n");
	iprintf("\n\tHuge success");

	while (true)
	{
		touchRead(&touch);
		iprintf("\x1b[10;0HTouch x = %04i, %04i\n", touch.rawx, touch.px);
		iprintf("Touch y = %04i, %04i\n", touch.rawy, touch.py);

		swiWaitForVBlank();
		scanKeys();
		if (keysDown() & KEY_START)
		{
			break;
		}
	}

	return 0;
}
