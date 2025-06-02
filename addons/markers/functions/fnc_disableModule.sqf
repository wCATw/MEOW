#include "../script_component.hpp"
/*
    Function: fnc_disableModule

        Description:
            Disables the marker module by setting the global disable variable to true.
            _yes

        Arguments:
            none

        Returns:
            none

        Variables:
            none

        Functions/Logic:
            - Sets GVAR(disable) to true to disable the module.
*/



GVAR(disable) = true;