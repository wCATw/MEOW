#include "../script_component.hpp"
/*
    Function: fnc_listenSameTFRadio

        Description:
            Checks if two players share at least one radio frequency.

        Arguments:
            _player   <Object>  - The first player.
            _unit     <Object>  - The second player.

        Returns:
            <Bool> - True if they share a frequency, false otherwise.

        Variables:
            _playerRadios, _unitRadios
*/



params ["_player","_unit"];

PARAM_INVALID(_player,"OBJECT")
PARAM_INVALID(_unit,"OBJECT")

private _playerRadios = _player call FUNC(radioListenFreqs);
private _unitRadios = _unit call FUNC(radioListenFreqs);
if (count (_playerRadios arrayIntersect _unitRadios) > 0) exitWith {true};
false;