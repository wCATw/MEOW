#include "../script_component.hpp"
/*
	Description:
	Handles server-side changes to existing markers (direction, position, deletion) and propagates updates to clients.

	Arguments:
		_action <STRING> - The type of change ("DIR", "DEL", "POS")
		_player <OBJECT> - The player requesting the change
		_mark_id <STRING> - The marker ID to change
		_channel <STRING> - The marker channel
		_changedParam <ANY> - The new value for the change (direction or position)

	Returns:
		none

	Variables:
		GVAR(sendDir) <ARRAY> - Data for direction change
		GVAR(sendDel) <ARRAY> - Data for deletion
		GVAR(sendPos) <ARRAY> - Data for position change
		_channelData <ARRAY> - Channel marker data
*/

params ["_action", "_player", "_mark_id", "_channel","_changedParam"];

PARAM_INVALID(_action,"STRING")
PARAM_INVALID(_player,"OBJECT")
PARAM_INVALID(_mark_id,"STRING")
PARAM_INVALID(_channel,"STRING")

private ["_dir", "_ctime"];

// Updates marker data in the array for direction, deletion, or position
private _processMarker = {
	params ["_action", "_markParams", "_arr", "_index", "_pos"];

	switch (toUpper _action) do {
		case "DIR": {
			_markParams set [6,_dir]; // Update direction
		};

		case "DEL": {
			_arr deleteAt _index; // Remove marker
		};

		case "POS": {
			_markParams set [3,_pos]; // Update position
		};
	};
};

// Finds marker in channel data and applies the change
private _findChangeMarkers = {
	params ["_channelUnit"];

	private ['_find', "_num"];

	_find = false;
	_num = _channelData find _channelUnit;
	if (_num != -1) then {
		// Search for marker in the channel's marker array
		{
			if (_x select 0 == _mark_id) exitWith {
				[_action, _x, _channelData select (_num + 1), _forEachIndex] call _processMarker;
				_find = true;
			};
		} forEach (_channelData select (_num + 1));
	};

	if (!_find) then {
		// Fallback: search all marker arrays in channel data
		for [{_i=1}, {_i<(count _channelData)&&!_find},{_i=_i+2}] do {
			{
				if (_x select 0 == _mark_id) exitWith {
					[_action, _x, (_channelData select _i), _forEachIndex] call _processMarker;
					_find = true;
				};
			} forEach (_channelData select _i);
		};
	};
	if (!_find) then {diag_log "CHANGE MARKER FAIL: CAN'T FIND DATA";};
};

_dir = 0;
_pos = [];
_ctime = CBA_missionTime;

// Broadcast change to clients and trigger local events
switch (_action) do {
	case "DIR": {
		_dir = _changedParam;
		GVAR(sendDir) = [_mark_id,_dir,_player,_ctime];
		[QGVAR(sendDir), GVAR(sendDir)] call CBA_fnc_localEvent;
		publicVariable QGVAR(sendDir);
		if (hasInterface) then {GVAR(sendDir) call FUNC(clientLogicDir)};
	};

	case "DEL": {
		GVAR(sendDel) = [_mark_id,_player];
		[QGVAR(sendDel), GVAR(sendDel)] call CBA_fnc_localEvent;
		publicVariable QGVAR(sendDel);
		if (hasInterface) then {GVAR(sendDel) call FUNC(clientLogicDel)};
	};

	case "POS": {
		_pos = _changedParam;
		GVAR(sendPos) = [_mark_id,_pos,_player,_ctime];
		[QGVAR(sendPos), GVAR(sendPos)] call CBA_fnc_localEvent;
		publicVariable QGVAR(sendPos);
		if (hasInterface) then {GVAR(sendPos) call FUNC(clientLogicPos)};
	};
};

// Get marker data for the relevant channel
_channelData = missionNamespace getVariable (format ["%1_%2",GVAR(logicServer),_channel]);

if (_channelData isNotEqualTo []) then {
	switch _channel do {
		case "S": {
			// Side channel: update marker for player's side
			(side _player) call _findChangeMarkers;
		};
		case "C": {
			// Command channel: update marker for player's side
			(side _player) call _findChangeMarkers;
		};
		case "V": {
			// Vehicle channel: update marker for player's vehicle
			(vehicle _player) call _findChangeMarkers;
		};
		case "GR": {
			// Group channel: update marker for player's group
			(group _player) call _findChangeMarkers;
		};
		case "D": {
			// Direct channel: do nothing
		};
		case "GL": {
			// Global channel: search and update marker in global array
			{
				if (_x select 0 == _mark_id) exitWith {
					[_action, _x, _channelData, _forEachIndex] call _processMarker;
				};
			} forEach _channelData;
		};
	};
};
