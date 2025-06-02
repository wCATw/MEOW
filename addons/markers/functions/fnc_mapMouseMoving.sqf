#include "../script_component.hpp"
/*
	Function: fnc_mapMouseMoving

		Description:
			Handles mouse movement events on the map. Updates marker direction, line, ellipse, or position previews in real time as the mouse moves.

		Arguments:
			_control         <Control>  - The map control receiving the mouse move event.
			_displayCoordX   <Scalar>   - X coordinate of the mouse on the display.
			_displayCoordY   <Scalar>   - Y coordinate of the mouse on the display.

		Returns:
			none

		Variables:
			_control, _displayCoordX, _displayCoordY, _display, _pos, and various marker-related globals.
*/

params ["_control", "_displayCoordX", "_displayCoordY"];

PARAM_INVALID(_control,"CONTROL")
PARAM_INVALID(_displayCoordX,"SCALAR")
PARAM_INVALID(_displayCoordY,"SCALAR")
GVAR_ISNIL(markInfo)

private _display = ctrlParent _control;
private _pos = [_displayCoordX, _displayCoordY];
GVAR(displayCoord) = _pos;
GVAR(posM) = _pos;

// If changing marker direction, update preview direction
if !(isNil {GVAR(markToChangeDir)}) then {
	disableSerialization;
	_ctrl = _control;
	_pos_click = GVAR(posM);
	_pos = getMarkerPos GVAR(markToChangeDir);
	_pos = (_ctrl) ctrlMapWorldToScreen _pos;
	GVAR(direction) = [_pos,_pos_click] call BIS_fnc_dirTo;
	GVAR(direction) = - GVAR(direction) + 180;
	if ((markerShape GVAR(markToChangeDir) == "ELLIPSE") and ((markerSize GVAR(markToChangeDir)) select 0 > (markerSize GVAR(markToChangeDir)) select 1)) then {
		GVAR(direction) = GVAR(direction) + 90
	};
	GVAR(markToChangeDir) setMarkerDirLocal GVAR(direction);
// If changing line, update preview line and info
} else {
	if !(isNil {GVAR(lineParamsWorld)}) then {
		GVAR(lineParamsWorld) set [1,_control ctrlMapScreenToWorld GVAR(posM)];
		_direction = [GVAR(lineParamsWorld) select 0,GVAR(lineParamsWorld) select 1] call BIS_fnc_dirTo;
		// Update line and info marker positions
		"SWT_MARKERS LOCAL LINE" setMarkerPosLocal [
			(((GVAR(lineParamsWorld) select 0) select 0) + ((GVAR(lineParamsWorld) select 1) select 0))/2,
			(((GVAR(lineParamsWorld) select 0) select 1) + ((GVAR(lineParamsWorld) select 1) select 1))/2
		];
		"SWT_MARKERS LOCAL INFO" setMarkerPosLocal [
			(((GVAR(lineParamsWorld) select 0) select 0) + ((GVAR(lineParamsWorld) select 1) select 0))/2,
			(((GVAR(lineParamsWorld) select 0) select 1) + ((GVAR(lineParamsWorld) select 1) select 1))/2
		];
		GVAR(lineParamsWorld) set [2,_direction];
		GVAR(lineParamsWorld) set [4, ((GVAR(lineParamsWorld) select 0) distance (GVAR(lineParamsWorld) select 1))/2];
		"SWT_MARKERS LOCAL LINE" setMarkerSizeLocal [
			GVAR(lineParamsWorld) select 3,
			(((GVAR(lineParamsWorld) select 0) distance (GVAR(lineParamsWorld) select 1)))/2
		];
		"SWT_MARKERS LOCAL LINE" setMarkerDirLocal (_direction);
// If changing ellipse, update preview ellipse and info
	} else {
		if !(isNil {GVAR(ellipseParamsWorld)}) then {
			_pos = _control ctrlMapScreenToWorld GVAR(posM);
			if (
				abs((_pos select 0) - ((GVAR(ellipseParamsWorld) select 0) select 0)) < IDC_CONTROLS_GROUP_INFO_BUTTON_1 and
				abs((_pos select 1) - ((GVAR(ellipseParamsWorld) select 0) select 1)) < IDC_CONTROLS_GROUP_INFO_BUTTON_1
			) then {
				GVAR(ellipseParamsWorld) set [1, _pos];
				_size = [
					abs(((GVAR(ellipseParamsWorld) select 1) select 0) - ((GVAR(ellipseParamsWorld) select 0) select 0)),
					abs(((GVAR(ellipseParamsWorld) select 1) select 1) - ((GVAR(ellipseParamsWorld) select 0) select 1))
				];
				"SWT_MARKERS LOCAL ELLIPSE" setMarkerSizeLocal _size;
				"SWT_MARKERS LOCAL INFO" setMarkerTextLocal (format ["w: %1, h: %2", _size select 0, _size select 1]);
			};
// If changing marker position, update preview position
		} else {
			if !(isNil {GVAR(markToChangePos)}) then {
				GVAR(position) = (_display displayCtrl IDC_MAP) ctrlMapScreenToWorld GVAR(posM);
				GVAR(markToChangePos) setMarkerPosLocal GVAR(position);
			};
			// Show marker info if enabled
			if (GVAR(markInfo)) then {call FUNC(showInfo)};
		};
	};
};