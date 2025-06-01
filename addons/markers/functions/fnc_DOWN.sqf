#include "../script_component.hpp"
/*
    Function: fnc_DOWN

        Description:
            Handles key-down events for the marker dialog. Changes icon, color, channel, or toggles fast text based on key and modifier states.

        Arguments:
            _display      <Display>  - The display where the event occurred.
            _dikCode      <Scalar>   - The DirectInput key code pressed.
            _shiftState   <Bool>     - Whether shift was pressed.
            _ctrlState    <Bool>     - Whether control was pressed.
            _altState     <Bool>     - Whether alt was pressed.
            _pic          <String>   - Picture path (context-dependent).
            _markColor    <String>   - Marker color (context-dependent).

        Returns:
            <Bool> - True if the event was handled, false otherwise.

        Variables:
            _display, _dikCode, _shiftState, _ctrlState, _altState, _pic, _markColor, _control, _handled
*/

params ["_display","_dikCode","_shiftState","_ctrlState","_altState","_pic","_markColor"];

PARAM_INVALID(_display,"DISPLAY")
PARAM_INVALID(_dikCode,"SCALAR")
PARAM_INVALID(_shiftState,"BOOL")
PARAM_INVALID(_ctrlState,"BOOL")
PARAM_INVALID(_altState,"BOOL")
PARAM_INVALID(_pic,"STRING")
PARAM_INVALID(_markColor,"STRING")

private _control = (_display displayCtrl IDC_PICTURE);
private _handled = false;

// Up/Down arrow: icon or color change (shift = color, else icon)
if ((_dikCode == 0xC8) or (_dikCode == 0xD0)) then {
    _handled = true;
    if !(_shiftState) then {
        // Icon change
        switch (_dikCode) do {
            case 0xD0: { [_display,"DOWN"] call FUNC(changeIcon); };
            case 0xC8: { [_display,"UP"] call FUNC(changeIcon); };
        };
    } else {
        // Color change
        switch (_dikCode) do {
            case 0xD0: { [_display,"DOWN"] call FUNC(changeColor); };
            case 0xC8: { [_display,"UP"] call FUNC(changeColor); };
        };
    };
// Left/Right arrow + shift: channel change
} else {
    if (((_dikCode == 0xCB) or (_dikCode == 0xCD)) and _shiftState) then {
        switch (_dikCode) do {
            case 0xCB: { [_display,"DOWN"] call FUNC(changeChannel); };
            case 0xCD: { [_display,"UP"] call FUNC(changeChannel); };
        };
// Ctrl+key: toggle fast text buttons
    } else {
        if (_ctrlState) then {
            switch (_dikCode) do {
                case 0x14: { [_display displayCtrl IDC_ADD_TEXT,"T"] call FUNC(fastText); };
                case 0x22: { [_display displayCtrl IDC_ADD_GROUP,"G"] call FUNC(fastText); };
                case 0x31: { [_display displayCtrl IDC_ADD_NAME,"N"] call FUNC(fastText); };
            };
        };
    };
};
_handled
