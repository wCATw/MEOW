#include "../script_component.hpp"

params["_rclass","_unit"]; 

PARAM_INVALID(_rclass,"STRING")
PARAM_INVALID(_unit,"OBJECT")

private ["_variableName", "_value", "_rc"];

_variableName = format["%1_settings", _rclass];
_value = missionNamespace getVariable _variableName;

if (isNil {_value}) then {
	_value = (group _unit) getVariable "tf_sw_frequency";
};
_value