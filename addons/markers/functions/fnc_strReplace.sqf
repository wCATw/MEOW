#include "../script_component.hpp"

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
	_tmp = "";
	if (_forEachIndex <= _la -_lo) then {
		for "_j" from _forEachIndex to ( _forEachIndex + _lo - 1) do {
			_tmp = _tmp + toString ([_arr select _j]);
		};
	};
	if (_tmp == _old) then {
		_out = _out + _new;
		_forEachIndex = _forEachIndex + _lo - 1;
	} else {
		_out = _out + toString ([_arr select _forEachIndex]);
	};
} forEach _arr;
_out;