#include "../script_component.hpp"

_obj = param [0, objNull, [objNull]];
if(isNull _obj) exitWith { false };
if (_obj in WMO_noRoadway) exitWith { false };
if ((typeOf _obj) in GVAR(noRoadway)) exitWith{ false };
if (((getModelInfo _obj) select 1) in GVAR(noRoadway)) exitWith { false };
true;
