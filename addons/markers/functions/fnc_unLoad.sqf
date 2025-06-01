#include "../script_component.hpp"
/*
	Description:
		Handles the unloading/cleanup of marker UI display. Resets or clears global marker-related variables and states when the marker dialog is closed or unloaded.

	Arguments:
		_display      <Display>  - The display being unloaded.

	Returns:
		none

	Variables:
		none
*/

params ["_display"];

// Validate _display parameter
PARAM_INVALID(_display,"DISPLAY")
GVAR_ISNIL(saveMark)
GVAR_ISNIL(markType)
GVAR_ISNIL(markColor)
GVAR_ISNIL(pic)
GVAR_ISNIL(colorArr)
GVAR_ISNIL(iconSlotParams)
GVAR_ISNIL(saveMode)

// Reset/clear marker UI state globals
GVAR(loadDone) = nil;
GVAR(dClBut) = nil;
GVAR(advSet) = nil;
GVAR(RscDisplayInsertMarkerInfo) = nil;
GVAR(RscDisplayInsertMarkerSetButton) = nil;
GVAR(text) = ctrlText (_display displayCtrl IDC_TEXT);

// If no saved marker, restore marker type, color, icon, color array from slot/config
if !(GVAR(saveMark)) then {
	GVAR(markType) = GVAR(iconSlotParams) select 0;
	GVAR(markColor) = GVAR(colorSlotParams) select 0;
	GVAR(pic) = getText (configFile >> "cfgMarkers" >> GVAR(markType) >> "icon");
	GVAR(colorArr) = getArray (configFile >> "CfgMarkerColors" >> GVAR(markColor) >> "color");
	{
		// Convert non-scalar color array entries to code
		if (typeName _x != "SCALAR") then {
			GVAR(colorArr) set [_forEachIndex, call compile _x];
		};
	} forEach GVAR(colorArr);
	GVAR(sweetkS) = 1;
};

// If not in save mode, reset fast text globals
if !(GVAR(saveMode)) then {
	GVAR(fastTextG) = false;
	GVAR(fastTextN) = false;
	GVAR(fastTextT) = false;
};
