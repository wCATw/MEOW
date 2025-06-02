#include "../script_component.hpp"
/*
	Function: fnc_editDOWN

		Description:
			Handles key-down events for editing controls in the marker dialog. Changes channel or restores temp text based on key and control state.

		Arguments:
			_displayControlParent   <Control>  - The parent control of the display.
			_dikCode                <Scalar>   - The DirectInput key code pressed.

		Returns:
			none

		Variables:
			_displayControlParent   <Control>  - The parent control.
			_dikCode                <Scalar>   - Key code.
			_display                <Display>  - The parent display.
*/

params ["_displayControlParent", "_dikCode"];

PARAM_INVALID(_displayControlParent,"CONTROL")
PARAM_INVALID(_dikCode,"SCALAR")
GVAR_ISNIL(tempText)
GVAR_ISNIL(ctrlState)

_display = ctrlParent _displayControlParent;

// If ctrlState is set and certain keys are pressed, restore temp text and change channel
if (((_dikCode == IDC_MAP) or (_dikCode == 52)) and GVAR(ctrlState)) then {
	(_this select 0) ctrlSetText GVAR(tempText);
	switch (_dikCode) do {
		case IDC_MAP: {
			[_display,'DOWN'] call FUNC(changeChannel);
		};
		case 52: {
			[_display,'UP'] call FUNC(changeChannel);
		};
	};
} else {
	// Otherwise, update tempText with current control text
	GVAR(tempText) = ctrlText _displayControlParent;
};
