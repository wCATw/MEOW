#include "../script_component.hpp"

_obj = param [0, objNull, [objNull]];
if (_obj isKindOf "landvehicle" || _obj isKindOf "air" || _obj isKindOf "ship") exitWith { true };
if (_obj in GVAR(specialObjects)) exitWith { true };
if ((typeOf _obj) in GVAR(specialObjects)) exitWith { true };
if (((getModelInfo _obj) select 1) in GVAR(specialObjects)) exitWith { true };
false;
