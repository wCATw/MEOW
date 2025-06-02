#include "../script_component.hpp"
/*
	Function: fnc_setButt

		Description:
			Toggles the advanced marker settings UI controls (comboboxes and buttons) for marker creation/editing.

		Arguments:
			_control   <Control>  - The control that triggered the toggle action.

		Returns:
			none

		Variables:
			_control        <Control>  - The triggering control.
			_display        <Display>  - The parent display.
			_combo_color    <Array>    - Array of color combobox control IDs.
			_combo_icon     <Array>    - Array of icon combobox control IDs.
*/

params ["_control"];

PARAM_INVALID(_control,"CONTROL")

private ["_display", "_combo_color", "_combo_icon"];

_display = ctrlParent _control;
_combo_color = [IDC_COMBO_00,IDC_COMBO_01,IDC_COMBO_02,IDC_COMBO_03,IDC_COMBO_04,IDC_COMBO_05];
_combo_icon = [IDC_COMBO_06,IDC_COMBO_07,IDC_COMBO_08,IDC_COMBO_09,IDC_COMBO_10,IDC_COMBO_11];

// Always focus text input after toggle
ctrlSetFocus (_display displayCtrl IDC_TEXT);

if (isNil {GVAR(RscDisplayInsertMarkerSetButton)}) then {
	// Show and fade in all advanced controls, then load comboboxes and set state
	{
		(_display displayCtrl _x) ctrlShow true;
		(_display displayCtrl _x) ctrlSetFade 0;
		(_display displayCtrl _x) ctrlCommit 0.2;
	} forEach (_combo_color+_combo_icon+[IDC_BUTTON_ADV]);
	_display call FUNC(loadComboboxes);
	GVAR(RscDisplayInsertMarkerSetButton) = true;
} else {
	// Fade out and hide all advanced controls, reset state variables
	{
		(_display displayCtrl _x) ctrlSetFade 1;
		(_display displayCtrl _x) ctrlCommit 0.2;
	} forEach (_combo_color+_combo_icon+[IDC_BUTTON_ADV,IDC_CONTROLS_GROUP_ADV]);
	waitUntil {ctrlCommitted (_display displayCtrl IDC_COMBO_11)};
	{(_display displayCtrl _x) ctrlShow false} forEach (_combo_color+_combo_icon+[IDC_BUTTON_ADV,IDC_CONTROLS_GROUP_ADV]);
	GVAR(RscDisplayInsertMarkerSetButton) = nil;
	GVAR(advSet) = nil;
};
