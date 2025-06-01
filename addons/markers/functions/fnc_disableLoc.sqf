#include "../script_component.hpp"
/*
	Function: fnc_disableLoc

		Description:
			Toggles the disableLoc global variable and updates the control text to reflect the new state.

		Arguments:
			_ctrl   <Control>  - The control whose text is updated.

		Returns:
			none

		Variables:
			_ctrl   <Control>  - The control to update.
*/



params ["_ctrl"];

PARAM_INVALID(_ctrl,"CONTROL")
GVAR_ISNIL(disableLoc)

GVAR(disableLoc) = !(GVAR(disableLoc));
if (GVAR(disableLoc)) then {
	_ctrl ctrlSetText localize LSTRING(ENABLE);
} else {
	_ctrl ctrlSetText localize LSTRING(DISABLE);
};