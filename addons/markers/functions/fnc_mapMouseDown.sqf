#include "../script_component.hpp"

params ["_ctrl", "_dikCode", "_posClickX", "_posClickY", "_shift", "_ctrlKey", "_alt"];

PARAM_INVALID(_ctrl,"CONTROL")
PARAM_INVALID(_dikCode,"NUMBER")
PARAM_INVALID(_posClickX,"NUMBER")
PARAM_INVALID(_posClickY,"NUMBER")
PARAM_INVALID(_shift,"BOOL")
PARAM_INVALID(_ctrlKey,"BOOL")
PARAM_INVALID(_alt,"BOOL")
GVAR_ISNIL(allMarkers)
GVAR_ISNIL(allMarkersParams)
GVAR_ISNIL(markColor)
GVAR_ISNIL(markToChangePos)
GVAR_ISNIL(markToChangeDir)
GVAR_ISNIL(direction)
GVAR_ISNIL(eclipse)
GVAR_ISNIL(lineParamsWorld)
GVAR_ISNIL(limitSideMarkers)

private _display = ctrlParent _ctrl;
private _posClick = [_posClickX,_posClickY];

if (_shift and !_alt and !_ctrlKey and ((_this select 1) == 0)) then 
{
	["fast",[]] call FUNC(sendMark);
} else {
	if (!_shift and !_ctrlKey and _alt and ((_this select 1) == 0)) then 
	{
		{
			_pos = getMarkerPos _x;
			_pos = _ctrl ctrlMapWorldToScreen _pos;
			if (([_pos,_posClick] call BIS_fnc_distance2D) < 0.025) exitWith {
				if (name player == ((GVAR(allMarkersParams) select _forEachIndex) select 8)) then {
					GVAR(markToChangeDir) = _x;
					GVAR(direction) = markerDir _x;
				} else {
					hintSilent (localize LSTRING(CANTCHANGE));
				};
			};
		} forEach GVAR(allMarkers);
	} else {
		if (!_shift and _ctrlKey and _alt and ((_this select 1) == 0)) then {
			GVAR(lineParamsWorld) = [(_display displayCtrl 51) ctrlMapScreenToWorld _posClick,(_display displayCtrl 51) ctrlMapScreenToWorld _posClick,0,5,0];
			createMarkerLocal ["SWT_MARKERS LOCAL LINE", (_display displayCtrl 51) ctrlMapScreenToWorld _posClick];
			createMarkerLocal ["SWT_MARKERS LOCAL INFO", (_display displayCtrl 51) ctrlMapScreenToWorld _posClick];
			"SWT_MARKERS LOCAL INFO" setMarkerShapeLocal "ICON";
			"SWT_MARKERS LOCAL INFO" setMarkerTypeLocal "hd_dot";
			"SWT_MARKERS LOCAL INFO" setMarkerSizeLocal [0,0];
			"SWT_MARKERS LOCAL INFO" setMarkerColorLocal GVAR(markColor);

			"SWT_MARKERS LOCAL LINE" setMarkerShapeLocal "RECTANGLE";
			"SWT_MARKERS LOCAL LINE" setMarkerBrushLocal "Solid";
			"SWT_MARKERS LOCAL LINE" setMarkerColorLocal GVAR(markColor);
			"SWT_MARKERS LOCAL LINE" setMarkerSizeLocal [GVAR(lineParamsWorld) select 3,0];
		} else {
			if (_shift and !_ctrlKey and _alt and ((_this select 1) == 0)) then {
				GVAR(eclipse) = [(_display displayCtrl 51) ctrlMapScreenToWorld _posClick,(_display displayCtrl 51) ctrlMapScreenToWorld _pos_c_posClicklick];
				createMarkerLocal ["SWT_MARKERS LOCAL ELLIPSE", (_display displayCtrl 51) ctrlMapScreenToWorld _posClick];
				createMarkerLocal ["SWT_MARKERS LOCAL INFO", (_display displayCtrl 51) ctrlMapScreenToWorld _posClick];
				"SWT_MARKERS LOCAL INFO" setMarkerShapeLocal "ICON";
				"SWT_MARKERS LOCAL INFO" setMarkerTypeLocal "hd_dot";
				"SWT_MARKERS LOCAL INFO" setMarkerSizeLocal [0,0];
				"SWT_MARKERS LOCAL INFO" setMarkerColorLocal GVAR(markColor);

				"SWT_MARKERS LOCAL ELLIPSE" setMarkerShapeLocal "ELLIPSE";
				"SWT_MARKERS LOCAL ELLIPSE" setMarkerBrushLocal "Solid";
				"SWT_MARKERS LOCAL ELLIPSE" setMarkerColorLocal GVAR(markColor);
				"SWT_MARKERS LOCAL ELLIPSE" setMarkerSizeLocal [0,0];
			} else {
				if (_shift and _ctrlKey and !_alt and ((_this select 1) == 0)) then {
					_pos = (_display displayCtrl 51) ctrlMapScreenToWorld _posClick;
					_roads = _pos nearRoads 50;
					_min = _roads select 0;
					if (isNil {_min}) exitWith {hint "SWT MARKERS: ROAD NOT FOUND"};
					{
						if (_x distance _pos < _min distance _pos) then {_min = _x};
					} forEach _roads;
					["road", getPosATL _min] call FUNC(sendMark);
				} else {
					if ((_this select 1) == 0) then {
						_map_pos_click = _ctrl ctrlMapScreenToWorld _posClick;
						private _markers = [GVAR(allMarkers), [_map_pos_click], {[_input0, getMarkerPos _x] call BIS_fnc_distance2D}, "ASCEND"] call BIS_fnc_sortBy;  // MEOW
						{
							private _id =  GVAR(allMarkers) find _x;
							private _param = GVAR(allMarkersParams) # _id;
							
							private _pos = _ctrl ctrlMapWorldToScreen (getMarkerPos _x);
							if (([_pos,_pos_click] call BIS_fnc_distance2D) < 0.05) exitWith {  // MEOW
									if (name player == (_param # 8)) then {
										if (_param #1 isNotEqualTo "S" || (0 call FUNC(checkSideChannel))) then {
											GVAR(markToChangePos) = _x;
											GVAR(position) = getMarkerPos _x;
										} else {
											["ace_common_displayTextStructured",
												[localize (format ["%1_%2", LSTRING(SET_LIMIT_SIDE_MARKERS_MSG), str GVAR(limitSideMarkers)]), 2]
											] call CBA_fnc_localEvent;
										};
									} else {
										hintSilent (localize LSTRING(CANTCHANGE));
									};
							};
						} forEach _markers;
					};
				};
			};
		};
	};
};