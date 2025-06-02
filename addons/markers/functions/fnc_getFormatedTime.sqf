#include "../script_component.hpp"
/*
    Function: fnc_getFormatedTime

        Description:
            Returns a formatted time string (HH:MM:SS) for a given time in seconds.

        Arguments:
            _time   <Scalar>  - Time in seconds to format.

        Returns:
            <String> - Formatted time string "HH:MM:SS".

        Variables:
            _time   <Scalar>  - Input time in seconds.
            _hour   <Scalar>  - Hours part of the time.
            _minute <Scalar>  - Minutes part of the time.
            _second <Scalar>  - Seconds part of the time.
*/
private _time = param [0, time, [0]];

PARAM_INVALID(_time,"SCALAR")

_hour = floor(abs(_time)/3600);
_minute = floor(abs(_time)/60)%60;
_second = round(abs(_time)%60);
format [
    "%1:%2:%3", 
    _hour call FUNC(addZero), 
    _minute call FUNC(addZero), 
    _second call FUNC(addZero)
];