#include "../script_component.hpp"
	/*
		Function: fnc_sendMark

			Description:
				Handles sending of marker data to the server or other clients, based on user action (mark, fast, line, ellipse, road). Prepares marker data and manages channel logic, permissions, and UI state.

			Arguments:
				_action   <String>  - The action type ("mark", "fast", "line", "ellipse", "road").
				_params   <Array>   - Parameters for the action (may include controls, positions, etc).
				Global:
					disable             <Bool>   - If true, disables marker sending (read)
					markType            <String> - Current marker type (read)
					markColor           <String> - Current marker color (read)
					cfgMarkersNames     <Array>  - Marker type names (read)
					cfgMarkerColorsNames<Array>  - Marker color names (read)
					fastTextG           <Bool>   - Fast text group flag (read)
					fastTextN           <Bool>   - Fast text name flag (read)
					fastTextT           <Bool>   - Fast text text flag (read)
					fastTextTSaved      <String> - Saved fast text (read)
					channel             <String> - Current channel (read)
					posM                <Array>  - Marker position (read)
					saveText            <Bool>   - Save text flag (read)
					text                <String> - Marker text (read)
					ctrlState           <Bool>   - Control key state (read)
					sweetkS             <Any>    - SweetkS value (read)
					limitSideMarkers    <Any>    - Side marker limit (read)

			Returns:
				<Bool> - True if the marker was sent or action completed, false/empty otherwise.
				Global:
					markDir             <Scalar> - Direction of the marker (set)

			Variables:
				_action         <String>  - Action type.
				_params         <Array>   - Action parameters.
				_displayMap     <Display> - The map display.
				_text           <String>  - Marker text.
				_WorldCoord     <Array>   - World coordinates for the marker.
				_send           <Array>   - Array of marker data to send.
				_channel        <String>  - Channel code.
				_go             <Bool>    - Whether the action is allowed.
				_swtid          <String>  - Marker ID prefix.
	*/

params ["_action", "_params"];

PARAM_INVALID(_action,"STRING")
PARAM_INVALID(_params,"ARRAY") // CAN BE CONTROL
GVAR_ISNIL(disable)
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
GVAR_ISNIL(limitSideMarkers)

// Exit if disabled
if (GVAR(disable)) exitWith {hintSilent (localize LSTRING(DISABLED)); true};

GVAR(markDir) = 0;

private ["_displayMap", "_text", "_WorldCoord", "_send", "_channel", "_go", "_swtid"];

// Find open map display, hide advanced button
_displayMap = ({if !(isNull(findDisplay _x)) exitWith {findDisplay _x}} forEach [37,52,53,12]);
(_displayMap displayCtrl IDC_BUTTON_ADV) ctrlShow false;

// Compose marker text from fast text options
_text = "" + (if (GVAR(fastTextG)) then {((groupId (group player)) call EFUNC(wmaptools,longGroupNameToShort)) + " "} else {""}) + (if (GVAR(fastTextN)) then {name player + " "} else {""}) + (if (GVAR(fastTextT)) then {GVAR(fastTextTSaved) + " "} else {""});

_WorldCoord = [];
_send = [player];
_channel = "";
_swtid = "SWT_M#0";
_go = true;

// Channel/permission logic
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

// Exit if not allowed
if (!_go) exitWith {};

// Handle marker actions, prepare marker data
switch (_action) do {
	case "mark": {
		[0,0] call FUNC(mapMouseUp);
		private _displayMark = _params # 0;
		// Get world coordinates from UI control
		_WorldCoord = (_displayMap displayCtrl IDC_MAP) ctrlMapScreenToWorld [
			((ctrlPosition (_displayMark displayCtrl IDC_PICTURE)) select 0) + ((ctrlPosition (_displayMark displayCtrl IDC_PICTURE)) select 2)/2,
			((ctrlPosition (_displayMark displayCtrl IDC_PICTURE)) select 1) + ((ctrlPosition (_displayMark displayCtrl IDC_PICTURE)) select 3)/2
		];
		_text = _text + ctrlText (_displayMark displayCtrl IDC_TEXT);
		_send pushBack [
			_swtid,
			_channel,
			_text,
			_WorldCoord,
			GVAR(cfgMarkersNames) find GVAR(markType),
			GVAR(cfgMarkerColorsNames) find GVAR(markColor),
			GVAR(markDir),
			GVAR(sweetkS),
			name player
		];
		if (!(GVAR(ctrlState))) then {
			(_displayMark closeDisplay 0)
		};
	};
	case "fast": {
		// Fast marker, use saved position and text
		_WorldCoord = (_displayMap displayCtrl IDC_MAP) ctrlMapScreenToWorld GVAR(posM);
		if (GVAR(saveText)) then {
			_text = _text + GVAR(text)
		};
		_send pushBack [
			_swtid,
			_channel,
			_text,
			_WorldCoord,
			GVAR(cfgMarkersNames) find GVAR(markType),
			GVAR(cfgMarkerColorsNames) find GVAR(markColor),
			GVAR(markDir),
			GVAR(sweetkS),
			name player
		];
	};
	case "line": {
		// Line marker, use two positions and extra params
		_send pushBack [
			_swtid,
			_channel,
			"",
			[
				(((_params select 0) select 0) + ((_params select 1) select 0))/2,
				(((_params select 0) select 1) + ((_params select 1) select 1))/2
			],
			-2,
			GVAR(cfgMarkerColorsNames) find GVAR(markColor),
			_params select 2,
			[
				_params select 3,
				_params select 4
			],
			name player
		];
	};
	case "ellipse": {
		// Ellipse marker, use two positions for center and size
		_send pushBack [
			_swtid,
			_channel,
			"",
			[
				(_params select 0) select 0,
				(_params select 0) select 1
			],
			-3,
			GVAR(cfgMarkerColorsNames) find GVAR(markColor),
			0,
			[
				abs(((_params select 1) select 0) - ((_params select 0) select 0)),
				abs(((_params select 1) select 1) - ((_params select 0) select 1))
			],
			name player
		];
	};
	case "road": {
		// Road marker, use two positions
		_send pushBack [
			_swtid,
			_channel,
			"",
			[
				_params select 0,
				_params select 1
			],
			GVAR(cfgMarkersNames) find GVAR(markType),
			GVAR(cfgMarkerColorsNames) find GVAR(markColor),
			GVAR(markDir),
			GVAR(sweetkS),
			name player
		];
	};
};

// Send marker data to server, or log locally in SP
GVAR(clientSend) = _send;
publicVariableServer QGVAR(clientSend);
if ((isServer) and !(isMultiplayer)) then {GVAR(clientSend) call FUNC(logicServerRegMark);};

true;
