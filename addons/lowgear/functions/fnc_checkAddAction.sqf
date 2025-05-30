#include "../script_component.hpp"

params [];

if ([] call FUNC(canEnable)) then {
    if (isNil QGVAR(ripLowGearAction)) then {
        GVAR(ripLowGearAction) = player addAction [
            format [
                "<img image='\x\meow\addons\lowgear\UI\car_gear.paa'/><t color='#baa71c'>%1</t>",
                localize LSTRING(ACTION_ON)
            ],
            {
                if (!GVAR(ripLowGearActionInUse)) exitWith {
                    [] call FUNC(on);
                };
                if (GVAR(ripLowGearActionInUse)) exitWith {
                    [] call FUNC(off);
                };
            },
            "",
            0,
            false,
            true,
            "",
            '[] call FUNC(canEnable)'
        ];
    };
} else {
    GVAR(ripLowGearActionInUse) = false;
    if (!isNil {GVAR(ripLowGearAction)}) then {
        player removeAction GVAR(ripLowGearAction);
        GVAR(ripLowGearAction) = nil;
    };
};
