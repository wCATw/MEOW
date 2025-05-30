#include "../script_component.hpp"

params ["_display","_dikCode","_shiftState","_ctrlState","_altState","_pic","_markColor"];

TRACE_7("called DOWN with params:",_display,_dikCode,_shiftState,_ctrlState,_altState,_pic,_markColor);

private _control = (_display displayCtrl IDC_PICTURE);
private _handled = false;

if ((_dikCode == 0xC8) or (_dikCode == 0xD0)) then {
    _handled = true;
    if !(_shiftState) then {

        switch (_dikCode) do {
            case 0xD0: {
                [_display, 'DOWN'] call FUNC(changeIcon);
            };

            case 0xC8: {
                [_display, 'UP'] call FUNC(changeIcon);
            };
        };

    } else {
        if ((_dikCode == 0xD0) or (_dikCode == 0xC8)) then {
            switch (_dikCode) do {
                case 0xD0: {
                    [_display, 'DOWN'] call FUNC(changeColor);
                };

                case 0xC8: {
                    [_display, 'UP'] call FUNC(changeColor);
                };
            };
        };
    };
} else {
    if (((_dikCode == 0xCB) or (_dikCode == 0xCD)) and _shiftState) then {
        switch (_dikCode) do {
            case 0xCB: {
                [_display, 'DOWN'] call FUNC(changeChannel);
            };

            case 0xCD: {
                [_display, 'UP'] call FUNC(changeChannel);
            };
        };
    } else {
        if (_ctrlState) then {
            switch (_dikCode) do {
                case 0x14: {
                    [_display displayCtrl IDC_ADD_TEXT,"T"] call FUNC(fastText);
                };

                case 0x22: {
                    [_display displayCtrl IDC_SETTINGS_BUTTON,"G"] call FUNC(fastText);
                };

                case 0x31: {
                    [_display displayCtrl IDC_ADD_NAME,"N"] call FUNC(fastText);
                };
            };
        };
    };
};
_handled