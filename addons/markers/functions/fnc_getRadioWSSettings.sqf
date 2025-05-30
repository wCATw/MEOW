#include "../script_component.hpp"

params["_rclass","_unit"]; 

TRACE_2("called getColorName with params:",_rclass,_unit);

private ["_variableName", "_value", "_rc"];

_variableName = format["%1_settings", _rclass];
_value = missionNamespace getVariable _variableName;

if (isNil {_value}) then {
	_value = (group _unit) getVariable "tf_sw_frequency";
};
_value