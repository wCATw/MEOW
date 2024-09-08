#include "../script_component.hpp"

_obj = param [0, GVAR(anker), [objNull]];
_enable = param [1, false, [true]];

if (isNull _obj) exitWith {};

if (_enable) then {
	player enableCollisionWith _obj;
} else {
	player disableCollisionWith _obj;
};

{
    [_x,_enable] call FUNC(collision);
} forEach (attachedObjects _obj);
