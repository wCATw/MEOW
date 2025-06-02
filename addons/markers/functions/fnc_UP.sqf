#include "../script_component.hpp"
    /*
        FILE: fnc_UP.sqf

            Description:
                Handles key-up events for a display. Updates global modifier key states (shift, ctrl, alt) when their respective keys are released.

            Arguments:
                _display      <Display>  - The display where the event occurred.
                _dikCode      <Scalar>   - The DirectInput key code of the released key.
                _shiftState   <Bool>     - Whether shift was pressed.
                _ctrlState    <Bool>     - Whether control was pressed.
                _altState     <Bool>     - Whether alt was pressed.
                _pic          <String>   - Picture path (purpose context-dependent).
                _markColor    <String>   - Marker color (purpose context-dependent).

            Returns:
                <Bool> - Always false, indicating the event was handled.
                Global:
                    shiftState <Bool> - Updated to false if shift released
                    ctrlState  <Bool> - Updated to false if ctrl released
                    altState   <Bool> - Updated to false if alt released

            Variables:
                none
    */

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