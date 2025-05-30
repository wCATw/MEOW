#include "../script_component.hpp"

params ["_displayControl"];

TRACE_1("called clickChann with params:",_displayControl);

_display = ctrlParent _displayControl;
ctrlSetFocus (_display displayCtrl IDC_TEXT);
[_display, "UP"] call FUNC(changeChannel);