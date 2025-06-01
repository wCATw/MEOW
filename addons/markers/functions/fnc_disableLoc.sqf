#include "../script_component.hpp"

params ["_ctrl"];

PARAM_INVALID(_ctrl,"CONTROL")
GVAR_ISNIL(disableLoc)

GVAR(disableLoc) = !(GVAR(disableLoc));
if (GVAR(disableLoc)) then {
	_ctrl ctrlSetText localize LSTRING(ENABLE);
} else {
	_ctrl ctrlSetText localize LSTRING(DISABLE);
};