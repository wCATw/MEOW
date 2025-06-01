#include "../script_component.hpp"

params ["_action", "_params"];

PARAM_INVALID(_action,"STRING")
PARAM_INVALID(_params,"ARRAY")
GVAR_ISNIL(disable)
GVAR_ISNIL(markDir)
GVAR_ISNIL(markType)
GVAR_ISNIL(markColor)
GVAR_ISNIL(cfgMarkersNames)
GVAR_ISNIL(cfgMarkerColorsNames)
GVAR_ISNIL(fastTextG)
GVAR_ISNIL(fastTextN)
GVAR_ISNIL(fastTextT)
GVAR_ISNIL(fastTextTSaved)
GVAR_ISNIL(channel)
GVAR_ISNIL(posM)
GVAR_ISNIL(saveText)
GVAR_ISNIL(text)
GVAR_ISNIL(ctrlState)
GVAR_ISNIL(sweetkS)
GVAR_ISNIL(clientSend)
GVAR_ISNIL(limitSideMarkers)

if (GVAR(disable)) exitWith {hintSilent (localize LSTRING(DISABLED)); true};

GVAR(markDir) = 0;

private ["_displayMark", "_displayMap", "_text", "_WordlCoord", "_send", "_channel", "_go"];

_displayMark = displayNull;
_displayMap = ({if !(isNull(findDisplay _x)) exitWith {findDisplay _x}} forEach [37,52,53,12]);
(_displayMap displayCtrl IDC_BUTTON_ADV) ctrlShow false;
_text = "" + (if (GVAR(fastTextG)) then {((groupId (group player)) call EFUNC(wmaptools,longGroupNameToShort)) + " "} else {""}) + (if (GVAR(fastTextN)) then {name player + " "} else {""}) + (if (GVAR(fastTextT)) then {GVAR(fastTextTSaved) + " "} else {""});

_WorldCoord = [];
_send = [player];
_channel = "";
_swtid = "SWT_M#0";
_go = true;
switch (GVAR(channel)) do {
	case (localize "str_channel_side"): {
		_channel = "S";
		_go = call FUNC(checkSideChannel);
		if (!_go && !isNil "CBA_fnc_localEvent") then {
			[
				"ace_common_displayTextStructured",
				[localize (format ["%1_%2", LSTRING(SET_LIMIT_SIDE_MARKERS_MSG), str GVAR(limitSideMarkers)]), 2]
			] call CBA_fnc_localEvent;
		};
	};

	case (localize "STR_Channel_Command"): {
		_channel = "C";
		if !((leader player == player) or (((effectiveCommander (vehicle player)) == player) and (isNull objectParent player))) exitWith {
			_go = false;
			hintSilent "You aren't a team leader";
		}
	};

	case (localize "STR_Channel_Direct"): {
		_channel = "D";
	};

	case (localize "STR_Channel_Global"): {
		_channel = "GL";
	};

	case (localize "STR_Channel_Vehicle"): {
		_channel = "V";
		if (isNull objectParent player) exitWith {
			_go = false;
			hintSilent "You aren't in a vehicle";
		};
	};

	case (localize "STR_Channel_Group"): {
		_channel = "GR";
	};

    default {
		GVAR(channel) = localize "STR_Channel_Group";
     	_channel = "GR";
    };
};


if (!_go) exitWith {};

switch (_action) do {
    case "mark": {
    	[0,0] call FUNC(mapMouseUp);
		_displayMark = _params;
		_WorldCoord = (_displayMap displayCtrl 51) ctrlMapScreenToWorld [((ctrlPosition (_displayMark displayCtrl IDC_PICTURE)) select 0)+((ctrlPosition (_displayMark displayCtrl IDC_PICTURE)) select 2)/2,((ctrlPosition (_displayMark displayCtrl IDC_PICTURE)) select 1)+((ctrlPosition (_displayMark displayCtrl IDC_PICTURE)) select 3)/2];
		_text =  _text + ctrlText (_displayMark displayCtrl IDC_TEXT);
		_send pushBack [_swtid,_channel,_text, _WorldCoord, GVAR(cfgMarkersNames) find GVAR(markType), GVAR(cfgMarkerColorsNames) find GVAR(markColor), GVAR(markDir), GVAR(sweetkS), name player];
		if (!(GVAR(ctrlState))) then {(_displayMark closeDisplay 0)};
    };
	case "fast": {
		_WorldCoord = (_displayMap displayCtrl 51) ctrlMapScreenToWorld GVAR(posM);
		if (GVAR(saveText)) then {_text = _text + GVAR(text)};
		_send pushBack [_swtid,_channel,_text,_WorldCoord,GVAR(cfgMarkersNames) find GVAR(markType),GVAR(cfgMarkerColorsNames) find GVAR(markColor),GVAR(markDir),GVAR(sweetkS), name player];
	};
	case "line": {
	    _send pushBack [_swtid,_channel,"",[(((_params select 0) select 0) + ((_params select 1) select 0))/2,(((_params select 0) select 1) + ((_params select 1) select 1))/2],-2,GVAR(cfgMarkerColorsNames) find GVAR(markColor),_params select 2,[_params select 3,_params select 4], name player];
	};
	case "ellipse": {
		_send pushBack [_swtid,_channel,"",[(_params select 0) select 0,(_params select 0) select 1],-3,GVAR(cfgMarkerColorsNames) find GVAR(markColor),0,[abs(((_params select 1) select 0) - ((_params select 0) select 0)),abs(((_params select 1) select 1) - ((_params select 0) select 1))], name player];
	};
	case "road": {
		_send pushBack [_swtid,_channel,"",[_params select 0, _params select 1], GVAR(cfgMarkersNames) find GVAR(markType),GVAR(cfgMarkerColorsNames) find GVAR(markColor),GVAR(markDir),GVAR(sweetkS), name player];
	};
};

GVAR(clientSend) = _send;
publicVariableServer QGVAR(clientSend);
if ((isServer) and !(isMultiplayer)) then {GVAR(clientSend) call FUNC(logicServerRegMark);};

true;
