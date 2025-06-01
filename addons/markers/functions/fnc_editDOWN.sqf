#include "../script_component.hpp"

params ["_displayControlParent", "_dikCode"];

PARAM_INVALID(_displayControlParent,"CONTROL")
PARAM_INVALID(_dikCode,"SCALAR")
GVAR_ISNIL(tempText)
GVAR_ISNIL(ctrlState)

_display = ctrlParent _displayControlParent;
if (((_dikCode == 51) or (_dikCode == 52)) and GVAR(ctrlState)) then {
	(_this select 0) ctrlSetText GVAR(tempText);
	switch (_dikCode) do {
		case 51: {
			[_display, 'DOWN'] call FUNC(changeChannel);
		};

		case 52: {
			[_display, 'UP'] call FUNC(changeChannel);
		};
	};
} else {
	GVAR(tempText) = ctrlText _displayControlParent;
};