#include "../script_component.hpp"

params ["_displayParentControl"];

PARAM_INVALID(_displayParentControl,"CONTROL")
GVAR_ISNIL(mapTime);
GVAR_ISNIL(hold);
GVAR_ISNIL(markInfo);
GVAR_ISNIL(delayCoeff);

_display = ctrlParent _displayParentControl;
if (GVAR(mapTime) == GVAR(delayCoeff)) then {
	GVAR(mapTime) = 0;
	GVAR(hold) = true;
	if (GVAR(markInfo)) then {call FUNC(showInfo)};
} else {
	GVAR(mapTime) = GVAR(mapTime) + 1;
};