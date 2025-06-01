#include "../script_component.hpp"

params ["_display", "_dir"];

PARAM_INVALID(_display,"DISPLAY")
PARAM_INVALID(_dir,"STRING")
GVAR_ISNIL(iconSlotParams)
GVAR_ISNIL(markType)
GVAR_ISNIL(pic)

private _control = _display displayCtrl IDC_PICTURE;
private _curr_num = GVAR(iconSlotParams) find GVAR(markType);
switch (_dir) do {
	case 'UP': {
		_curr_num = _curr_num+1;
		if (_curr_num>((count GVAR(iconSlotParams)) - 1)) then {_curr_num = 0};
	};

	case 'DOWN': {
		_curr_num = _curr_num-1;
		if (_curr_num<0) then {_curr_num = (count GVAR(iconSlotParams)) - 1};
	};
};
GVAR(markType) = GVAR(iconSlotParams) select _curr_num;
GVAR(pic) = getText (configFile >> "cfgMarkers" >> GVAR(markType) >> "icon");
_control ctrlSetText GVAR(pic);