#include "../script_component.hpp"

params ["_marker"];

PARAM_INVALID(_marker,"STRING")

(GVAR(allMarkersParams) select (GVAR(allMarkers) find _marker)) select 1;
