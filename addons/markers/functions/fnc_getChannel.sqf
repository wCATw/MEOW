#include "../script_component.hpp"
/*
    Function: fnc_getChannel

        Description:
            Retrieves the channel value for a given marker from the global marker parameters array.

        Arguments:
            _marker   <String>  - The marker name.

        Returns:
            <Any> - The channel value for the marker.

        Variables:
            _marker   <String>  - Marker name.
*/



params ["_marker"];

PARAM_INVALID(_marker,"STRING")

(GVAR(allMarkersParams) select (GVAR(allMarkers) find _marker)) select 1;
