#include "../script_component.hpp"

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