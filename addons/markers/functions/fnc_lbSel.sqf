#include "../script_component.hpp"

params ["_control", "_lbCurSel"];

PARAM_INVALID(_control,"CONTROL")
PARAM_INVALID(_lbCurSel,"CONTROL")
GVAR_ISNIL(colorSlotParams)
GVAR_ISNIL(iconSlotParams)

_num = ctrlIDC (_control) - IDC_COMBO_00;
ctrlSetFocus (_display displayCtrl IDC_TEXT);
switch (_num < 6) do {
	case true: {
		_class = (_control) lbData (_lbCurSel);
		if (_class == "" or {_class == (GVAR(colorSlotParams) select _num)}) exitWith {};
		GVAR(colorSlotParams) set [_num,_class];
		profileNamespace setVariable [QGVAR(colorSlotParams), GVAR(colorSlotParams)];
		saveProfileNamespace;
		_slot_color = getArray (configFile >> "CfgMarkerColors" >> _class >> "color");

		{
			if (typeName _x != "SCALAR") then {
				_slot_color set [_forEachIndex, call compile _x];
			};
		} forEach _slot_color;
		((ctrlParent (_control)) displayCtrl (IDC_COLOR_00+_num)) ctrlSetTextColor [_slot_color select 0, _slot_color select 1, _slot_color select 2, 0.6];
		((ctrlParent (_control)) displayCtrl (IDC_COLOR_00+_num)) ctrlSetActiveColor _slot_color;
	};

	case false: {
		_class = (_control) lbData (_lbCurSel);
		if (_class == "" or {_class == (GVAR(iconSlotParams) select (_num-6))}) exitWith {};
		GVAR(iconSlotParams) set [_num-6,_class];
		profileNamespace setVariable [QGVAR(iconSlotParams), GVAR(iconSlotParams)];
		saveProfileNamespace;
		_slot_icon = getText (configFile >> "CfgMarkers" >> _class >> "icon");
		((ctrlParent (_control)) displayCtrl (IDC_ICON_00+_num-6)) ctrlSetText _slot_icon;
		((ctrlParent (_control)) displayCtrl (IDC_ICON_10+_num-6)) ctrlSetText _slot_icon;
	};
};