#include "../script_component.hpp"

private ["_pos", "_c_x", "_c_y", "_new_h", "_new_w", "_new_x", "_new_y"];

_pos = ctrlPosition (_display displayCtrl IDC_PICTURE);

_c_x = (_pos select 0) + ((_pos select 2)/2);
_c_y = (_pos select 1) + ((_pos select 3)/2);
_new_h = (0.0666667*GVAR(sweetkS)) ;
_new_w = (0.05*GVAR(sweetkS)) ;
_new_x = _c_x -(_new_w/2) ;
_new_y = _c_y -(_new_h/2) ;

(_display displayCtrl IDC_PICTURE) ctrlSetPosition [
	_new_x,
	_new_y,
	_new_w,
	_new_h
];
(_display displayCtrl IDC_PICTURE) ctrlCommit 0;