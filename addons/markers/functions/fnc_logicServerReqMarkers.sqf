#include "../script_component.hpp"

params ["_player"];

TRACE_1("called logicServerReqMark with params:",_player);

if (!isPlayer _player) then {
	if (GVAR(isPlayerBug) find _player == -1) then {
		GVAR(isPlayerBug) pushBack _player;
	};
};

private _addMarkers = {
	private _channelUnit = _this;
	private _num = _channelData find _channelUnit;
	if (_num != -1) then {
		GVAR(sendJIP) append (_channelData select (_num + 1));
	};
};

GVAR(sendJIP) = [];
{
	private _channelData = missionNamespace getVariable (format ["%1_%2", QGVAR(logicServer), _x]);
	if (_channelData isNotEqualTo []) then {
		switch _x do {
			case "S": {
				(side _player) call _addMarkers;
			};
			case "C": {
				if ((leader _player == _player) or (((effectiveCommander (vehicle _player)) == _player) and (isNull objectParent player))) then {
					(side _player) call _addMarkers;
				};
			};
			case "GL": {
				GVAR(sendJIP) append _channelData;
			};
			case "V": {
				if (isNull objectParent player) then {
					(vehicle _player) call _addMarkers;
				};
			};
			case "GR": {
				(group _player) call _addMarkers;

			};
		};
	};
} forEach ["S","S2","C","GL","V","GR"];
(owner _player) publicVariableClient QGVAR(sendJIP);