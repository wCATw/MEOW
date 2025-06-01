#include "../script_component.hpp"

params ["_control", "_displayCoordX", "_displayCoordY"];

PARAM_INVALID(_control,"CONTROL")
PARAM_INVALID(_displayCoordX,"NUMBER")
PARAM_INVALID(_displayCoordY,"NUMBER")
GVAR_ISNIL(displayCoord)
GVAR_ISNIL(posM)
GVAR_ISNIL(direction)
GVAR_ISNIL(markToChangeDir)
GVAR_ISNIL(markToChangePos)
GVAR_ISNIL(lineParamsWorld)
GVAR_ISNIL(ellipse)
GVAR_ISNIL(markInfo)
GVAR_ISNIL(position)

_display = ctrlParent _control;
GVAR(displayCoord) = [_displayCoordX, _displayCoordY];
GVAR(posM) = [_displayCoordX, _displayCoordY];
if !(isNil {GVAR(markToChangeDir)}) then {
	disableSerialization;
	_ctrl = _control;
	_pos_click = GVAR(posM);
	_pos = getMarkerPos GVAR(markToChangeDir);
	_pos = (_ctrl) ctrlMapWorldToScreen _pos;
	GVAR(direction) =  [_pos,_pos_click] call BIS_fnc_dirTo;
	GVAR(direction) = - GVAR(direction) + 180;
	if ((markerShape GVAR(markToChangeDir) == "ELLIPSE")and((markerSize GVAR(markToChangeDir)) select 0 > (markerSize GVAR(markToChangeDir)) select 1)) then {GVAR(direction) = GVAR(direction) + 90};
	GVAR(markToChangeDir) setMarkerDirLocal GVAR(direction);
} else {
	if !(isNil {GVAR(lineParamsWorld)}) then {
		GVAR(lineParamsWorld) set [1,_control ctrlMapScreenToWorld GVAR(posM)];
		_direction = [GVAR(lineParamsWorld) select 0,GVAR(lineParamsWorld) select 1] call BIS_fnc_dirTo;
		"SWT_MARKERS LOCAL LINE" setMarkerPosLocal [(((GVAR(lineParamsWorld) select 0) select 0) + ((GVAR(lineParamsWorld) select 1) select 0))/2,(((GVAR(lineParamsWorld) select 0) select 1) + ((GVAR(lineParamsWorld) select 1) select 1))/2];
		"SWT_MARKERS LOCAL INFO" setMarkerPosLocal [(((GVAR(lineParamsWorld) select 0) select 0) + ((GVAR(lineParamsWorld) select 1) select 0))/2,(((GVAR(lineParamsWorld) select 0) select 1) + ((GVAR(lineParamsWorld) select 1) select 1))/2];
		GVAR(lineParamsWorld) set [2,_direction];
		GVAR(lineParamsWorld) set [4, ((GVAR(lineParamsWorld) select 0) distance (GVAR(lineParamsWorld) select 1))/2];
		"SWT_MARKERS LOCAL LINE" setMarkerSizeLocal [GVAR(lineParamsWorld) select 3,(((GVAR(lineParamsWorld) select 0) distance (GVAR(lineParamsWorld) select 1)))/2];
		"SWT_MARKERS LOCAL LINE" setMarkerDirLocal (_direction);
	} else {
		if !(isNil {GVAR(ellipse)}) then {
			_pos = _control ctrlMapScreenToWorld GVAR(posM);
			if (abs((_pos select 0) - ((GVAR(ellipse) select 0) select 0)) < IDC_CONTROLS_GROUP_INFO_BUTTON_1 and abs((_pos select 1) - ((GVAR(ellipse) select 0) select 1)) < IDC_CONTROLS_GROUP_INFO_BUTTON_1) then {
				GVAR(ellipse) set [1, _pos];
				_size = [abs(((GVAR(ellipse) select 1) select 0) - ((GVAR(ellipse) select 0) select 0)),abs(((GVAR(ellipse) select 1) select 1) - ((GVAR(ellipse) select 0) select 1))];
				"SWT_MARKERS LOCAL ELLIPSE" setMarkerSizeLocal _size;
				"SWT_MARKERS LOCAL INFO" setMarkerTextLocal (format ["w: %1, h: %2", _size select 0, _size select 1]);
			};

		} else {
			if !(isNil {GVAR(markToChangePos)}) then {
				GVAR(position) = (_display displayCtrl 51) ctrlMapScreenToWorld GVAR(posM);
				GVAR(markToChangePos) setMarkerPosLocal GVAR(position);
			};
			if (GVAR(markInfo)) then {call FUNC(showInfo)};
		};
	};
};