#include "../script_component.hpp"
/*
    Function: fnc_mapMouseUp

        Description:
            Handles mouse button release events on the map. Finalizes marker direction, line, ellipse, or position changes and sends updates to the server if needed.

        Arguments:
            _one      <Any>     - Unused/unknown, passed for compatibility.
            _dikCode  <Scalar>  - The DirectInput key code of the released mouse button.

        Returns:
            none

        Variables:
            _dikCode           <Scalar>  - Mouse button code.
            _dir, _mark, _coords - Various local variables for marker data.
*/

params ["_one", "_dikCode"];

PARAM_INVALID(_dikCode,"SCALAR")

if (_dikCode == 0) then {
    // Finalize marker direction change if in progress
    if !(isNil {GVAR(markToChangeDir)}) then {
        _dir = + GVAR(direction);
        _mark = GVAR(markToChangeDir);
        GVAR(changeMark) = ["DIR",player,_mark,_mark call FUNC(getChannel),_dir];
        if (!isMultiplayer) then {GVAR(changeMark) call FUNC(logicServerChangeMark)};
        publicVariableServer QGVAR(changeMark);
        GVAR(markToChangeDir) = nil;
        GVAR(direction) = nil;
    };
    // Finalize line marker if in progress
    if !(isNil {GVAR(lineParamsWorld)}) then {
        deleteMarkerLocal "SWT_MARKERS LOCAL LINE";
        deleteMarkerLocal "SWT_MARKERS LOCAL INFO";
        if ((GVAR(lineParamsWorld) select 0) isNotEqualTo (GVAR(lineParamsWorld) select 1)) then {
            _coords = + GVAR(lineParamsWorld);
            ["line",_coords] call FUNC(sendMark);
        };
        GVAR(lineParamsWorld) = nil;
    };
    // Finalize ellipse marker if in progress
    if !(isNil {GVAR(ellipseParamsWorld)}) then {
        deleteMarkerLocal "SWT_MARKERS LOCAL ELLIPSE";
        deleteMarkerLocal "SWT_MARKERS LOCAL INFO";
        if ((GVAR(ellipseParamsWorld) select 0) isNotEqualTo (GVAR(ellipseParamsWorld) select 1)) then {
            _coords = + GVAR(ellipseParamsWorld);
            ["ellipse",_coords] call FUNC(sendMark);
        };
        GVAR(ellipseParamsWorld) = nil;
    };
    // Finalize marker position change if in progress
    if !(isNil {GVAR(markToChangePos)}) then {
        GVAR_ISNIL(position)
        _mark = GVAR(markToChangePos);
        _coords = + GVAR(position);
        GVAR(changeMark) = ["POS",player,_mark,_mark call FUNC(getChannel),_coords];
        if (!isMultiplayer) then {GVAR(changeMark) call FUNC(logicServerChangeMark)};
        publicVariableServer QGVAR(changeMark);
        GVAR(markToChangePos) = nil;
        GVAR(position) = nil;
    };
};
