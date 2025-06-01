#include "../script_component.hpp"

params ["_module"];

PARAM_INVALID(_module,"OBJECT")

GVAR(loadEnabled) = _module getVariable "Loads";
GVAR(loadEnabledFor) = _module getVariable "Loads_for";
GVAR(loadEnabledWhen) = _module getVariable "Loads_brif";
