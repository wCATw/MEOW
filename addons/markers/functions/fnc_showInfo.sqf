#include "../script_component.hpp"
/*
	Function: fnc_showInfo

		Description:
			Displays detailed information about a marker when hovering or interacting with it on the map UI. Shows marker ID, type, channel, and time info in a structured text control.

		Arguments:
			_control   <Control>  - The map control being interacted with.
			Global:
				hold            <Bool>   - Hold state for info display (read/set)
				mapTime         <Scalar> - Map time for info display (read/set)
				allMarkersParams<Array>  - All marker parameters (read)
				daytime         <Scalar> - Mission daytime (read)
				posM            <Array>  - Marker position (read)

		Returns:
			none
			Global:
				hold            <Bool>   - Hold state for info display (set)
				mapTime         <Scalar> - Map time for info display (set)

		Variables:
			_control        <Control>  - The map control.
			_ctrl_info      <Control>  - The info display control.
			_find           <Bool>     - Whether a marker was found under the cursor.
*/

params ["_control"];

PARAM_INVALID(_control,"CONTROL")

GVAR_ISNIL(hold)
GVAR_ISNIL(mapTime)
GVAR_ISNIL(allMarkersParams)
GVAR_ISNIL(daytime)
GVAR_ISNIL(posM)


private ["_ctrl_info", "_find"];

_ctrl_info = _display displayCtrl IDC_BUTTON_ADV;
_find = false;

{
	private ["_pos"];
	_pos = getMarkerPos (_x select 0);
	_pos = _control ctrlMapWorldToScreen _pos;
	if (([_pos,GVAR(posM)] call BIS_fnc_distance2D) < 0.025) exitWith {
		_find = true;
		if (GVAR(hold)) then {
			// Marker found under cursor, show info in structured text
			private ["_mark", "_id", "_name", "_channel", "_time", "_Type", "_ctime"];

			_mark = _x select 0;
			_id = + toArray (_mark);
			_id deleteRange [0,6];
			_id = toString (_id);
			_name = _x select 8;
			_channel = _x select 1;
			_channel = [_channel,"t"] call FUNC(getColorChannel);
			_time = _x select 9;
			_Type = _x select 4;
			_ctime = _x select 11;
			_ctrl_info ctrlSetStructuredText parseText format [
				"<t size='0.8'><t align='center' color='#F88379'>%1 ID: %2" 
				+ (if (!isNil {_x select 10} && {_x#10}) then {
					localize LSTRING(INFOLOADED)
				} else {""}) 
				+ "</t><br/>" 
				+ (localize LSTRING(INFOWIN)) 
				+ format [
					"%1 | %2 [%3m]", 
					[_time] call FUNC(getFormatedTime), 
					[(GVAR(daytime) * 3600) + _time] call FUNC(getFormatedTime),
					floor(abs(CBA_missionTime - _ctime) / 60)
				] 
				+ "</t>",
				(if (_Type==-2) then {
					localize LSTRING(LINE)
				} else {
					if (_Type==-3) then {
						localize LSTRING(ELLIPSE)
					} else {
						localize LSTRING(MARKER)
					}
				}),
				_id,
				_name,
				_channel
			];

			_ctrl_pos = ctrlPosition _ctrl_info;
			// Position info box left/right of marker depending on marker text
			if ((markerText _mark) == "") then {
				_ctrl_info ctrlSetPosition [
					(_pos select 0) - (0.05)/2 + 0.07,
					(_pos select 1) - (_ctrl_pos select 3)/2,
					_ctrl_pos select 2,
					_ctrl_pos select 3
				];
			} else {
				_ctrl_info ctrlSetPosition [
					(_pos select 0) + (0.05)/2 - 0.07 - (_ctrl_pos select 2),
					(_pos select 1) - (_ctrl_pos select 3)/2,
					_ctrl_pos select 2,
					_ctrl_pos select 3
				];
			};
			_ctrl_info ctrlCommit 0;
			_ctrl_info ctrlShow true;
		};
	};
} forEach GVAR(allMarkersParams);

// If no marker found, hide info and reset states
if (!_find) then {
	_ctrl_info ctrlShow false;
	GVAR(hold) = false;
	GVAR(mapTime) = 0;
};
