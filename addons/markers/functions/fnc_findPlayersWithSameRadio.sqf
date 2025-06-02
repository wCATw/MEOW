#include "../script_component.hpp"
/*
    Function: fnc_findPlayersWithSameRadio

        Description:
            Finds all players who share at least one radio frequency with the given player.

        Arguments:
            _player   <Object>  - The player to compare radio frequencies with.

        Returns:
            <Array> - Array of players with at least one matching radio frequency.

        Variables:
            _player         <Object>  - The player.
            _result         <Array>   - Array of matching players.
            _playerRadios   <Array>   - The player's radio frequencies.
*/



params ["_player"];

PARAM_INVALID(_player,"OBJECT")

private _result = [];
private _playerRadios = _player call FUNC(radioListenFreqs);

{
    if (count (_playerRadios arrayIntersect (_x call FUNC(radioListenFreqs))) > 0) then {
        _result pushBack _x;
    };
} forEach (allUnits # {isPlayer _x});
_result;