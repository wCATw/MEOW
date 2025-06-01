#include "../script_component.hpp"
/*
    Function: fnc_clickChann

        Description:
            Handles click events on the channel button in the marker dialog. Sets focus to the text input and changes the channel up.

        Arguments:
            _displayControl   <Control>  - The control that was clicked.

        Returns:
            none

        Variables:
            _display   <Display>  - The parent display.
*/



params ["_displayControl"];

PARAM_INVALID(_displayControl,"CONTROL")

_display = ctrlParent _displayControl;
ctrlSetFocus (_display displayCtrl IDC_TEXT);
[_display, "UP"] call FUNC(changeChannel);