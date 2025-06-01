#include "../script_component.hpp"

params ["_displayControl"];

PARAM_INVALID(_displayControl,"CONTROL")

_display = ctrlParent _displayControl;
ctrlSetFocus (_display displayCtrl IDC_TEXT);
[_display, "UP"] call FUNC(changeChannel);