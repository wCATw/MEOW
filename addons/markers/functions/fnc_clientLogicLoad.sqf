#include "../script_component.hpp"

params ["_player", "_markers"];

PARAM_INVALID(_player,"OBJECT")
PARAM_INVALID(_markers,"ARRAY")
GVAR_ISNIL(disableLoc)

if (GVAR(disableLoc)) exitWith {diag_log "SWT MARKERS: MARKERS DISABLED"};

{
	_x call FUNC(createMarker); // CHECK
} forEach _markers;
["LOAD", [name _player, count (_this select 1)]] call FUNC(log);
[] call FUNC(dimMarkersFromOtherChannels);