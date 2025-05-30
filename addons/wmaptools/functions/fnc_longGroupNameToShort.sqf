#include "../script_component.hpp"

private ["_longGr", "_arr", "_shortGr", "_frstLttr"];

_longGr = _this;
_arr = [_longGr, " -"] call BIS_fnc_splitString;
_shortGr = _longGr;

if (count _arr >= 2 and count (_arr select 0) >= 1) then {
    _frstLttr = (_arr select 0) select [0,1];
    if (language == "Russian") then {
        _frstLttr = (_arr select 0) select [0,2];
    };
    _shortGr = _frstLttr + (_arr select 1) + "-" + (_arr select 2);
};

_shortGr;
