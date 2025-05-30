#include "../script_component.hpp"

private _version = 2;
if (isNil {profileNamespace getVariable QGVAR(paramsVersion)}) then {
	profileNamespace setVariable [QGVAR(paramsVersion), _version];
	saveProfileNamespace;
	call FUNC(def);
};
if ((profileNamespace getVariable QGVAR(paramsVersion)) != _version) exitWith {
	hintSilent (localize LSTRING(OLD));
	profileNamespace setVariable [QGVAR(paramsVersion), _version];
	saveProfileNamespace;
	call FUNC(def);
};

GVAR(colorSlotParams) = parseSimpleArray str (profileNamespace getVariable [QGVAR(colorSlotParams),[]]);
GVAR(iconSlotParams) = parseSimpleArray str (profileNamespace getVariable [QGVAR(iconSlotParams),[]]);
GVAR(settingsParams) = parseSimpleArray str (profileNamespace getVariable [QGVAR(settingsParams),[]]);
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

GVAR(cfgMarkerColors) = "true" configClasses (configFile >> "CfgMarkerColors");
GVAR(cfgMarkers) = "getNumber (_x >> 'scope') > 0 && !(getText (_x >> 'markerClass') in ['NATO_Sizes','Locations','Flags'])" configClasses (configFile >> "CfgMarkers");
if (isNil {GVAR(cfgMarkerColorsNames)}) then {
	GVAR(cfgMarkerColorsNames) = [];
	{
		GVAR(cfgMarkerColorsNames) pushBack (configName _x)
	} forEach GVAR(cfgMarkerColors);
};

if (isNil {GVAR(cfgMarkersNames)}) then {
	GVAR(cfgMarkersNames) = [];
	{GVAR(cfgMarkersNames) pushBack (configName _x)} forEach GVAR(cfgMarkers);
};

GVAR(text) = "";
GVAR(loaded) = false;

if (isNil {GVAR(markType)}) then {
	GVAR(markType) = GVAR(iconSlotParams) select 0;
	GVAR(pic) = getText (configFile >> "cfgMarkers" >> GVAR(markType) >> "icon");
};

if (isNil {GVAR(markColor)}) then {
	GVAR(markColor) = GVAR(colorSlotParams) select 0;
	GVAR(colorArr) = getArray (configFile >> "CfgMarkerColors" >> GVAR(markColor) >> "color");
	{
		if (typeName _x != "SCALAR") then {
			GVAR(colorArr) set [_forEachIndex, call compile _x];
		};
	} forEach GVAR(colorArr);
};