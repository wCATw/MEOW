#include "../script_component.hpp"
/*
    Function: fnc_clientLogicCreate

        Description:
            Creates a marker for a client and logs the creation

        Arguments:
            none (uses _this as marker parameters)
            Global:
                disableLoc <Bool> - If true, disables marker creation (read-only)

        Returns:
            Global:
                none
            none

        Variables:
            none
*/



GVAR_ISNIL(disableLoc)

if (GVAR(disableLoc)) exitWith {diag_log "SWT MARKERS: MARKERS DISABLED"};
_this call FUNC(createMarker);  // CHECK
["CREATE", _this] call FUNC(log);