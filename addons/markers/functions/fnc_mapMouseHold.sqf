#include "../script_component.hpp"
/*
	Function: fnc_mapMouseHold

		Description:
			Handles mouse hold events on the map. Triggers marker info display if the hold duration meets the delay coefficient.

		Arguments:
			_displayParentControl   <Control>  - The parent control of the map being held.

		Returns:
			none

		Variables:
			_displayParentControl   <Control>  - The parent control.
			_display                <Display>  - The parent display.
*/

params ["_displayParentControl"];

PARAM_INVALID(_displayParentControl,"CONTROL")
GVAR_ISNIL(mapTime);
GVAR_ISNIL(hold);
GVAR_ISNIL(markInfo);
GVAR_ISNIL(delayCoeff);

_display = ctrlParent _displayParentControl;

// Increment mapTime on each hold event
if (GVAR(mapTime) == GVAR(delayCoeff)) then {
	GVAR(mapTime) = 0;
	GVAR(hold) = true;
	// Show marker info if enabled
	if (GVAR(markInfo)) then {call FUNC(showInfo)};
} else {
	GVAR(mapTime) = GVAR(mapTime) + 1;
};
