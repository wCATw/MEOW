#include "../script_component.hpp"

params ["_control"];

TRACE_1("called unLoad with params:",_control);

GVAR(loadDone) = nil;
GVAR(dClBut) = nil;
GVAR(advSet) = nil;
GVAR(RscDisplayInsertMarkerInfo) = nil;
GVAR(RscDisplayInsertMarkerSetButton) = nil;
GVAR(text) = ctrlText (_control displayCtrl IDC_TEXT);
if !(GVAR(saveMark)) then {
	GVAR(markType) = GVAR(iconSlotParams) select 0;
	GVAR(markColor) = GVAR(colorSlotParams) select 0;
	GVAR(pic) = getText (configFile >> "cfgMarkers" >> GVAR(markType) >> "icon");
	GVAR(colorArr) = getArray (configFile >> "CfgMarkerColors" >> GVAR(markColor) >> "color");
	{
		if (typeName _x != "SCALAR") then {
			GVAR(colorArr) set [_forEachIndex, call compile _x];
		};
	} forEach GVAR(colorArr);
	GVAR(sweetkS) = 1;
};
if !(GVAR(saveMode)) then {
	GVAR(fastTextG) = false;
	GVAR(fastTextN) = false;
	GVAR(fastTextT) = false;
};