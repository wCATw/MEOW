#include "../script_component.hpp"

private ["_arr", "_arr_copy"];
_arr = + GVAR(allMarkersParams);
_arr_copy = [];
{
	_tmp = + _x;
	_tmp deleteRange [0,2];
	_tmp deleteRange [6,count _tmp - 1];
	_arr_copy pushBack (+ _tmp);
} forEach _arr;
forceUnicode 1;
if (_this isEqualTo "CLIP") then {copyToClipboard str _arr_copy} else {profileNamespace setVariable [QGVAR(saveArr), _arr_copy]};
saveProfileNamespace;
hintSilent format [localize LSTRING(SAVEDMARKS), count _arr_copy];