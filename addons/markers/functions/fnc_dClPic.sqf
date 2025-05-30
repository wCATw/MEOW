#include "../script_component.hpp"

params ["_display", "_two", "_posClickX", "_posClickY"];

TRACE_4("called dClPic with params:",_display,_two,_posClickX,_posClickY);

if ((diag_tickTime-GVAR(time)) < 0.3) then {
	GVAR(time) = diag_tickTime;
	private _pos_click = [_posClickX, _posClickY];
	_pos_to_chek = ctrlPosition (_display displayCtrl IDC_PICTURE);
	_pos_to_chek = [(_pos_to_chek select 0) + (_pos_to_chek select 2)/2,(_pos_to_chek select 1) + (_pos_to_chek select 3)/2];
	if (([_pos_to_chek,_pos_click] call BIS_fnc_distance2D) < ((ctrlPosition (_display displayCtrl IDC_PICTURE)) select 3)/2) then {
		if (isNil {GVAR(dClBut)}) then {
			(_display displayCtrl IDC_LB_COLOR) ctrlShow true;
			(_display displayCtrl IDC_LB_PIC) ctrlShow true;
			GVAR(dClBut) = true;
		} else {
			(_display displayCtrl IDC_LB_COLOR) ctrlShow false;
			(_display displayCtrl IDC_LB_PIC) ctrlShow false;
			GVAR(dClBut) = nil;
		};
	};
} else {GVAR(time) = diag_tickTime};