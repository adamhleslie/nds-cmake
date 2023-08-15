//
// Created by Jeremy David on 17.04.15.
//

#pragma once

#include <nds.h>

inline int ds_float(int real, short frac)
{
	return ((real << 8) | frac);
}
