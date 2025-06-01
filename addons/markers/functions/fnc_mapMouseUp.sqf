#include "../script_component.hpp"

params ["_one", "_dikCode"];

PARAM_INVALID(_dikCode,"SCALAR")

if (_dikCode == 0) then {
    if !(isNil {GVAR(markToChangeDir)}) then {
        _dir = + GVAR(direction);
        _mark = GVAR(markToChangeDir);
        GVAR(changeMark) = ["DIR", player, _mark, _mark call FUNC(getChannel), _dir];
        if (!isMultiplayer) then {GVAR(changeMark) call FUNC(logicServerChangeMark)};
        publicVariableServer QGVAR(changeMark);
        GVAR(markToChangeDir) = nil;
        GVAR(direction) = nil;
    };
    if !(isNil {GVAR(lineParamsWorld)}) then {
        deleteMarkerLocal "SWT_MARKERS LOCAL LINE";
        deleteMarkerLocal "SWT_MARKERS LOCAL INFO";

        if ((GVAR(lineParamsWorld) select 0) isNotEqualTo (GVAR(lineParamsWorld) select 1)) then
        {
            _coords = + GVAR(lineParamsWorld);
            ["line", _coords] call FUNC(sendMark);
        };
        GVAR(lineParamsWorld) = nil;
    };
    if !(isNil {GVAR(ellipseParamsWorld)}) then {
        deleteMarkerLocal "SWT_MARKERS LOCAL ELLIPSE";
        deleteMarkerLocal "SWT_MARKERS LOCAL INFO";
        if ((GVAR(ellipseParamsWorld) select 0) isNotEqualTo (GVAR(ellipseParamsWorld) select 1)) then
        {
            _coords = + GVAR(ellipseParamsWorld);
            ["ellipse",_coords] call FUNC(sendMark);
        };
        GVAR(ellipseParamsWorld) = nil;
    };
    if !(isNil {GVAR(markToChangePos)}) then {
        GVAR_ISNIL(position)
        _mark = GVAR(markToChangePos);
        _coords = + GVAR(position);
        GVAR(changeMark) = ["POS", player, _mark, _mark call FUNC(getChannel), _coords];
        if (!isMultiplayer) then {GVAR(changeMark) call FUNC(logicServerChangeMark)};
        publicVariableServer QGVAR(changeMark);
        GVAR(markToChangePos) = nil;
        GVAR(position) = nil;
    };
};