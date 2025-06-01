#include "../script_component.hpp"

GVAR_ISNIL(disableLoc)

if (GVAR(disableLoc)) exitWith {diag_log "SWT MARKERS: MARKERS DISABLED"};
_this call FUNC(createMarker);  // CHECK
["CREATE", _this] call FUNC(log);