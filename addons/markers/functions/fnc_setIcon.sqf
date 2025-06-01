#include "../script_component.hpp"

params ["_control", "_num"];

PARAM_INVALID(_control,"CONTROL")
PARAM_INVALID(_num,"NUMBER")
GVAR_ISNIL(iconSlotParams)
GVAR_ISNIL(pic)
GVAR_ISNIL(markType)

ctrlSetFocus ((ctrlParent _control) displayCtrl IDC_TEXT);
GVAR(markType) = GVAR(iconSlotParams) select _num;
GVAR(pic) = (ctrlText _control);
((ctrlParent _control) displayCtrl IDC_PICTURE) ctrlSetText GVAR(pic);