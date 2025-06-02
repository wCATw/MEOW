#include "../script_component.hpp"
/*
    Function: fnc_paramsModule

        Description:
            Loads and assigns module parameters to global variables for marker loading logic.

        Arguments:
            _module   <Object>  - The module object containing parameters.

        Returns:
            none

        Variables:
            _module             <Object>  - The module object.
*/



params ["_module"];

PARAM_INVALID(_module,"OBJECT")

GVAR(loadEnabled) = _module getVariable "Loads";
GVAR(loadEnabledFor) = _module getVariable "Loads_for";
GVAR(loadEnabledWhen) = _module getVariable "Loads_brif";
