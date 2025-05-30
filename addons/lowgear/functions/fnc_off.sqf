#include "../script_component.hpp"

params [];

cutText [localize LSTRING(OFF), "PLAIN DOWN"];

if (GVAR(displayIcon)) then {
	(QGVAR(Rsc) call BIS_fnc_rscLayer) cutText ["", "PLAIN"];
};	

GVAR(ripLowGearActionInUse) = false;
