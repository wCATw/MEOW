#include "../script_component.hpp"
/*
    Function: fnc_mapMouseDown
        Description:
            Handles mouse down events on the map, supporting marker creation, selection, and editing based on modifier keys.
        Arguments:
            _ctrl       <CONTROL>   - The map control
            _dikCode    <SCALAR>    - The DIK key code
            _posClickX  <SCALAR>    - X position of the click
            _posClickY  <SCALAR>    - Y position of the click
            _shift      <BOOL>      - Shift key state
            _ctrlKey    <BOOL>      - Ctrl key state
            _alt        <BOOL>      - Alt key state
        Returns:
            none
        Variables:
            GVAR(allMarkers)        <ARRAY>     - All marker IDs
            GVAR(allMarkersParams)  <ARRAY>     - All marker parameters
            GVAR(markColor)         <STRING>    - Current marker color
            GVAR(limitSideMarkers)  <SCALAR>    - Side marker limit
*/

params ["_ctrl","_dikCode","_posClickX","_posClickY","_shift","_ctrlKey","_alt"];

PARAM_INVALID(_ctrl,"CONTROL")
PARAM_INVALID(_dikCode,"SCALAR")
PARAM_INVALID(_posClickX,"SCALAR")
PARAM_INVALID(_posClickY,"SCALAR")
PARAM_INVALID(_shift,"BOOL")
PARAM_INVALID(_ctrlKey,"BOOL")
PARAM_INVALID(_alt,"BOOL")
GVAR_ISNIL(allMarkers)
GVAR_ISNIL(allMarkersParams)
GVAR_ISNIL(markColor)
GVAR_ISNIL(limitSideMarkers)

private _display = ctrlParent _ctrl;
private _posClick = [_posClickX,_posClickY];

// Fast marker creation (Shift + LMB)
if (_shift && !_alt && !_ctrlKey && (_dikCode == 0)) exitWith {
    ["fast",[]] call FUNC(sendMark);
};

// Change marker direction (Alt + LMB)
if (!_shift && !_ctrlKey && _alt && (_dikCode == 0)) exitWith {
    {
        private _pos = getMarkerPos _x;
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
};

// Start drawing a line marker (Ctrl + Alt + LMB)
if (!_shift && _ctrlKey && _alt && (_dikCode == 0)) exitWith {
    GVAR(lineParamsWorld) = [(_display displayCtrl IDC_MAP) ctrlMapScreenToWorld _posClick,(_display displayCtrl IDC_MAP) ctrlMapScreenToWorld _posClick,0,5,0];
    createMarkerLocal ["SWT_MARKERS LOCAL LINE",(_display displayCtrl IDC_MAP) ctrlMapScreenToWorld _posClick];
    createMarkerLocal ["SWT_MARKERS LOCAL INFO",(_display displayCtrl IDC_MAP) ctrlMapScreenToWorld _posClick];
    "SWT_MARKERS LOCAL INFO" setMarkerShapeLocal "ICON";
    "SWT_MARKERS LOCAL INFO" setMarkerTypeLocal "hd_dot";
    "SWT_MARKERS LOCAL INFO" setMarkerSizeLocal [0,0];
    "SWT_MARKERS LOCAL INFO" setMarkerColorLocal GVAR(markColor);

    "SWT_MARKERS LOCAL LINE" setMarkerShapeLocal "RECTANGLE";
    "SWT_MARKERS LOCAL LINE" setMarkerBrushLocal "Solid";
    "SWT_MARKERS LOCAL LINE" setMarkerColorLocal GVAR(markColor);
    "SWT_MARKERS LOCAL LINE" setMarkerSizeLocal [GVAR(lineParamsWorld) select 3,0];
};

// Start drawing an ellipse marker (Shift + Alt + LMB)
if (_shift && !_ctrlKey && _alt && (_dikCode == 0)) exitWith {
    GVAR(ellipseParamsWorld) = [(_display displayCtrl IDC_MAP) ctrlMapScreenToWorld _posClick,(_display displayCtrl IDC_MAP) ctrlMapScreenToWorld _posClick];
    createMarkerLocal ["SWT_MARKERS LOCAL ELLIPSE",(_display displayCtrl IDC_MAP) ctrlMapScreenToWorld _posClick];
    createMarkerLocal ["SWT_MARKERS LOCAL INFO",(_display displayCtrl IDC_MAP) ctrlMapScreenToWorld _posClick];
    "SWT_MARKERS LOCAL INFO" setMarkerShapeLocal "ICON";
    "SWT_MARKERS LOCAL INFO" setMarkerTypeLocal "hd_dot";
    "SWT_MARKERS LOCAL INFO" setMarkerSizeLocal [0,0];
    "SWT_MARKERS LOCAL INFO" setMarkerColorLocal GVAR(markColor);

    "SWT_MARKERS LOCAL ELLIPSE" setMarkerShapeLocal "ELLIPSE";
    "SWT_MARKERS LOCAL ELLIPSE" setMarkerBrushLocal "Solid";
    "SWT_MARKERS LOCAL ELLIPSE" setMarkerColorLocal GVAR(markColor);
    "SWT_MARKERS LOCAL ELLIPSE" setMarkerSizeLocal [0,0];
};

// Road marker creation (Shift + Ctrl + LMB)
if (_shift && _ctrlKey && !_alt && (_dikCode == 0)) exitWith {
    private _pos = (_display displayCtrl IDC_MAP) ctrlMapScreenToWorld _posClick;
    private _roads = _pos nearRoads 50;
    private _min = _roads select 0;
    if (isNil {_min}) exitWith {hint "SWT MARKERS: ROAD NOT FOUND"};
    {
        if (_x distance _pos < _min distance _pos) then {_min = _x};
    } forEach _roads;
    ["road",getPosATL _min] call FUNC(sendMark);
};

// Marker selection for editing (plain LMB)
if (_dikCode == 0) exitWith {
    private _mapPosClick = _ctrl ctrlMapScreenToWorld _posClick;
    // Sort markers by distance to click
    private _markers = [GVAR(allMarkers),[_mapPosClick],{[_posClick,getMarkerPos _x] call BIS_fnc_distance2D},"ASCEND"] call BIS_fnc_sortBy;
    {
        private _id = GVAR(allMarkers) find _x;
        private _param = GVAR(allMarkersParams) # _id;
        private _pos = _ctrl ctrlMapWorldToScreen (getMarkerPos _x);
        if (([_pos,_posClick] call BIS_fnc_distance2D) < 0.05) exitWith {
            if (name player == (_param # 8)) then {
                // Only allow editing if player is marker owner and side/channel rules allow
                if (_param #1 isNotEqualTo "S" || (0 call FUNC(checkSideChannel))) then {
                    GVAR(markToChangePos) = _x;
                    GVAR(position) = getMarkerPos _x;
                } else {
                    ["ace_common_displayTextStructured",
                        [localize (format ["%1_%2",LSTRING(SET_LIMIT_SIDE_MARKERS_MSG),str GVAR(limitSideMarkers)]),2]
                    ] call CBA_fnc_localEvent;
                };
            } else {
                hintSilent (localize LSTRING(CANTCHANGE));
            };
        };
    } forEach _markers;
};