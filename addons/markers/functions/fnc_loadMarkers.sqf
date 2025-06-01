#include "../script_component.hpp"

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

if (GVAR(loadEnabled) and ((GVAR(loadEnabledFor) and (((leader player == player) or (((effectiveCommander (vehicle player)) == player) and (isNull objectParent player))))) or (!(GVAR(loadEnabledFor))))and((GVAR(loadEnabledWhen))or((!(GVAR(loadEnabledWhen)))and(time<=0)))) then {
	private ["_arr"];
	_arr = (if (isNil {_array}) then {[] + parseSimpleArray str (profileNamespace getVariable [QGVAR(saveArr),[]])} else {parseSimpleArray _array});
	if ((_arr isNotEqualTo [])) then {
		if (count _arr > 500) exitWith {hintSilent (format [localize LSTRING(CANTLOAD), count _arr, 500]);};
		_copyArr = [];
		{
			_copyArr pushBack (["",""] + _x);
		} forEach _arr;
		GVAR(load) = [player, _copyArr];
		publicVariableServer QGVAR(load);
		if (isServer && !isMultiplayer) then {GVAR(load) call FUNC(logicServerLoad);};
		(_control select 0) ctrlEnable false;
		GVAR(loaded) = true;
	} else {
		hintSilent (localize LSTRING(NOMARKS));
	};
} else {hintSilent (localize LSTRING(CANTDO))};