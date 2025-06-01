#include "../script_component.hpp"

params ["_unit"];

PARAM_INVALID(_unit,"OBJECT")

private _result = nil;
{	
	if (_x call TFAR_fnc_isRadio) exitWith {_result = _x};
} forEach (assignedItems _unit);
_result;