#include "../script_component.hpp"
/*
	Function: fnc_strReplace
		Description:
			Replaces all occurrences of a substring within a string with a new substring. Custom implementation for string replacement.
		Arguments:
			_str   <String>  - The original string to perform replacements on.
			_old   <String>  - The substring to be replaced.
			_new   <String>  - The substring to replace with.
		Returns:
			<String> - The resulting string after replacements.
		Variables:
			_out   <String>  - Output string being built.
			_tmp   <String>  - Temporary substring for comparison.
			_la    <Number>  - Length of the input string as array.
			_lo    <Number>  - Length of the old substring as array.
			_ln    <Number>  - Length of the new substring as array.
			_j     <Number>  - Loop index for substring comparison.
			_arr   <Array>   - Array of character codes from the input string.
*/

params ["_str", "_old", "_new"];

PARAM_INVALID(_str,"STRING")
PARAM_INVALID(_old,"STRING")
PARAM_INVALID(_new,"STRING")

private ["_out","_tmp","_la","_lo","_ln","_j","_arr"];

_arr = toArray _str;
_la = count _arr;
_lo = count (toArray _old);
_ln = count (toArray _new);
_out = "";

{
	// Build substring for comparison if enough characters remain
	_tmp = "";
	if (_forEachIndex <= _la - _lo) then {
		for "_j" from _forEachIndex to (_forEachIndex + _lo - 1) do {
			_tmp = _tmp + toString ([_arr select _j]);
		};
	};
	// If match, append replacement and skip ahead; else append original char
	if (_tmp == _old) then {
		_out = _out + _new;
		_forEachIndex = _forEachIndex + _lo - 1;
	} else {
		_out = _out + toString ([_arr select _forEachIndex]);
	};
} forEach _arr;

_out;
