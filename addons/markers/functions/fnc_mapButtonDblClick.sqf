#include "../script_component.hpp"

params ["_control", "_button", "_xPos", "_yPos", "_shift", "_ctrl", "_alt"];

if (_button == 0) then {
    GVAR(displayCoord) = [_xPos,_yPos];
    (findDisplay IDD_DISPLAY_INSERT_MARKER) closeDisplay 2;
    (ctrlParent _control) createDisplay QGVAR(RscDisplayInsertMarker);
};
true