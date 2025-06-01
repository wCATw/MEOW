#include "../script_component.hpp"

params ["_player"];

PARAM_INVALID(_player,"OBJECT")
GVAR_ISNIL(disableLoc)

if (GVAR(disableLoc)) exitWith {diag_log "SWT MARKERS: MARKERS DISABLED"};

{
	_x call FUNC(createMarker);
} forEach (_this select 1);
["LOAD", [name _player, count (_this select 1)]] call FUNC(log);
[] call FUNC(dimMarkersFromOtherChannels);