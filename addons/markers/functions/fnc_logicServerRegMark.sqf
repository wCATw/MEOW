#include "../script_component.hpp"
/*
	Description:
	Registers a new marker on the server, assigns it to the correct channel, and notifies relevant clients.

	Arguments:
		_player <OBJECT> - The player creating the marker
		_markArr <ARRAY> - Marker parameters array

	Returns:
		none

	Variables:
		GVAR(count) <SCALAR> - Global marker count
		GVAR(groupMarkersViaRadio) <SCALAR> - Group marker radio setting
		GVAR(daytime) <SCALAR> - Reference daytime for marker timing
		GVAR(isPlayerBug) <ARRAY> - List of bugged players
		GVAR(sendMark) <ARRAY> - Data to send to clients
		GVAR(logicServer_GL) <ARRAY> - Global channel marker storage
*/

params ["_player", "_markArr"];

PARAM_INVALID(_player,"OBJECT")
PARAM_INVALID(_markArr,"ARRAY")
GVAR_ISNIL(count)
GVAR_ISNIL(groupMarkersViaRadio)
GVAR_ISNIL(daytime)
GVAR_ISNIL(isPlayerBug)

private ["_channel", "_cond", "_units"];

// Adds marker to the correct channel data structure
private _addToChannel = { 
	params ["_channelData", "_channelSide", "_markArr"];

	PARAM_INVALID(_channelData,"STRING")
	PARAM_INVALID(_channelSide,"SIDE") // CAN BE STRING
	PARAM_INVALID(_markArr,"ARRAY")

	_channelData = missionNamespace getVariable (format ["%1_%2",GVAR(logicServer),_channelData]);
	if (_channelData find _channelSide == -1) then {
		_channelData pushBack _channelSide;
		_channelData pushBack [_markArr];
	} else {
		(_channelData select ((_channelData find _channelSide) + 1)) pushBack _markArr;
	};
};

_channel = _markArr select 1;
_markArr pushBack (dayTime - GVAR(daytime)) * 3600;
GVAR(count) = GVAR(count) + 1;
_markArr set [0, format ["SWT_M#%1", (str GVAR(count))]];
_markArr set [10, false];
_markArr set [11, CBA_missionTime];
GVAR(sendMark) = _markArr;
_cond = "";
_units = [];

// Trigger marker creation event for OCAP
[QFUNC(createMarker), [_player, GVAR(sendMark)]] call CBA_fnc_localEvent;

// Assign marker to the correct channel and determine recipients
switch (_channel) do {
	// Side channel: assign to side, notify all players
	case "S": {
		_cond = QUOTE((side _x == side _player));
		[_channel, side _player, _markArr] call _addToChannel;
		_units = (playableUnits+switchableUnits);
	};
	// Command channel: assign to side, notify leaders and player
	case "C": {
		_cond = QUOTE(((((leader _x == _x) or (((effectiveCommander (vehicle _x)) == _x) and (vehicle _x != _x))) and (side _x == side _player)) or (_player == _x)));
		[_channel, side _player, _markArr] call _addToChannel;
		_units = (playableUnits+switchableUnits);
	};
	// Global channel: add to global array, notify all
	case "GL": {
		_cond = QUOTE(true);
		GVAR(logicServer_GL) pushBack _markArr;
		_units = (playableUnits+switchableUnits);
	};
	// Vehicle channel: assign to vehicle, notify crew
	case "V": {
		_cond = QUOTE((_x in vehicle _player));
		[_channel, vehicle _player, _markArr] call _addToChannel;
		_units = (playableUnits+switchableUnits);
	};
	// Group channel: assign to group, notify group or all if radio enabled
	case "GR": {
		_cond = QUOTE(((group _x == group _player) || (GVAR(groupMarkersViaRadio) > 0 && {(side _x isEqualTo side _player) && {([ARR_2(_player,_x)] call FUNC(listenSameTFRadio))}})));
		[_channel, group _player, _markArr] call _addToChannel;
		_units = if (GVAR(groupMarkersViaRadio) > 0) then {
			playableUnits+switchableUnits
		} else {
			units group _player
		};
	};
	// Direct channel: notify players within 15m
	case "D": {
		_cond = QUOTE((_x distance _player < 15));
		_units = (playableUnits+switchableUnits);
	};
};

// Notify relevant clients and handle SP
{
	if (isPlayer _x or {time==0 and {_player in GVAR(isPlayerBug)}}) then {
		private _cond_x = call compile _cond;
		if _cond_x then {
			(owner _x) publicVariableClient QGVAR(sendMark);
			if (!isMultiplayer and {_x == player}) then {
				GVAR(sendMark) call FUNC(clientLogicCreate)
			};
		};
	};
} forEach _units;
