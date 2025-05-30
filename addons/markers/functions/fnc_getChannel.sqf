#include "../script_component.hpp"

params ["_marker"];

TRACE_1("called getChannel with params:",_marker);

(GVAR(allMarkersParams) select (GVAR(allMarkers) find _marker)) select 1;
