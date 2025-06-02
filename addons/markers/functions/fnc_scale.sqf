#include "../script_component.hpp"
/*
	Function: fnc_scale
		Description:
			Scales and repositions the marker icon in the UI based on the current scaling factor (sweetkS).
		Arguments:
			none (uses global _display and GVAR(sweetkS))
		Returns:
			none
		Variables:
			_pos     <Array>   - Current position and size of the icon control.
			_c_x     <Number>  - Center X coordinate.
			_c_y     <Number>  - Center Y coordinate.
			_new_h   <Number>  - New height for the icon.
			_new_w   <Number>  - New width for the icon.
			_new_x   <Number>  - New X position for the icon.
			_new_y   <Number>  - New Y position for the icon.
*/

private ["_pos", "_c_x", "_c_y", "_new_h", "_new_w", "_new_x", "_new_y"];

// Get current icon position and size
_pos = ctrlPosition (_display displayCtrl IDC_PICTURE);

// Calculate center of icon
_c_x = (_pos select 0) + ((_pos select 2)/2);
_c_y = (_pos select 1) + ((_pos select 3)/2);

// Calculate new size based on scaling factor
_new_h = 0.0666667 * GVAR(sweetkS);
_new_w = 0.05 * GVAR(sweetkS);

// Calculate new position to keep icon centered
_new_x = _c_x - (_new_w/2);
_new_y = _c_y - (_new_h/2);

// Set new position and size, commit changes
(_display displayCtrl IDC_PICTURE) ctrlSetPosition [_new_x,_new_y,_new_w,_new_h];
(_display displayCtrl IDC_PICTURE) ctrlCommit 0;