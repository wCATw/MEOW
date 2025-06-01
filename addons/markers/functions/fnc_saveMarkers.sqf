#include "../script_component.hpp"
/*
	Function: fnc_saveMarkers

		Description:
			Saves the current marker parameters to the clipboard or to the profile namespace for persistence.

		Arguments:
			_this   <String>  - If "CLIP", saves to clipboard; otherwise saves to profile namespace.

		Returns:
			none

		Variables:
			_arr        <Array>   - Copy of all marker parameters.
			_arr_copy   <Array>   - Array of marker data to save.
*/

GVAR_ISNIL(allMarkersParams)
GVAR_ISNIL(saveArr)

private ["_arr", "_arr_copy"];
_arr = + GVAR(allMarkersParams);
_arr_copy = [];
{
	// Copy marker parameters, trim unnecessary data (remove first 2 and all after 6th element)
	_tmp = + _x;
	_tmp deleteRange [0,2];
	_tmp deleteRange [6,count _tmp - 1];
	_arr_copy pushBack (+ _tmp);
} forEach _arr;

forceUnicode 1;

// Save to clipboard or profileNamespace depending on argument
if (_this isEqualTo "CLIP") then {
	copyToClipboard str _arr_copy
} else {
	profileNamespace setVariable [QGVAR(saveArr),_arr_copy]
};
saveProfileNamespace;

// Show a hint with the number of saved markers
hintSilent format [localize LSTRING(SAVEDMARKS),count _arr_copy];