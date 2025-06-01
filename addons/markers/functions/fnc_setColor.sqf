#include "../script_component.hpp"
/*
	Function: fnc_setColor
		Description:
			Sets the marker color and updates the color preview for all relevant UI controls when a user selects a new color.
		Arguments:
			_control   <Control>  - The control that triggered the color change.
			_num       <Scalar>   - The index of the selected color in the color slot parameters.
		Returns:
			none
		Variables:
			none
*/

params ["_control", "_num"];

PARAM_INVALID(_control,"CONTROL")
PARAM_INVALID(_num,"SCALAR")
GVAR_ISNIL(markColor)
GVAR_ISNIL(colorSlotParams)
GVAR_ISNIL(colorArr)

private ["_controls_icon_pic"];

// List of icon controls to update color for
_controls_icon_pic = [IDC_ICON_10,IDC_ICON_11,IDC_ICON_12,IDC_ICON_13,IDC_ICON_14,IDC_ICON_15];

// Update global marker color variable
GVAR(markColor) = GVAR(colorSlotParams) select _num;

// Focus text input after color selection
ctrlSetFocus ((ctrlParent _control) displayCtrl IDC_TEXT);

GVAR(colorArr) = getArray (configFile >> "CfgMarkerColors" >> GVAR(markColor) >> "color");

{
	if (typeName _x != "SCALAR") then {
		GVAR(colorArr) set [_forEachIndex, call compile _x];
	};
} forEach GVAR(colorArr);

// Update color for all icon preview controls
{
	((ctrlParent _control) displayCtrl _x) ctrlSetTextColor GVAR(colorArr);
} forEach _controls_icon_pic+[IDC_PICTURE];
