#include "../script_component.hpp"

{
	deleteMarkerLocal _x;
} forEach GVAR(allMarkers);
GVAR(allMarkers) = [];
GVAR(allMarkersParams) = [];