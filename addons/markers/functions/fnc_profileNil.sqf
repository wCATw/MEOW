#include "../script_component.hpp"
/*
	Function: fnc_profileNil

		Description:
			Initializes or resets marker-related profile variables and settings. Handles versioning and loads marker/icon/color parameters from profileNamespace.

		Arguments:
			none

		Returns:
			none

		Variables:
			_version    <Number>  - Current version for profile parameters.
*/

private _version = 2;

// Check and set profile version, call default setup if missing or outdated
if (isNil {profileNamespace getVariable QGVAR(paramsVersion)}) then {
	profileNamespace setVariable [QGVAR(paramsVersion),_version];
	saveProfileNamespace;
	call FUNC(def);
};
if ((profileNamespace getVariable QGVAR(paramsVersion)) != _version) exitWith {
	hintSilent (localize LSTRING(OLD));
	profileNamespace setVariable [QGVAR(paramsVersion),_version];
	saveProfileNamespace;
	call FUNC(def);
};

// Load color, icon, and settings parameters from profileNamespace
GVAR(colorSlotParams) = parseSimpleArray str (profileNamespace getVariable [QGVAR(colorSlotParams),[]]);
GVAR(iconSlotParams) = parseSimpleArray str (profileNamespace getVariable [QGVAR(iconSlotParams),[]]);
GVAR(settingsParams) = parseSimpleArray str (profileNamespace getVariable [QGVAR(settingsParams),[]]);

// Initialize global variables for marker UI and logic
GVAR(showButt) = GVAR(settingsParams) select 0;
GVAR(showIcon) = GVAR(settingsParams) select 1;
GVAR(showColor) = GVAR(settingsParams) select 2;
GVAR(showLb) = GVAR(settingsParams) select 3;
GVAR(saveMode) = GVAR(settingsParams) select 4;
GVAR(saveText) = GVAR(settingsParams) select 5;
GVAR(showInfo) = GVAR(settingsParams) select 6;
GVAR(showBack) = GVAR(settingsParams) select 7;
GVAR(saveMark) = GVAR(settingsParams) select 8;
GVAR(fastTextTSaved) = GVAR(settingsParams) select 9;
GVAR(logging) = GVAR(settingsParams) select 10;
GVAR(markInfo) = GVAR(settingsParams) select 11;

// Load marker color and icon config classes
GVAR(cfgMarkerColors) = "true" configClasses (configFile >> "CfgMarkerColors");
GVAR(cfgMarkers) = "getNumber (_x >> 'scope') > 0 && !(getText (_x >> 'markerClass') in ['NATO_Sizes','Locations','Flags'])" configClasses (configFile >> "CfgMarkers");

// Build marker color names array if missing
if (isNil {GVAR(cfgMarkerColorsNames)}) then {
	GVAR(cfgMarkerColorsNames) = [];
	{
		GVAR(cfgMarkerColorsNames) pushBack (configName _x)
	} forEach GVAR(cfgMarkerColors);
};

// Build marker icon names array if missing
if (isNil {GVAR(cfgMarkersNames)}) then {
	GVAR(cfgMarkersNames) = [];
	{GVAR(cfgMarkersNames) pushBack (configName _x)} forEach GVAR(cfgMarkers);
};

GVAR(text) = "";
GVAR(loaded) = false;

// Set default marker type and icon if not present
if (isNil {GVAR(markType)}) then {
	GVAR(markType) = GVAR(iconSlotParams) select 0;
	GVAR(pic) = getText (configFile >> "cfgMarkers" >> GVAR(markType) >> "icon");
};

// Set default marker color and color array if not present
if (isNil {GVAR(markColor)}) then {
	GVAR(markColor) = GVAR(colorSlotParams) select 0;
	GVAR(colorArr) = getArray (configFile >> "CfgMarkerColors" >> GVAR(markColor) >> "color");
	{
		// Parse non-scalar color array entries
		if (typeName _x != "SCALAR") then {
			GVAR(colorArr) set [_forEachIndex, call compile _x];
		};
	} forEach GVAR(colorArr);
};