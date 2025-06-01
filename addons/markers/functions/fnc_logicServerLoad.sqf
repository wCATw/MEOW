#include "../script_component.hpp"

params ["_player", "_data"];

PARAM_INVALID(_player,"OBJECT")
PARAM_INVALID(_data,"ARRAY")
GVAR_ISNIL(count)
GVAR_ISNIL(daytime)
GVAR_ISNIL(logicServer_S)
GVAR_ISNIL(sendLoad)
GVAR_ISNIL(isPlayerBug)

{
	GVAR(count) = GVAR(count) + 1;
	_x set [0, "SWT_M#"+ str GVAR(count)];
	_x set [1, "S"];
	_x pushBack (name _player);
	_x pushBack (dayTime - GVAR(daytime)) * 3600;
	_x pushBack true; //means loaded
	_x pushBack CBA_missionTime; // change time
} forEach _data;

if (GVAR(logicServer_S) find (side _player) == -1) then {
	GVAR(logicServer_S) pushBack (side _player);
	GVAR(logicServer_S) pushBack _data;
} else {
	(GVAR(logicServer_S) select ((GVAR(logicServer_S) find (side _player)) + 1)) append _data;
};

GVAR(sendLoad) = [_player, _data];
{
	if (isPlayer _x or {time==0 and {_player in GVAR(isPlayerBug)}}) then {
		if (side _player == side _x) then {
			(owner _x) publicVariableClient QGVAR(sendLoad);
			if (!isMultiplayer and {_x == player}) then {GVAR(sendLoad) call FUNC(clientLogicLoad)};
		};
	};
} forEach (playableUnits+switchableUnits);
{
	[QFUNC(createMarker), [_player, _x]] call CBA_fnc_localEvent;
} forEach _data;