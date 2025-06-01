#include "../script_component.hpp"
/*
	Function: fnc_clearMap

		Description:
			Deletes all local markers and clears the global marker arrays.

		Arguments:
			none

		Returns:
			none

		Variables:
			none
*/



GVAR_ISNIL(allMarkers)
GVAR_ISNIL(allMarkersParams)

{
	deleteMarkerLocal _x;
} forEach GVAR(allMarkers);
GVAR(allMarkers) = [];
GVAR(allMarkersParams) = [];