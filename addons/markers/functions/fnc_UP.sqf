#include "../script_component.hpp"

params ["_display","_dikCode","_shiftState","_ctrlState","_altState","_pic","_markColor"];

TRACE_7("called unLoad with params:",_display,_dikCode,_shiftState,_ctrlState,_altState,_pic,_markColor);

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