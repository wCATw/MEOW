#include "../script_component.hpp"
/*
	Function: fnc_loadMarkers

		Description:
			Loads markers from an array or from the profile namespace, sending them to the server for processing and enabling/disabling the control as needed.

		Arguments:
			_control   <Control>  - The control to enable/disable.
			_array     <Array>    - The array of markers to load (optional).

		Returns:
			none

		Variables:
			_arr, _copyArr
*/

params ["_control", "_array"];

PARAM_INVALID(_control,"CONTROL")
PARAM_INVALID(_array,"ARRAY")
GVAR_ISNIL(loadEnabled)
GVAR_ISNIL(loadEnabledFor)
GVAR_ISNIL(loadEnabledWhen)
GVAR_ISNIL(loaded)
GVAR_ISNIL(saveArr)
GVAR_ISNIL(load)
GVAR_ISNIL(logicServerLoad)

// Check if loading is allowed for this player and situation
if (GVAR(loadEnabled) and ((GVAR(loadEnabledFor) and (((leader player == player) or (((effectiveCommander (vehicle player)) == player) and (isNull objectParent player))))) or (!(GVAR(loadEnabledFor))))and((GVAR(loadEnabledWhen))or((!(GVAR(loadEnabledWhen)))and(time<=0)))) then {
	private ["_arr"];
	// Load markers from argument or profileNamespace
	_arr = (if (isNil {_array}) then {[] + parseSimpleArray str (profileNamespace getVariable [QGVAR(saveArr),[]])} else {parseSimpleArray _array});
	if ((_arr isNotEqualTo [])) then {
		// Prevent loading too many markers
		if (count _arr > 500) exitWith {hintSilent (format [localize LSTRING(CANTLOAD), count _arr, 500]);};
		_copyArr = [];
		{
			// Pad marker data for server compatibility
			_copyArr pushBack (["",""] + _x);
		} forEach _arr;
		GVAR(load) = [player, _copyArr];
		publicVariableServer QGVAR(load);
		// If SP, process directly
		if (isServer && !isMultiplayer) then {GVAR(load) call FUNC(logicServerLoad);};
		(_control select 0) ctrlEnable false;
		GVAR(loaded) = true;
	} else {
		// No markers to load
		hintSilent (localize LSTRING(NOMARKS));
	};
} else {
	// Loading not allowed
	hintSilent (localize LSTRING(CANTDO));
};