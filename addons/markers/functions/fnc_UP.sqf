#include "../script_component.hpp"

params ["_display","_dikCode","_shiftState","_ctrlState","_altState","_pic","_markColor"];

PARAM_INVALID(_display,"DISPLAY")
PARAM_INVALID(_dikCode,"SCALAR")
PARAM_INVALID(_shiftState,"BOOL")
PARAM_INVALID(_ctrlState,"BOOL")
PARAM_INVALID(_altState,"BOOL")
PARAM_INVALID(_pic,"STRING")
PARAM_INVALID(_markColor,"STRING")

if (_dikCode in [DIK_LSHIFT,DIK_RSHIFT]) then {
	GVAR(shiftState) = false;
};
if (_dikCode in [DIK_LCONTROL,DIK_RCONTROL]) then {
	GVAR(ctrlState) = false;
};
if (_dikCode in [DIK_LMENU,DIK_RMENU]) then {
	GVAR(altState) = false;
};
false;