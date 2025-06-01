#include "../script_component.hpp"
/*
    Function: fnc_addZero

        Description:
            Formats a number as a string, adding a leading zero if it is less than 10.

        Arguments:
            _num   <Scalar>  - The number to format.

        Returns:
            <String> - The formatted number as a string, with leading zero if needed.

        Variables:
            _num   <Scalar>  - The number to format.
*/



params ["_num"];

PARAM_INVALID(_num,"SCALAR")

if (_num<10) then {
    format ["0%1",str _num];
} else {
    str _num;
};
