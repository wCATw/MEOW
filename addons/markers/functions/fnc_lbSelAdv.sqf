#include "../script_component.hpp"

params ["_control", "_index"];

TRACE_2("called lbSelAdv with params:",_control,_index);

ctrlSetFocus ((ctrlParent _control) displayCtrl IDC_TEXT);
switch (ctrlIDC _control) do {
	case IDC_LB_COLOR: {
		private _class = _control lbData _index;
		GVAR(markColor) = _class;
		GVAR(colorArr) = getArray (configFile >> "CfgMarkerColors" >> GVAR(markColor) >> "color");
		{
			if (typeName _x != "SCALAR") then {
				GVAR(colorArr) set [_forEachIndex, call compile _x];
			};
		} forEach GVAR(colorArr);

		((ctrlParent _control) displayCtrl IDC_PICTURE) ctrlSetTextColor GVAR(colorArr);
		{
			((ctrlParent _control) displayCtrl _x) ctrlSetTextColor GVAR(colorArr);
		} forEach _controls_icon_pic;
	};

	case IDC_LB_PIC: {
		private _class = _control lbData _index;
		GVAR(markType) = _class;
		GVAR(pic) = getText (configFile >> "cfgMarkers" >> GVAR(markType) >> "icon");
		((ctrlParent _control) displayCtrl IDC_PICTURE) ctrlSetText GVAR(pic);
	};
};