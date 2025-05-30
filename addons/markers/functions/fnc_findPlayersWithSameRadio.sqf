#include "../script_component.hpp"

params ["_player"];

TRACE_1("called findPlayersWithSameRadio with params:",_player);

private _result = [];
private _playerRadios = _player call FUNC(radioListenFreqs);

{
    if (count (_playerRadios arrayIntersect (_x call FUNC(radioListenFreqs))) > 0) then {
        _result pushBack _x;
    };
} forEach (allUnits # {isPlayer _x});
_result;