#include "../script_component.hpp"

params ["_num"];

PARAM_INVALID(_num,"SCALAR")

if (_num<10) then {
    format ["0%1",str _num];
} else {
    str _num;
};
