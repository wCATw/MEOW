#include "../script_component.hpp"

params [
    ["_unit", player],
    ["_veh", vehicle player]
];

alive _unit &&
alive _veh &&
_veh != _unit &&
driver _veh == _unit &&
canMove _veh &&
(
    _veh isKindOf "Tank" ||
    _veh isKindOf "BTR90_Base" ||
    _veh isKindOf "Car"
) &&
abs speed _veh < (2 * GVAR(speedLimitMultiplier) * (GVAR(speedWater) max GVAR(speedLand)))
