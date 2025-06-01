#include "../script_component.hpp"

params ["_str"];

PARAM_INVALID(_str,"STRING")

private _whileList = "[]1234567890.,- ";
private _result = -1;

for "_i" from 0 to (count _str - 1) do {
	if ((_str select [_i, 1]) == """") then {
		while {_i = _i + 1; ((_str select [_i, 1]) != """")} do {};
		_i = _i + 1;
	};
	if (_whileList find (_str select [_i, 1]) == -1) exitWith {_result = _i};
};

_result;