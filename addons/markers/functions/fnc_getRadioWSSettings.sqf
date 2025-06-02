#include "../script_component.hpp"
/*
	Function: fnc_getRadioWSSettings

		Description:
			Retrieves the radio settings for a given radio class and unit, checking missionNamespace and group variables.

		Arguments:
			_rclass   <String>  - The radio class name.
			_unit     <Object>  - The unit to get group variable from if needed.

		Returns:
			<Any> - The radio settings value, or group variable if not found in missionNamespace.

		Variables:
			_rclass, _unit, _variableName, _value, _rc
*/

params["_rclass","_unit"]; 

PARAM_INVALID(_rclass,"STRING")
PARAM_INVALID(_unit,"OBJECT")

private ["_variableName", "_value", "_rc"];

_variableName = format["%1_settings",_rclass];
_value = missionNamespace getVariable _variableName;

// If not found, fallback to group variable
if (isNil {_value}) then {
	_value = (group _unit) getVariable "tf_sw_frequency";
};

_value
