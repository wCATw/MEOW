#include "../script_component.hpp"

params ["_unit"];

TRACE_1("called getActiveSWRadio with params:",_unit);

private _result = nil;
{	
	if (_x call TFAR_fnc_isRadio) exitWith {_result = _x};
} forEach (assignedItems _unit);
_result;