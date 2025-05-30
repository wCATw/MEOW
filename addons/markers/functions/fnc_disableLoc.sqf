#include "../script_component.hpp"

params ["_ctrl"];

TRACE_1("called disableLoc with params:",_ctrl);

GVAR(disableLoc) = !(GVAR(disableLoc));
if (GVAR(disableLoc)) then {
	_ctrl ctrlSetText localize LSTRING(ENABLE);
} else {
	_ctrl ctrlSetText localize LSTRING(DISABLE);
};