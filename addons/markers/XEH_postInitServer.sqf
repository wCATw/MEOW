#include "script_component.hpp"

if (!isServer) exitWith {};

diag_log "SWT MARKERS SERVER VERSION 2 ARMA 3";
GVAR(count) = 0;
GVAR(isPlayerBug) = [];
{
	missionNamespace setVariable [(format ["%1_%2", QGVAR(logicServer), _x]),[]];
} forEach ["S","S2","C","GL","V","GR","D"];

GVAR(daytime) = dayTime;
publicVariable QGVAR(daytime);
GVAR(cfgMarkerColors) = "true" configClasses (configFile >> "CfgMarkerColors");
GVAR(cfgMarkerColorsNames) = [];

{
	GVAR(cfgMarkerColorsNames) pushBack (configName _x)
} forEach GVAR(cfgMarkerColors);

if (count GVAR(cfgMarkerColorsNames) != 0) then {
	publicVariable QGVAR(cfgMarkerColorsNames)
};

GVAR(cfgMarkers) = "getNumber (_x >> 'scope') > 0 && !(getText (_x >> 'markerClass') in ['NATO_Sizes','Locations','Flags'])" configClasses (configFile >> "CfgMarkers");
GVAR(cfgMarkersNames) = [];
{GVAR(cfgMarkersNames) pushBack (configName _x)} forEach GVAR(cfgMarkers);
if (count GVAR(cfgMarkersNames) != 0) then {publicVariable QGVAR(cfgMarkersNames)};

QGVAR(clientSend) addPublicVariableEventHandler {
	params ["_varName", "_varValue", "_target"];

	_varValue call FUNC(logicServerRegMark);
};

QGVAR(reqMarkers) addPublicVariableEventHandler {
	params ["_varName", "_varValue", "_target"];

	_varValue call FUNC(logicServerReqMarkers);
};

QGVAR(changeMark) addPublicVariableEventHandler {
	params ["_varName", "_varValue", "_target"];

	_varValue call FUNC(logicServerChangeMark);
};

QGVAR(load) addPublicVariableEventHandler {
	params ["_varName", "_varValue", "_target"];

	_varValue call FUNC(logicServerLoad);
};
