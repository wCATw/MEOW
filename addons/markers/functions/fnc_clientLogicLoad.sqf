#include "../script_component.hpp"

params ["_player"];

TRACE_1("called clientLogicLoad with params:",_player);

if (GVAR(disableLoc)) exitWith {diag_log "SWT MARKERS: MARKERS DISABLED"};

{
	_x call FUNC(createMarker);
} forEach (_this select 1);
["LOAD", [name _player, count (_this select 1)]] call FUNC(log);
[] call FUNC(dimMarkersFromOtherChannels);