#include "../script_component.hpp"
/*
    Function: fnc_addZero

        Description:
            Formats a number (scalar or string) as a string, adding leading zeros to reach the specified minimum length (power).
            Will not truncate if the number is already longer than the specified length.

        Arguments:
            _num   <Scalar|String>  - The number to format.
            _power <Scalar>         default: 2  - The minimum length of the resulting string.

        Returns:
            <String> - The formatted number as a string, padded with leading zeros if needed.

        Variables:
            _num   <Scalar|String>  - The number to format.
            _power <Scalar>         - The minimum length of the resulting string.

        @example
            [1,3] call fnc_addZero;      // "001"
            [123,4] call fnc_addZero;    // "0123"
            [1234,2] call fnc_addZero;   // "1234"
*/

private _num = param[0, 0, [0]];
private _power = param[1, 2, [0]];

PARAM_INVALID(_power,"SCALAR")

private _strNum = str _num;

// Calculate how many zeros to pad
private _padLength = _power - count _strNum;

// If padding is needed, prepend zeros
if (_padLength > 0) then {
    private _zeros = "";
    for "_i" from 1 to _padLength do {
        _zeros = _zeros + "0";
    };
    _zeros + _strNum
} else {
    _strNum
};