#include "../script_component.hpp"
/*
	Function: fnc_findCode

		Description:
			Finds the index of the first character in a string that is not in the allowed whitelist, skipping quoted substrings.

		Arguments:
			_str   <String>  - The string to search.

		Returns:
			<Number> - The index of the first non-whitelisted character, or -1 if all are allowed.

		Variables:
			_str        <String>  - Input string.
			_whileList  <String>  - Allowed characters.
			_result     <Number>  - Result index.
*/



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