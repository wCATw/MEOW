#include "../script_component.hpp"
/*
	Function: fnc_fastText

		Description:
			Toggles and updates the color state of fast text buttons (Name, Group, Text) in the marker dialog UI.

		Arguments:
			_ctrl        <Control>  - The control representing the fast text button.
			_action      <String>   - The fast text type ("N", "G", "T").
			_changeState <Bool>     - Whether to change the state or just update color.

		Returns:
			none

		Variables:
			_ctrl        <Control>  - The button control.
			_action      <String>   - Fast text type.
			_changeState <Bool>     - State change flag.
*/

params ["_ctrl", "_action", "_changeState"];

PARAM_INVALID(_ctrl,"CONTROL")
PARAM_INVALID(_action,"STRING")
PARAM_INVALID(_changeState,"BOOL")
GVAR_ISNIL(fastTextN)
GVAR_ISNIL(fastTextG)
GVAR_ISNIL(fastTextT)

// Set focus to the text input control
ctrlSetFocus ((ctrlParent _ctrl) displayCtrl IDC_TEXT);

switch (_action) do {
	case "N": {
		// Toggle global fast text state for Name if _changeState is nil
		if (isNil {_changeState}) then {
			GVAR(fastTextN) = !GVAR(fastTextN);
		};
		// Update button color to indicate active/inactive state
		if (GVAR(fastTextN)) then {
			_ctrl ctrlSetTextColor [
				IDC_ADV_CB_LOG/255,
				176/255,
				74/255,
				1
			];
		} else {
			_ctrl ctrlSetTextColor [
				1,
				1,
				1,
				0.5
			];
		};
	};

	case "G": {
		// Toggle global fast text state for Group if _changeState is nil
		if (isNil {_changeState}) then {
			GVAR(fastTextG) = !GVAR(fastTextG);
		};
		// Update button color to indicate active/inactive state
		if (GVAR(fastTextG)) then {
			_ctrl ctrlSetTextColor [
				IDC_ADV_CB_LOG/255,
				176/255,
				74/255,
				1
			];
		} else {
			_ctrl ctrlSetTextColor [
				1,
				1,
				1,
				0.5
			];
		};
	};

	case "T": {
		// Toggle global fast text state for Text if _changeState is nil
		if (isNil {_changeState}) then {
			GVAR(fastTextT) = !GVAR(fastTextT);
		};
		// Update button color to indicate active/inactive state
		if (GVAR(fastTextT)) then {
			_ctrl ctrlSetTextColor [
				IDC_ADV_CB_LOG/255,
				176/255,
				74/255,
				1
			];
		} else {
			_ctrl ctrlSetTextColor [
				1,
				1,
				1,
				0.5
			];
		};
	};
};