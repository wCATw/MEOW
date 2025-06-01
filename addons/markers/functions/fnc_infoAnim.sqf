#include "../script_component.hpp"
/*
	Function: fnc_infoAnim

		Description:
			Animates the info panel in the marker dialog, showing or hiding advanced information and updating UI controls accordingly.

		Arguments:
			_control   <Control>  - The control that triggered the info animation.

		Returns:
			none

		Variables:
			_display, _text, _picture, _buttonOK, _buttonCancel, _buttonInfo, _description, _title, _info, _pos, _combo_color, _combo_icon, _swt_info_group, and local animation variables.
*/



params ["_control"];

PARAM_INVALID(_control,"CONTROL")
GVAR_ISNIL(RscDisplayInsertMarkerInfo)

private ['_display','_text','_picture','_buttonOK','_buttonCancel',"_buttonInfo","_description","_title","_info",'_control','_pos',"_combo_color","_combo_icon","_swt_info_group"];

// Get the parent display and relevant controls
_display = ctrlParent _control;
ctrlSetFocus (_display displayCtrl IDC_TEXT);
_text = _display displayCtrl IDC_TEXT;
_picture = _display displayCtrl IDC_PICTURE;
_buttonOK = _display displayCtrl 1;
_buttonCancel = _display displayCtrl 2;
_buttonInfo = _display displayCtrl IDC_MENU_INFO;
_description = _display displayCtrl IDC_BACKGROUND_DESCRIPTION;
_title = _display displayCtrl 1001;
_info = _display displayCtrl IDC_CONTROLS_GROUP_INFO;
_combo_color = [IDC_COMBO_00,IDC_COMBO_01,IDC_COMBO_02,IDC_COMBO_03,IDC_COMBO_04,IDC_COMBO_05];
_combo_icon = [IDC_COMBO_06,IDC_COMBO_07,IDC_COMBO_08,IDC_COMBO_09,IDC_COMBO_10,IDC_COMBO_11];
_swt_info_group = _display displayCtrl IDC_CONTROLS_GROUP;

_posText = ctrlPosition _text;
_posTextY = _posText select 1;
_posTextW = _posText select 2;
_posTextH = _posText select 3;

private _animate = {
	params ["_control", "_dY", "_dH", "_borderCoef", "_four"];

	private _pos = ctrlPosition _control;
	_pos set [1,_posTextY + _dY * _posTextH + _borderCoef * 0.005];
	if (_four) then {_pos set [3,_dH * _posTextH]};
	_control ctrlSetPosition _pos;
	_control ctrlCommit _delay;
};

_delay = 0.2;

// If info is not shown, animates controls to show the info panel and updates button text.
if (isNil {GVAR(RscDisplayInsertMarkerInfo)}) then {

	// Animate color and icon combo controls, and advanced controls to slide in
	{
		_pos = ctrlPosition (_display displayCtrl _x);
		(_display displayCtrl _x) ctrlSetPosition [(_pos select 0)+1.1*((ctrlPosition (_display displayCtrl IDC_TEXT)) select 2),_pos select 1,_pos select 2,_pos select 3];
		(_display displayCtrl _x) ctrlCommit 0.2;
	} forEach (_combo_color+_combo_icon+[IDC_BUTTON_ADV,IDC_CONTROLS_GROUP_ADV]);

	// Update button text to "Hide Info"
	_buttonInfo ctrlSetText (localize LSTRING(HIDEINFO));
	GVAR(RscDisplayInsertMarkerInfo) = true;

	// Animate info group and OK/Cancel buttons to new positions
	_swt_info_group ctrlShow true;
	[_swt_info_group,2,8,2,true] call _animate;
	[_buttonOK,10,1,3,false] call _animate;
	[_buttonCancel,10,1,3,false] call _animate;
} else {
	// If info is shown, animates controls to hide the info panel and updates button text.

	// Animate color and icon combo controls, and advanced controls to slide out
	{
		_pos = ctrlPosition (_display displayCtrl _x);
		(_display displayCtrl _x) ctrlSetPosition [(_pos select 0)-1.1*((ctrlPosition (_display displayCtrl IDC_TEXT)) select 2),_pos select 1,_pos select 2,_pos select 3];
		(_display displayCtrl _x) ctrlCommit 0.2;
	} forEach (_combo_color+_combo_icon+[IDC_BUTTON_ADV,IDC_CONTROLS_GROUP_ADV]);

	// Update button text to "Show Info"
	_buttonInfo ctrlSetText (localize 'STR_A3_RscDisplayInsertMarker_ButtonMenuInfo');
	GVAR(RscDisplayInsertMarkerInfo) = nil;

	// Animate info group and OK/Cancel buttons back to original positions
	[_swt_info_group,		2,0,2,true] call _animate;
	[_buttonOK,	2,1,2,false] call _animate;
	[_buttonCancel,	2,1,2,false] call _animate;
};