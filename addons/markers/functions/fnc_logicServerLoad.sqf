#include "../script_component.hpp"
/*
	Function: fnc_logicServerLoad

		Description:
			Handles loading of marker data for a player on the server, updating global marker state and notifying clients.

		Arguments:
			_player <Object> - The player object for whom the data is loaded
			_data   <Array>  - Array of marker data to load

		Returns:
			none

		Variables:
			GVAR(count)         <Scalar> - Global marker count
			GVAR(daytime)       <Scalar> - Reference daytime for marker timing
			GVAR(logicServer_S) <Array>  - Server-side marker storage
			GVAR(sendLoad)      <Array>  - Data to send to clients
			GVAR(isPlayerBug)   <Array>  - List of bugged players
*/

params ["_player", "_data"];

PARAM_INVALID(_player,"OBJECT")
PARAM_INVALID(_data,"ARRAY")
GVAR_ISNIL(count)
GVAR_ISNIL(daytime)
GVAR_ISNIL(logicServer_S)
GVAR_ISNIL(sendLoad)
GVAR_ISNIL(isPlayerBug)

// For each marker, increment count, update marker data, and append player info
{
	GVAR(count) = GVAR(count) + 1;
	_x set [0,"SWT_M#" + str GVAR(count)];
	_x set [1,"S"];
	_x pushBack (name _player);
	_x pushBack (dayTime - GVAR(daytime)) * 3600;
	_x pushBack true; // means loaded
	_x pushBack CBA_missionTime; // change time
} forEach _data;

// Store marker data for the player's side, append if already present
if (GVAR(logicServer_S) find (side _player) == -1) then {
	GVAR(logicServer_S) pushBack (side _player);
	GVAR(logicServer_S) pushBack _data;
} else {
	(GVAR(logicServer_S) select ((GVAR(logicServer_S) find (side _player)) + 1)) append _data;
};

// Notify clients of loaded markers
GVAR(sendLoad) = [_player, _data];
{
	if (isPlayer _x or {time == 0 and {_player in GVAR(isPlayerBug)}}) then {
		if (side _player == side _x) then {
			(owner _x) publicVariableClient QGVAR(sendLoad);
			// If SP, process directly
			if (!isMultiplayer and {_x == player}) then {GVAR(sendLoad) call FUNC(clientLogicLoad)};
		};
	};
} forEach (playableUnits + switchableUnits);

// Trigger marker creation events for each marker
{
	[QFUNC(createMarker), [_player, _x]] call CBA_fnc_localEvent;
} forEach _data;