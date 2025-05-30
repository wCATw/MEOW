#include "../script_component.hpp"

params ["_player","_unit"];

TRACE_2("called listenSameTFRadio with params:",_player,_unit);

private _playerRadios = _player call FUNC(radioListenFreqs);
private _unitRadios = _unit call FUNC(radioListenFreqs);
if (count (_playerRadios arrayIntersect _unitRadios) > 0) exitWith {true};
false;