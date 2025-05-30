#include "script_component.hpp"

if (!hasInterface) exitWith {};

GVAR(disable)             = false;
GVAR(loadEnabled)         = true;
GVAR(loadEnabledFor)      = true;
GVAR(loadEnabledWhen)     = true;
// GVAR(bisMarkers)          = false;
GVAR(sweetkS)             = 1;
GVAR(time)                = 0;
GVAR(mapTime)             = 0;
GVAR(fastTextN)           = false;
GVAR(fastTextG)           = false;
GVAR(fastTextT)           = false;
GVAR(shiftState)          = false;
GVAR(ctrlState)           = false;
GVAR(altState)            = false;
GVAR(channel)             = localize "STR_Channel_Group";
GVAR(delayCoeff)          = 25;
GVAR(MarkersLog)          = localize LSTRING(MARKERS_LOG);
GVAR(hold)                = false;
GVAR(allChannels)         = [localize "STR_Channel_Global",localize "STR_Channel_Side",localize "STR_Channel_Command",localize "STR_Channel_Group",localize "STR_Channel_Vehicle",localize "STR_Channel_Direct"];
GVAR(availableChannels)   = +GVAR(allChannels);
GVAR(unavailableChannels) = getArray (missionConfigFile >> "disableChannels");

if (isNil {GVAR(posM)}) then {GVAR(posM) = [0,0]};

_arr = GVAR(availableChannels);
GVAR(availableChannels) = [];
{
	if !(_forEachIndex in GVAR(unavailableChannels)) then {
		GVAR(availableChannels) pushBack _x;
	};
} forEach _arr;


GVAR(allMarkers) = [];
GVAR(allMarkersParams) = [];
GVAR(disableLoc) = false;

addMissionEventHandler ["Map", {
	params ["_mapIsOpened", "_mapIsForced"];
	if (_mapIsOpened) then {
		[] call FUNC(dimMarkersFromOtherChannels);
	};
}];


[QGVAR(channelChanged), FUNC(dimMarkersFromOtherChannels)] call CBA_fnc_addEventHandler;

QGVAR(sendMark) addPublicVariableEventHandler {
	params ["_varName", "_varValue", "_target"];

	_varValue call FUNC(clientLogicCreate);
};
QGVAR(sendDel) addPublicVariableEventHandler {
	params ["_varName", "_varValue", "_target"];

	_varValue call FUNC(clientLogicDel);
};
QGVAR(sendDir) addPublicVariableEventHandler {
	params ["_varName", "_varValue", "_target"];

	_varValue call FUNC(clientLogicDir);
};
QGVAR(sendPos) addPublicVariableEventHandler {
	params ["_varName", "_varValue", "_target"];

	_varValue call FUNC(clientLogicPos);
};
QGVAR(sendJIP) addPublicVariableEventHandler {
	params ["_varName", "_varValue", "_target"];

	_markers = _varValue;
	{
		_x call FUNC(CreateMarker);
	} forEach (_markers);
};

QGVAR(sendLoad) addPublicVariableEventHandler {
	params ["_varName", "_varValue", "_target"];

	_varValue call FUNC(clientLogicLoad);
};

waitUntil {!isNull player};
GVAR(reqMarkers) = player;
publicVariableServer QGVAR(reqMarkers);
if (GVAR(logging)) then {
	player createDiarySubject [QGVAR(MarkersLog),GVAR(MarkersLog)];
};

GVAR(dimMarkersHandle) = 0 spawn {
	while {true} do {
		sleep 61.2;
		if(alive player) then {
			[] call FUNC(dimMarkersFromOtherChannels);
		};
	};
};

if (isNil {EGVAR(wmaptools,frzState)}) then {
	EGVAR(wmaptools,frzState) = 3;
};

waitUntil {((missionNamespace getVariable [QEGVAR(wmaptools,frzState),3]) >= 3)};
{ _x set [11, CBA_missionTime]; } forEach GVAR(allMarkersParams);