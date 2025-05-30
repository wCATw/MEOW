#include "../script_component.hpp"

if (GVAR(disableLoc)) exitWith {diag_log "SWT MARKERS: MARKERS DISABLED"};
_this call FUNC(createMarker);
["CREATE", _this] call FUNC(log);