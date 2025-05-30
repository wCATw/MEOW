#include "../script_component.hpp"

params ["_displayParentControl"];

TRACE_1("called mapMouseHold with params:",_displayParentControl);

_display = ctrlParent _displayParentControl;
if (GVAR(mapTime) == GVAR(delayCoeff)) then {
	GVAR(mapTime) = 0;
	GVAR(hold) = true;
	if (GVAR(markInfo)) then {call FUNC(showInfo)};
} else {
	GVAR(mapTime) = GVAR(mapTime) + 1;
};