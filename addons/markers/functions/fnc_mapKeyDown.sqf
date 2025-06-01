#include "../script_component.hpp"
/*
	Description:
	Handles key down events on the map, allowing marker thickness adjustment and marker deletion.

	Arguments:
		_display <DISPLAY> - The display where the event occurred
		_dikCode <SCALAR> - The DIK key code
		_shift <BOOL> - Shift key state
		_ctrlKey <BOOL> - Ctrl key state
		_alt <BOOL> - Alt key state

	Returns:
		<BOOL> - True if event handled, false otherwise

	Variables:
		GVAR(posM) <ARRAY> - Mouse position
		GVAR(allMarkers) <ARRAY> - All marker IDs
		GVAR(disableLoc) <BOOL> - Whether marker deletion is disabled
*/

params ["_display", "_dikCode", "_shift", "_ctrlKey", "_alt"];

PARAM_INVALID(_display,"DISPLAY")
PARAM_INVALID(_dikCode,"SCALAR")
PARAM_INVALID(_shift,"BOOL")
PARAM_INVALID(_ctrlKey,"BOOL")
PARAM_INVALID(_alt,"BOOL")
GVAR_ISNIL(posM)
GVAR_ISNIL(allMarkers)
GVAR_ISNIL(disableLoc)

if (!isNil {GVAR(lineParamsWorld)}) then {
	// Adjust marker thickness with Alt (increase) or Ctrl (decrease)
	if ((_alt || _ctrlKey) && !(_alt && _ctrlKey)) then {
		_thickness = GVAR(lineParamsWorld) select 3;
		if (_alt) then {
			_thickness = _thickness + 5;
			if (_thickness <= 100) then {
				GVAR(lineParamsWorld) set [3, _thickness];
				"SWT_MARKERS LOCAL INFO" setMarkerTextLocal format [localize LSTRING(THICKNESS), _thickness];
			};
		} else {
			if (_ctrlKey) then {
				_thickness = _thickness - 5;
				if (_thickness >= 5) then {
					GVAR(lineParamsWorld) set [3, _thickness];
					"SWT_MARKERS LOCAL INFO" setMarkerTextLocal format [localize LSTRING(THICKNESS), _thickness];
				};
			};
		};
		// Update marker size to reflect new thickness
		"SWT_MARKERS LOCAL LINE" setMarkerSizeLocal [GVAR(lineParamsWorld) select 3,(((GVAR(lineParamsWorld) select 0) distance (GVAR(lineParamsWorld) select 1)))/2];
		true
	};
} else {
	// Handle marker deletion with Delete key
	if (_dikCode == DIK_DELETE) then {
		if (GVAR(disableLoc)) exitWith {diag_log "SWT MARKERS: DEL DISABLED";};
		{
			private _pos = getMarkerPos _x;
			_pos = (_display displayCtrl IDC_MAP) ctrlMapWorldToScreen _pos;
			// Delete marker if mouse is close enough
			if (([_pos,GVAR(posM)] call BIS_fnc_distance2D) < 0.025) exitWith {
				GVAR(changeMark)  = ["DEL", player, _x, _x call FUNC(getChannel)];
				if (!isMultiplayer) then {GVAR(changeMark) call FUNC(logicServerChangeMark)};
				publicVariableServer QGVAR(changeMark);
			};
		} forEach GVAR(allMarkers);
	};
	false
};
