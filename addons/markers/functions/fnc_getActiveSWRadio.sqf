#include "../script_component.hpp"
/*
	Function: fnc_getActiveSWRadio

		Description:
			Returns the first assigned shortwave (SW) radio item for a given unit, if any.

		Arguments:
			_unit   <Object>  - The unit to check for assigned radios.

		Returns:
			<Any> - The first assigned SW radio item, or nil if none found.

		Variables:
			_unit    <Object>  - The unit.
			_result  <Any>     - The found radio item or nil.
*/



params ["_unit"];

PARAM_INVALID(_unit,"OBJECT")

private _result = nil;
{	
	if (_x call TFAR_fnc_isRadio) exitWith {_result = _x};
} forEach (assignedItems _unit);
_result;