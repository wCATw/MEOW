#include "../script_component.hpp"
/*
    Description:
    Handles double-click events on the map marker button, storing coordinates and opening the marker insertion dialog.

    Arguments:
        _control <CONTROL> - The control that was double-clicked
        _button <SCALAR> - Mouse button index
        _xPos <SCALAR> - X position of the click
        _yPos <SCALAR> - Y position of the click
        _shift <BOOL> - Shift key state
        _ctrl <BOOL> - Ctrl key state
        _alt <BOOL> - Alt key state

    Returns:
        <BOOL> - Always true

    Variables:
        GVAR(displayCoord) <ARRAY> - Stores the clicked coordinates
*/


params ["_control", "_button", "_xPos", "_yPos", "_shift", "_ctrl", "_alt"];

PARAM_INVALID(_control,"CONTROL")
PARAM_INVALID(_button,"SCALAR")
PARAM_INVALID(_xPos,"SCALAR")
PARAM_INVALID(_yPos,"SCALAR")
PARAM_INVALID(_shift,"BOOL")
PARAM_INVALID(_ctrl,"BOOL")
PARAM_INVALID(_alt,"BOOL")
GVAR_ISNIL(displayCoord)

if (_button == 0) then {
    GVAR(displayCoord) = [_xPos,_yPos];
    (findDisplay IDD_DISPLAY_INSERT_MARKER) closeDisplay 2;
    (ctrlParent _control) createDisplay QGVAR(RscDisplayInsertMarker);
};
true