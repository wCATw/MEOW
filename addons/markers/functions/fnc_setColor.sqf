#include "../script_component.hpp"

params ["_control", "_num"];

TRACE_2("called setColor with params:",_control,_num);

private ["_controls_icon_pic"];

_controls_icon_pic = [IDC_ICON_10,IDC_ICON_11,IDC_ICON_12,IDC_ICON_13,IDC_ICON_14,IDC_ICON_15];
GVAR(markColor) = GVAR(colorSlotParams) select _num;
ctrlSetFocus ((ctrlParent _control) displayCtrl IDC_TEXT);
GVAR(colorArr) = getArray (configFile >> "CfgMarkerColors" >> GVAR(markColor) >> "color");
{
	if (typeName _x != "SCALAR") then {
		GVAR(colorArr) set [_forEachIndex, call compile _x];
	};
} forEach GVAR(colorArr);

{
	((ctrlParent _control) displayCtrl _x) ctrlSetTextColor GVAR(colorArr);
} forEach _controls_icon_pic+[IDC_PICTURE];