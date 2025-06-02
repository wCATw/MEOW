#include "../script_component.hpp"
/*
	Function: fnc_clientLogicLoad

		Description:
			Loads a set of markers for a client and logs the operation. Exits if location updates are disabled.

		Arguments:
			_player    <Object>  - The player loading the markers.
			_markers   <Array>   - Array of marker data to load.
			Global:
				disableLoc <Bool> - If true, disables marker loading (read-only)

		Returns:
			Global:
				none
			none

		Variables:
			none
*/



params ["_player", "_markers"];

PARAM_INVALID(_player,"OBJECT")
PARAM_INVALID(_markers,"ARRAY")
GVAR_ISNIL(disableLoc)

if (GVAR(disableLoc)) exitWith {
	diag_log "SWT MARKERS: MARKERS DISABLED"
};

{
	_x call FUNC(createMarker); // CHECK
} forEach _markers;

["LOAD", [name _player, count (_this select 1)]] call FUNC(log);

[] call FUNC(dimMarkersFromOtherChannels);