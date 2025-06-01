#include "../script_component.hpp"

GVAR_ISNIL(allMarkers)
GVAR_ISNIL(allMarkersParams)

{
	deleteMarkerLocal _x;
} forEach GVAR(allMarkers);
GVAR(allMarkers) = [];
GVAR(allMarkersParams) = [];