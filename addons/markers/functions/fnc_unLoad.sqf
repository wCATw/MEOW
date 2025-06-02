#include "../script_component.hpp"
	/*
		Description:
			Handles the unloading/cleanup of marker UI display. Resets or clears global marker-related variables and states when the marker dialog is closed or unloaded.

		Arguments:
			_display      <Display>  - The display being unloaded.
			Global:
				saveMark        <Bool>   - If true, marker is saved (read)
				markType        <String> - Marker type (read/set)
				markColor       <String> - Marker color (read/set)
				pic             <String> - Marker icon (read/set)
				colorArr        <Array>  - Marker color array (read/set)
				iconSlotParams  <Array>  - Icon slot parameters (read)
				colorSlotParams <Array>  - Color slot parameters (read)
				saveMode        <Bool>   - Save mode flag (read)

		Returns:
			none
			Global:
				markType        <String> - Marker type (set)
				markColor       <String> - Marker color (set)
				pic             <String> - Marker icon (set)
				colorArr        <Array>  - Marker color array (set)
				text            <String> - Marker text (set)
				loadDone        <Any>    - Load done state (set)
				dClBut          <Any>    - dClBut state (set)
				advSet          <Any>    - advSet state (set)
				RscDisplayInsertMarkerInfo <Any> - UI state (set)
				RscDisplayInsertMarkerSetButton <Any> - UI state (set)
				sweetkS         <Any>    - SweetkS value (set)
				fastTextG       <Bool>   - Fast text group flag (set)
				fastTextN       <Bool>   - Fast text name flag (set)
				fastTextT       <Bool>   - Fast text text flag (set)

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
