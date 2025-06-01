#include "../script_component.hpp"

params ["_str"];

PARAM_INVALID(_str,"STRING")

if (_str<10) then {
    "0" + str _str;
} else {
    str _str;
};
