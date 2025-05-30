#include "../script_component.hpp"

private _hasAbility = false;

if (missionNamespace getVariable [QEGVAR(wmaptools,frzState), 10] < 3 || time < 10) then {
	_hasAbility = true;
};

switch (true) do {
	case (GVAR(limitSideMarkers) in [0,2] && "ItemGPS" in assignedItems player);
	case (GVAR(limitSideMarkers) in [0,2] && count (["B_UavTerminal", "O_UavTerminal", "I_UavTerminal", "C_UavTerminal", "I_E_UavTerminal", "B_ION_UavTerminal_F", "O_R_UavTerminal_F"] arrayIntersect assignedItems player) > 0);
	case (!isNil {TFAR_fnc_haveLRRadio} && {call TFAR_fnc_haveLRRadio}): {
		_hasAbility = true;
	};
};

_hasAbility