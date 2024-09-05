#include "../script_component.hpp"

if !(isNull GVAR(anker))then{
    GVAR(collision) = true;
    GVAR(exit) apply {
        GVAR(anker) call _x;
    };
    [GVAR(anker), true] call FUNC(collision);
    if (isMultiplayer && !(local _oldAnker)) then {
        [player,GVAR(anker)]remoteExecCall ["enableCollisionWith", GVAR(anker)];
    };
    GVAR(anker) = objNull;
};
