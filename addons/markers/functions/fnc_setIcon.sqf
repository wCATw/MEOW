#include "../script_component.hpp"

params ["_control", "_num"];

TRACE_2("called setIcon with params:",_control,_num);

ctrlSetFocus ((ctrlParent _control) displayCtrl IDC_TEXT);
GVAR(markType) = GVAR(iconSlotParams) select _num;
GVAR(pic) = (ctrlText _control);
((ctrlParent _control) displayCtrl IDC_PICTURE) ctrlSetText GVAR(pic);