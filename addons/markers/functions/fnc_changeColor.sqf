#include "../script_component.hpp"

params ["_display", "_dir"];

TRACE_2("called changeColor with params:",_display,_dir);

private _control = _display displayCtrl IDC_PICTURE;
private _curr_num = GVAR(colorSlotParams) find GVAR(markColor);
switch (_dir) do {
	case 'UP': {
		_curr_num = _curr_num+1;
		if (_curr_num>((count GVAR(colorSlotParams)) - 1)) then {_curr_num = 0};
	};

	case 'DOWN': {
		_curr_num = _curr_num-1;
		if (_curr_num<0) then {_curr_num = (count GVAR(colorSlotParams)) - 1};
	};
};
GVAR(markColor) = GVAR(colorSlotParams) select _curr_num;
GVAR(colorArr) = getArray (configFile >> "CfgMarkerColors" >> GVAR(markColor) >> "color");
{
	if (typeName _x != "SCALAR") then {
		GVAR(colorArr) set [_forEachIndex, call compile _x];
	};
} forEach GVAR(colorArr);
_control ctrlSetTextColor GVAR(colorArr);
{(_display displayCtrl _x) ctrlSetTextColor GVAR(colorArr)} forEach _controls_icon_pic;