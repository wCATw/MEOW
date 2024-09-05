#include "../script_component.hpp"

_oldAnker = param [0, GVAR(anker), [objNull]];
if (isNull _oldAnker)exitWith{};

GVAR(anker) = objNull;
GVAR(exit) apply {_oldAnker call _x;};


_leaveOffset = _oldAnker worldToModel (getPosATL player);
_vel = (velocity player vectorAdd velocity _oldAnker);
_vel set [2,0];
player setVelocity _vel;


waitUntil {
	if(_oldAnker isEqualTo GVAR(anker) or (isNull _oldAnker))exitWith{true;};
	if((_oldAnker modelToWorld _leaveOffset)distance(getPosATL player) > 10 )exitWith{	// && (vectorMagnitude velocity player) isEqualTo 0
		GVAR(collision) = true;
		[_oldAnker,true] call FUNC(collision);
		if (isMultiplayer && !(local _oldAnker) && !isNull _oldAnker)then{
        	[player,_oldAnker]remoteExecCall ["enableCollisionWith",_oldAnker];
    	};
    	true;
	};
	false;
};
