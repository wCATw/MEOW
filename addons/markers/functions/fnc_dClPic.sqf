#include "../script_component.hpp"
	/*
		Function: fnc_dClPic

			Description:
				Handles double-click events on the marker picture control. Toggles the visibility of color and icon listboxes if the click is within the icon area and within a short time interval.

			Arguments:
				_display     <Display>  - The display containing the picture control.
				_two         <Any>      - Unused/unknown, passed for compatibility.
				_posClickX   <Scalar>   - X coordinate of the click.
				_posClickY   <Scalar>   - Y coordinate of the click.
				Global:
					time   <Scalar>   - Used to check double-click interval (read/set)
					dClBut <Any>      - Used to track double-click state (read/set)

			Returns:
				none
				Global:
					time   <Scalar>   - Updated with last click time (set)
					dClBut <Any>      - Updated with double-click state (set)

			Variables:
				_display, _two, _posClickX, _posClickY, _pos_click, _pos_to_chek
	*/

params ["_display", "_two", "_posClickX", "_posClickY"];

PARAM_INVALID(_display,"DISPLAY")
PARAM_INVALID(_posClickX,"SCALAR")
PARAM_INVALID(_posClickY,"SCALAR")
GVAR_ISNIL(time)

// Only proceed if double-click is within time limit
if ((diag_tickTime-GVAR(time)) < 0.3) then {
	GVAR(time) = diag_tickTime;
	private _pos_click = [_posClickX, _posClickY];
	// Calculate center of icon area
	_pos_to_chek = ctrlPosition (_display displayCtrl IDC_PICTURE);
	_pos_to_chek = [(_pos_to_chek select 0) + (_pos_to_chek select 2)/2,(_pos_to_chek select 1) + (_pos_to_chek select 3)/2];
	// If click is within icon area radius
	if (([_pos_to_chek,_pos_click] call BIS_fnc_distance2D) < ((ctrlPosition (_display displayCtrl IDC_PICTURE)) select 3)/2) then {
		// Toggle color and icon listboxes visibility
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
} else {
	GVAR(time) = diag_tickTime;
};