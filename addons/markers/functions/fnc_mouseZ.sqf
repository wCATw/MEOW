#include "../script_component.hpp"

params ["_display", "_coef"];

TRACE_2("called mouseZ with params:",_display,_coef);

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
	if (GVAR(ctrlState)) then {
		if (_coef > 0) then {
			[_display, 'UP'] call FUNC(changeChannel);
		} else {
			[_display, 'DOWN'] call FUNC(changeChannel);
		};
	};
};