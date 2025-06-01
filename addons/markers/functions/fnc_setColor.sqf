#include "../script_component.hpp"

params ["_control", "_num"];

PARAM_INVALID(_control,"CONTROL")
PARAM_INVALID(_num,"SCALAR")
GVAR_ISNIL(markColor)
GVAR_ISNIL(colorSlotParams)
GVAR_ISNIL(colorArr)

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