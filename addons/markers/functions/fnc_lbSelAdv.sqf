#include "../script_component.hpp"
/*
	Function: fnc_lbSelAdv

		Description:
			Handles selection changes in the advanced color and icon listboxes, updating global parameters and UI previews accordingly.

		Arguments:
			_control   <Control>  - The listbox control.
			_index     <Scalar>   - The selected index.

		Returns:
			none

		Variables:
			_class, _controls_icon_pic
*/

params ["_control", "_index"];

PARAM_INVALID(_control,"CONTROL")
PARAM_INVALID(_index,"SCALAR")
GVAR_ISNIL(markColor)
GVAR_ISNIL(markType)
GVAR_ISNIL(pic)
GVAR_ISNIL(colorArr)

ctrlSetFocus ((ctrlParent _control) displayCtrl IDC_TEXT);

switch (ctrlIDC _control) do 
{
	case IDC_LB_COLOR: 
	{
		// Update global color based on selection
		private _class = _control lbData _index;
		GVAR(markColor) = _class;
		GVAR(colorArr) = getArray (configFile >> "CfgMarkerColors" >> GVAR(markColor) >> "color");
		{
			// Convert non-scalar color values
			if (typeName _x != "SCALAR") then 
			{
				GVAR(colorArr) set [_forEachIndex, call compile _x];
			};
		} forEach GVAR(colorArr);

		// Update color preview controls
		((ctrlParent _control) displayCtrl IDC_PICTURE) ctrlSetTextColor GVAR(colorArr);
		{
			((ctrlParent _control) displayCtrl _x) ctrlSetTextColor GVAR(colorArr);
		} forEach _controls_icon_pic;
	};

	case IDC_LB_PIC: 
	{
		// Update global icon based on selection
		private _class = _control lbData _index;
		GVAR(markType) = _class;
		GVAR(pic) = getText (configFile >> "cfgMarkers" >> GVAR(markType) >> "icon");
		// Update icon preview control
		((ctrlParent _control) displayCtrl IDC_PICTURE) ctrlSetText GVAR(pic);
	};
};