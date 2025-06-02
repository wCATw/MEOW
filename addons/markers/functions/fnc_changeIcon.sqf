#include "../script_component.hpp"
	/*
		Function: fnc_changeIcon

			Description:
				Changes the current marker icon to the next or previous icon in the icon slot parameters, updating the preview in the UI.

			Arguments:
				_display   <Display>  - The display containing the icon control.
				_dir       <String>   - Direction to change ("UP" or "DOWN").
				Global:
					iconSlotParams <Array> - List of available icon types (read)
					markType       <String> - Current marker type (read/set)
					pic            <String> - Current marker icon path (read/set)

			Returns:
				none
				Global:
					markType <String> - Updated marker type (set)
					pic      <String> - Updated marker icon path (set)

			Variables:
				_control    <Control>  - The icon control.
				_curr_num   <Number>   - Current icon index.
	*/

params ["_display", "_dir"];

PARAM_INVALID(_display,"DISPLAY")
PARAM_INVALID(_dir,"STRING")
GVAR_ISNIL(iconSlotParams)
GVAR_ISNIL(markType)
GVAR_ISNIL(pic)

private _control = _display displayCtrl IDC_PICTURE;
private _curr_num = GVAR(iconSlotParams) find GVAR(markType);

// Change icon index based on direction, wrap if out of bounds
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

// Update global marker type and icon preview
GVAR(markType) = GVAR(iconSlotParams) select _curr_num;
GVAR(pic) = getText (configFile >> "cfgMarkers" >> GVAR(markType) >> "icon");
_control ctrlSetText GVAR(pic);
