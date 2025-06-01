#include "../script_component.hpp"

GVAR_ISNIL(direction)
GVAR_ISNIL(markToChangeDir)
GVAR_ISNIL(markToChangePos)
GVAR_ISNIL(lineParamsWorld)
GVAR_ISNIL(ellipse)
GVAR_ISNIL(position)
GVAR_ISNIL(changeMark) 

if (_one == 0) then {
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
    if !(isNil {GVAR(ellipse)}) then {
        deleteMarkerLocal "SWT_MARKERS LOCAL ELLIPSE";
        deleteMarkerLocal "SWT_MARKERS LOCAL INFO";
        if ((GVAR(ellipse) select 0) isNotEqualTo (GVAR(ellipse) select 1)) then
        {
            _coords = + GVAR(ellipse);
            ["ellipse",_coords] call FUNC(sendMark);
        };
        GVAR(ellipse) = nil;
    };
    if !(isNil {GVAR(markToChangePos)}) then {
        _mark = GVAR(markToChangePos);
        _coords = + GVAR(position);
        GVAR(changeMark) = ["POS", player, _mark, _mark call FUNC(getChannel), _coords];
        if (!isMultiplayer) then {GVAR(changeMark) call FUNC(logicServerChangeMark)};
        publicVariableServer QGVAR(changeMark);
        GVAR(markToChangePos) = nil;
        GVAR(position) = nil;
    };
};