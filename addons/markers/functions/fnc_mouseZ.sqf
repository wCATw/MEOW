#include "../script_component.hpp"
/*
	Function: fnc_mouseZ

		Description:
			Handles mouse wheel (Z axis) input for the marker dialog. Adjusts marker scale or changes channel based on modifier key state.

		Arguments:
			_display   <Display>  - The display receiving the mouse wheel event.
			_coef      <Scalar>   - The direction and amount of wheel movement.

		Returns:
			none

		Variables:
			_display      <Display>  - The display.
			_coef         <Scalar>   - Mouse wheel coefficient.
*/

params ["_display", "_coef"];

PARAM_INVALID(_display,"DISPLAY")
PARAM_INVALID(_coef,"SCALAR")
GVAR_ISNIL(shiftState)
GVAR_ISNIL(ctrlState)
GVAR_ISNIL(sweetkS)

// If shift is held, adjust marker scale (sweetkS)
if (GVAR(shiftState)) then {
	if (_coef > 0) then {
		if (GVAR(sweetkS) < 1.3) then {
			GVAR(sweetkS) = GVAR(sweetkS) + 0.3;
		};
	} else {
		if (GVAR(sweetkS) > 0.7) then {
			GVAR(sweetkS) = GVAR(sweetkS) - 0.3;
		};
	};
	call FUNC(scale);
} else {
	// If ctrl is held, change marker channel up/down
	if (GVAR(ctrlState)) then {
		if (_coef > 0) then {
			[_display,'UP'] call FUNC(changeChannel);
		} else {
			[_display,'DOWN'] call FUNC(changeChannel);
		};
	};
};
