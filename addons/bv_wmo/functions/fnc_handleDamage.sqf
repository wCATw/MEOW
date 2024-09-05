#include "../script_component.hpp"

params ["_unit", "_selectionName", "_damage", "_source", "_projectile", "_hitPartIndex", "_instigator"];

if (!local _unit) exitWith {};
if (isNull GVAR(anker) && GVAR(collision)) exitWith {};

if(_source isEqualTo player && _projectile isEqualTo "" && isNull _instigator)then{
	   player disableCollisionWith GVAR(anker);
	   0;
}else{
	_damage;
};
