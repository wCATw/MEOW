#include "../script_component.hpp"

params ["_str"];

TRACE_1("called addZero with params:",_str);

if (_str<10) then {
    "0" + str _str;
} else {
    str _str;
};
