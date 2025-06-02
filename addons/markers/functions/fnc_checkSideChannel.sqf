#include "../script_component.hpp"
	/*
		Function: fnc_checkSideChannel

			Description:
				Determines if the player has the ability to use the side channel for markers, based on mission state and equipment.

			Arguments:
				none
				Global:
					wmaptools_frzState <Any>  - Mission freeze state (read)
					limitSideMarkers   <Any>  - Controls side channel access (read)

			Returns:
				<Bool> - True if the player can use the side channel, false otherwise.

			Variables:
				_hasAbility   <Bool>  - Whether the player can use the side channel.
	*/

EGVAR_ISNIL(wmaptools,frzState)
GVAR_ISNIL(limitSideMarkers)

private _hasAbility = false;

// Allow if mission not frozen or just started
if (missionNamespace getVariable [QEGVAR(wmaptools,frzState),10] < 3 || time < 10) then {
	_hasAbility = true;
};

// Check for GPS or UAV terminal in assigned items, or LR radio via TFAR
switch (true) do {
	case (GVAR(limitSideMarkers) in [0,2] && "ItemGPS" in assignedItems player);
	case (GVAR(limitSideMarkers) in [0,2] && count (["B_UavTerminal","O_UavTerminal","I_UavTerminal","C_UavTerminal","I_E_UavTerminal","B_ION_UavTerminal_F","O_R_UavTerminal_F"] arrayIntersect assignedItems player) > 0);
	case (!isNil {TFAR_fnc_haveLRRadio} && {call TFAR_fnc_haveLRRadio}): {
		_hasAbility = true;
	};
};

_hasAbility