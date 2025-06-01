#include "../script_component.hpp"

params ["_player","_unit"];

PARAM_INVALID(_player,"OBJECT")
PARAM_INVALID(_unit,"OBJECT")

private _playerRadios = _player call FUNC(radioListenFreqs);
private _unitRadios = _unit call FUNC(radioListenFreqs);
if (count (_playerRadios arrayIntersect _unitRadios) > 0) exitWith {true};
false;