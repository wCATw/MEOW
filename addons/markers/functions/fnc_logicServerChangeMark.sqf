#include "../script_component.hpp"

params ["_action", "_player", "_mark_id", "_channel"];

TRACE_4("called logicServerChangeMark with params:",_action,_player,_mark_id,_channel);

private ["_pos","_dir", "_ctime"];

private _processMarker = {
	params ["_action", "_markParams", "_arr", "_index"];

	TRACE_4("called _processMarker in logicServerChangeMark with params:",_action,_markParams,_arr,_index);

	switch (toUpper _action) do {
		case "DIR": {
			_markParams set [6,_dir];
		};

		case "DEL": {
			_arr deleteAt _index;
		};

		case "POS": {
			_markParams set [3,_pos];
		};
	};
};

private _findChangeMarkers = {
	params ["_channelUnit"];

	TRACE_1("called _findChangeMarkers in logicServerChangeMark with params:",_channelUnit);

	private ['_find', "_num"];

	_find = false;
	_num = _channelData find _channelUnit;
	if (_num != -1) then {
		{
			if (_x select 0 == _mark_id) exitWith {
				[_action, _x, _channelData select (_num + 1), _forEachIndex] call _processMarker;
				_find = true;
			};
		} forEach (_channelData select (_num + 1));
	};

	if (!_find) then {
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

switch (_action) do {
	case "DIR": {
		_dir = _this select 4;
		GVAR(sendDir) = [_mark_id,_dir,_player,_ctime];
		///////////////////////////
		// OCAP
		[QGVAR(sendDir), GVAR(sendDir)] call CBA_fnc_localEvent;
		///////////////////////////
		publicVariable QGVAR(sendDir);
		if (hasInterface) then {GVAR(sendDir) call FUNC(clientLogicDir)};
	};

		case "DEL": {
		GVAR(sendDel) = [_mark_id,_player];
		///////////////////////////
		// OCAP
		[QGVAR(sendDel), GVAR(sendDel)] call CBA_fnc_localEvent;
		///////////////////////////
		publicVariable QGVAR(sendDel);
		if (hasInterface) then {GVAR(sendDel) call FUNC(clientLogicDel)};
	};

	case "POS": {
		_pos = _this select 4;
		GVAR(sendPos) = [_mark_id,_pos,_player,_ctime];
		///////////////////////////
		// OCAP
		[QGVAR(sendPos), GVAR(sendPos)] call CBA_fnc_localEvent;
		///////////////////////////
		publicVariable QGVAR(sendPos);
		if (hasInterface) then {GVAR(sendPos) call FUNC(clientLogicPos)};
	};
};


_channelData = missionNamespace getVariable (DOUBLES(GVAR(logicServer),_channel));

if (_channelData isNotEqualTo []) then {
	switch _channel do {
		case "S": {
			(side _player) call _findChangeMarkers;
		};
		case "C": {
			(side _player) call _findChangeMarkers;
		};
		case "V": {
			(vehicle _player) call _findChangeMarkers;
		};
		case "GR": {
			(group _player) call _findChangeMarkers;
		};
		case "D": {
			// do nothing
		};
		case "GL": {
			{
				if (_x select 0 == _mark_id) exitWith {
					[_action, _x, _channelData, _forEachIndex] call _processMarker;
				};
			} forEach _channelData;
		};
	};
};