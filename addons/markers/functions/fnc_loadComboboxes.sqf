#include "../script_component.hpp"

params ["_display"];

PARAM_INVALID(_display,"DISPLAY")
GVAR_ISNIL(cfgMarkers)
GVAR_ISNIL(cfgMarkerColors)
GVAR_ISNIL(iconSlotParams)
GVAR_ISNIL(colorSlotParams)

private ['_combo_color',"_combo_icon"];
_combo_color = [IDC_COMBO_00,IDC_COMBO_01,IDC_COMBO_02,IDC_COMBO_03,IDC_COMBO_04,IDC_COMBO_05];
_combo_icon = [IDC_COMBO_06,IDC_COMBO_07,IDC_COMBO_08,IDC_COMBO_09,IDC_COMBO_10,IDC_COMBO_11];

{
	private ["_marker", "_scope", "_pic", "_name"];

	_marker	= _x;
	_scope = getNumber (_marker >> "scope");
	_pic = getText (_marker >> "icon");
	_name = getText (_marker >> "name");

	{
		private ["_index"];

		_index = (_display displayCtrl _x) lbAdd _name;
		(_display displayCtrl _x) lbSetPicture [_index, _pic];
		(_display displayCtrl _x) lbSetData [_index, configName _marker];
		if ((configName _marker) isEqualTo (GVAR(iconSlotParams) select _forEachIndex)) then {
			(_display displayCtrl _x) lbSetCurSel _index;
		};
	} forEach _combo_icon;
} forEach GVAR(cfgMarkers);

{
	private ["_colorType", "_markColor", "_name"];

	_colorType= _x;
	_markColor = getArray (_colorType >> "color");
	_name = getText (_colorType >> "name");

	{
		if (typeName _x != "SCALAR") then {
			_markColor set [_forEachIndex, call compile _x];
		};
	} forEach _markColor;

	{
		private ["_index"];

		_index = (_display displayCtrl _x) lbAdd _name;
		(_display displayCtrl _x) lbSetPicture [_index, format["#(argb,8,8,3)color(%1,%2,%3,%4)", _markColor select 0, _markColor select 1, _markColor select 2, _markColor select 3]];
		(_display displayCtrl _x) lbSetData [_index, configName _colorType];
		if ((configName _colorType) isEqualTo (GVAR(colorSlotParams) select _forEachIndex)) then {
			(_display displayCtrl _x) lbSetCurSel _index;
		};

	} forEach _combo_color;
} forEach GVAR(cfgMarkerColors);

