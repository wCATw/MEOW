/*
	Function: fnc_changeColor

		Description:
			Changes the current marker color to the next or previous color in the color slot parameters, updating the preview in the UI.

		Arguments:
			_display   <Display>  - The display containing the color control.
			_dir       <String>   - Direction to change ("UP" or "DOWN").

		Returns:
			none

		Variables:
			_control      <Control>  - The color control.
			_curr_num     <Number>   - Current color index.
*/

#include "../script_component.hpp"

params ["_display", "_dir"];

PARAM_INVALID(_display,"DISPLAY")
PARAM_INVALID(_dir,"STRING")
GVAR_ISNIL(markColor)
GVAR_ISNIL(colorSlotParams)
GVAR_ISNIL(colorArr)

private _control = _display displayCtrl IDC_PICTURE;
private _curr_num = GVAR(colorSlotParams) find GVAR(markColor);

switch (_dir) do {
	case 'UP': {
		_curr_num = _curr_num+1;
		// upper bound
		if (_curr_num>((count GVAR(colorSlotParams)) - 1)) then {_curr_num = 0};
	};

	case 'DOWN': {
		_curr_num = _curr_num-1;
		// lower bound
		if (_curr_num<0) then {_curr_num = (count GVAR(colorSlotParams)) - 1};
	};
};

// Updates the global marker color and color array.
GVAR(markColor) = GVAR(colorSlotParams) select _curr_num;
GVAR(colorArr) = getArray (configFile >> "CfgMarkerColors" >> GVAR(markColor) >> "color");

// Ensure all color array elements are scalars.
{
	if (typeName _x != "SCALAR") then {
		GVAR(colorArr) set [_forEachIndex, call compile _x];
	};
} forEach GVAR(colorArr);

// Updates the preview controls.
_control ctrlSetTextColor GVAR(colorArr);
{(_display displayCtrl _x) ctrlSetTextColor GVAR(colorArr)} forEach _controls_icon_pic;