#include "../script_component.hpp"
/*
	Description:
	Handles client requests for all current markers, collecting and sending relevant marker data to the requesting player.

	Arguments:
		_player <OBJECT> - The player requesting marker data

	Returns:
		none

	Variables:
		GVAR(isPlayerBug) <ARRAY> - List of bugged players
		GVAR(sendJIP) <ARRAY> - Markers to send to the client
*/

params ["_player"];

PARAM_INVALID(_player,"OBJECT")
GVAR_ISNIL(isPlayerBug)

// Track bugged players if not a player
if (!isPlayer _player) then {
	if (GVAR(isPlayerBug) find _player == -1) then {
		GVAR(isPlayerBug) pushBack _player;
	};
};

// Helper: add markers for a given channel unit
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
				// Add side channel markers for player's side
				(side _player) call _addMarkers;
			};
			case "C": {
				// Add command channel markers if player is leader or commander
				if ((leader _player == _player) or (((effectiveCommander (vehicle _player)) == _player) and (isNull objectParent player))) then {
					(side _player) call _addMarkers;
				};
			};
			case "GL": {
				// Add all global markers
				GVAR(sendJIP) append _channelData;
			};
			case "V": {
				// Add vehicle channel markers if player not in vehicle
				if (isNull objectParent player) then {
					(vehicle _player) call _addMarkers;
				};
			};
			case "GR": {
				// Add group channel markers for player's group
				(group _player) call _addMarkers;
			};
		};
	};
} forEach ["S","S2","C","GL","V","GR"];

// Send collected marker data to requesting client
(owner _player) publicVariableClient QGVAR(sendJIP);