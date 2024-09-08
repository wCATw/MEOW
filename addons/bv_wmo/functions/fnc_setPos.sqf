#include "../script_component.hpp"

if !(GVAR(enabled)) exitWith FUNC(exit);

if !(vehicle player isEqualTo player) exitWith FUNC(exit);

_posWorld = getPosWorld player;
_line = (lineIntersectsSurfaces [_posWorld vectorAdd [0,0,.6],_posWorld vectorAdd [0,0,-5],player,GVAR(help),true,-1,"GEOM","VIEW"])select {!isNull (_x select 3)};

if (_line isEqualTo []) exitWith {GVAR(anker) spawn FUNC(leave); GVAR(help) setPos [0,0,0];};


_upmost = _line#0;

_pos = _upmost select 0;
_no = _upmost select 1;
_obj = _upmost select 2;

if !([_obj]call FUNC(getsRoadway)) exitWith {
    call FUNC(exit);
    GVAR(help) setPos [0,0,0];
};

_helperpos = _pos;
if(!isNull GVAR(anker))then{
    _f = (_no vectorDotProduct (velocity GVAR(anker)));
    if(_f<0)then{_f=0;};
    _f = (_f*.1)+.1;
    _helperpos = _pos vectorAdd (_no vectorMultiply _f);
};


GVAR(help) setPosASL _helperpos;
GVAR(help) setVectorUp [0,0,1];

_obj = _obj call FUNC(getParent);


if (_obj isEqualTo GVAR(anker))then{
    _temp = (_posWorld vectorAdd (((GVAR(anker) modelToWorldVisualWorld prevOffset) vectorDiff  prevPlayerPos)));

    _vel = velocity player;
    _vel set [2,0];

    _searchCollPos1 = eyePos player;
    _searchCollPos2 = eyePos player;
    if !((animationState player) in ["aovrpercmstpsraswrfldf","aovrpercmstpsnonwnondf","aovrpercmstpslowwrfldf"]) then {
        _searchCollPos1 = _posWorld vectorAdd [0,0,0.6];
    };

    if(
        ({!isNull (_x select 2) && (_x select 0) distance _searchCollPos1 < 0.5 && (_x#1)#2 < .5} count (
            (lineIntersectsSurfaces [_searchCollPos1,_searchCollPos1 vectorAdd _vel,player,objNull,true,1,"GEOM"])+
            (lineIntersectsSurfaces [_searchCollPos1,_searchCollPos1 vectorAdd ([_vel,-30]call BIS_fnc_rotateVector2D),player,objNull,true,1,"GEOM"])+
            (lineIntersectsSurfaces [_searchCollPos1,_searchCollPos1 vectorAdd ([_vel,30]call BIS_fnc_rotateVector2D),player,objNull,true,1,"GEOM"])+
            (lineIntersectsSurfaces [_searchCollPos2,_searchCollPos2 vectorAdd _vel,player,objNull,true,1,"GEOM"])
            )
        >0)
    ) then {
        _xToCenter = (GVAR(anker) worldToModelVisual _posWorld)#0;
        _vec = GVAR(anker) vectorModelToWorld [-_xToCenter,0,0];
        _line1 = [GVAR(anker),"GEOM"]intersect[_searchCollPos1,_searchCollPos1 vectorAdd _vel] select {(_x#0) find "ladder_" > -1};
        _line2 = [GVAR(anker),"GEOM"]intersect[_searchCollPos1,_searchCollPos1 vectorAdd _vec] select {(_x#0) find "ladder_" > -1};
        if (_line2 isEqualTo [] && _line1 isEqualTo []) then {
            _temp = _temp vectorAdd (_vel vectorMultiply -0.02);
        };
    };


    _h = _helperpos#2;
    if((_temp select 2) - _h < .25) then {
        _temp set [2,_h-.1];
    }else{
        _temp set [2,(_temp select 2)-2.8/diag_fps]; // simulating a fall velocity
    };
    _dirDiff = prevDirAnker - getDir GVAR(anker);
    _dir = direction player - _dirDiff;
    if (vectorMagnitude(velocity GVAR(anker)) < 12) then {
        player setVelocityTransformation [_temp,_temp,[0,0,0],[0,0,- 0.4],vectorDir player,[sin _dir,cos _dir,0],[0,0,1],[0,0,1],1];
    } else {
        player setPosWorld _temp;
        player setDir _dir;
        player setVelocity [0,0,- 0.4];
    };

    prevOffset = GVAR(anker) worldToModelVisual (if(getTerrainHeightASL _posWorld>0) then { (getPosATL player) } else { (getPosASLW player) });
    prevPlayerPos = _temp;
    prevDirAnker = getDir GVAR(anker);
}else{  //new object beneath
    //systemChat "new";
    GVAR(exit) apply {GVAR(anker) call _x;};
    if ([_obj] call FUNC(isWmoObject)) then {
        GVAR(anker) = _obj;
        BW_WMO_enter apply {_obj call _x;};
        if (isMultiplayer && !(local _obj) && _obj isEqualTo GVAR(anker)) then {
            [player,_obj]remoteExecCall ["disableCollisionWith",_obj];
        };
        [GVAR(anker),false] call FUNC(collision);
        GVAR(collision) = false;
        prevOffset = GVAR(anker) worldToModelVisual (if(getTerrainHeightASL _posWorld>0) then { (getPosATL player) } else { (getPosASLW player) });
        prevPlayerPos = getPosWorld player;
        prevDirAnker = getDir GVAR(anker);
    } else FUNC(exit);
};
