#include "../script_component.hpp"

params ["_module"];

GVAR(loadEnabled) = _module getVariable "Loads";
GVAR(loadEnabledFor) = _module getVariable "Loads_for";
GVAR(loadEnabledWhen) = _module getVariable "Loads_brif";
