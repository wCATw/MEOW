#include "script_component.hpp"

if (!hasInterface) exitWith {};

[
    "MEOW Пониженная передача",
    "toggle_lowgear",
    "Переключить пониженную передачу",
    {
        if (!GVAR(ripLowGearActionInUse)) exitWith {
            [] call FUNC(on);
        };
        [] call FUNC(off);
    },
    "",
    [DIK_C, [true, false, false]]
] call CBA_fnc_addKeybind;

GVAR(ripLowGearActionInUse) = false;
GVAR(ripLowGearAction) = nil;

{
    player addEventHandler [_x, {
        [] call FUNC(checkAddAction);
    }];
} forEach ["GetInMan", "GetOutMan", "SeatSwitchedMan"];

[] call FUNC(checkAddAction);
