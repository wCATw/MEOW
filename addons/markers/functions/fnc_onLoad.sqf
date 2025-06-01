#include "../script_component.hpp"
/*
	Function: fnc_onLoad

		Description:
			Initializes and arranges all controls and UI elements for the marker dialog when it is loaded. Sets up positions, colors, icons, and fast text options.

		Arguments:
			_display   <Display>  - The display being initialized.

		Returns:
			none

		Variables:
			_display, _text, _picture, _buttonOK, _buttonCancel, _buttonInfo, _description, _channButt, _info, _swt_info_group, _combo_color, _combo_icon, _controls_color, _controls_icon, _controls_icon_pic, _all, and many local UI variables.
*/

#define SWT_W 0.025
#define SWT_H 0.02

params ["_display"];

PARAM_INVALID(_display,"DISPLAY")
GVAR_ISNIL(displayCoord)
GVAR_ISNIL(showInfo)
GVAR_ISNIL(saveText)
GVAR_ISNIL(saveMode)
GVAR_ISNIL(showButt)
GVAR_ISNIL(showBack)
GVAR_ISNIL(showColor)
GVAR_ISNIL(showIcon)
GVAR_ISNIL(showLb)
GVAR_ISNIL(text)
GVAR_ISNIL(pic)
GVAR_ISNIL(colorArr)
GVAR_ISNIL(channel)
GVAR_ISNIL(colorSlotParams)
GVAR_ISNIL(iconSlotParams)

private ["_text", "_picture", "_buttonOK", "_buttonCancel", "_buttonInfo", "_description", "_channButt", "_info", "_swt_info_group", "_combo_color", "_combo_icon", "_controls_color", "_control_icon", "_control_icon_pic", "_all"];

_text = _display displayCtrl IDC_TEXT;
_picture = _display displayCtrl IDC_PICTURE;
_buttonOK = _display displayCtrl 1;
_buttonCancel = _display displayCtrl 2;
_buttonInfo = _display displayCtrl IDC_MENU_INFO;
_description = _display displayCtrl IDC_BACKGROUND_DESCRIPTION;
_channButt = _display displayCtrl IDC_MENU_CANCEL;
_info = _display displayCtrl IDC_CONTROLS_GROUP_INFO;
_swt_info_group = _display displayCtrl IDC_CONTROLS_GROUP;
_combo_color = [IDC_COMBO_00,IDC_COMBO_01,IDC_COMBO_02,IDC_COMBO_03,IDC_COMBO_04,IDC_COMBO_05];
_combo_icon = [IDC_COMBO_06,IDC_COMBO_07,IDC_COMBO_08,IDC_COMBO_09,IDC_COMBO_10,IDC_COMBO_11];
_controls_color = [IDC_COLOR_00,IDC_COLOR_01,IDC_COLOR_02,IDC_COLOR_03,IDC_COLOR_04,IDC_COLOR_05];
_controls_icon = [IDC_ICON_00,IDC_ICON_01,IDC_ICON_02,IDC_ICON_03,IDC_ICON_04,IDC_ICON_05];
_controls_icon_pic = [IDC_ICON_10,IDC_ICON_11,IDC_ICON_12,IDC_ICON_13,IDC_ICON_14,IDC_ICON_15];
_all = [IDC_COMBO_00,IDC_COMBO_01,IDC_COMBO_02,IDC_COMBO_03,IDC_COMBO_04,IDC_COMBO_05,IDC_COMBO_06,IDC_COMBO_07,IDC_COMBO_08,IDC_COMBO_09,IDC_COMBO_10,IDC_COMBO_11,IDC_COLOR_00,IDC_COLOR_01,IDC_COLOR_02,IDC_COLOR_03,IDC_COLOR_04,IDC_COLOR_05,IDC_ICON_00,IDC_ICON_01,IDC_ICON_02,IDC_ICON_03,IDC_ICON_04,IDC_ICON_05,IDC_ICON_10,IDC_ICON_11,IDC_ICON_12,IDC_ICON_13,IDC_ICON_14,IDC_ICON_15,IDC_LB_COLOR,IDC_LB_PIC,IDC_SETTINGS_BUTTON,IDC_CONTROLS_GROUP,IDC_CONTROLS_GROUP_ADV,IDC_MENU_INFO,IDC_BUTTON_ADV,IDC_BACKGROUND_DESCRIPTION];
GVAR(shiftState) = false;
GVAR(ctrlState) = false;
GVAR(altState) = false;
ctrlSetFocus _text;

// Hide advanced/info groups and combo controls
{(_display displayCtrl _x) ctrlShow false} forEach [IDC_CONTROLS_GROUP_ADV, IDC_CONTROLS_GROUP];
{
	(_display displayCtrl _x) ctrlShow false; (_display displayCtrl _x) ctrlSetFade 1;
	(_display displayCtrl _x) ctrlCommit 0;
} forEach (_combo_color+_combo_icon+[IDC_BUTTON_ADV]);

// Arrange base controls: picture, text, description, channel button
_picture ctrlSetPosition [(GVAR(displayCoord) select 0) - ((ctrlPosition _picture) select 2)/2,(GVAR(displayCoord) select 1)-((ctrlPosition _picture) select 3)/2,(ctrlPosition _picture) select 2, (ctrlPosition _picture) select 3];
_picture ctrlCommit 0;
_text ctrlSetPosition [(GVAR(displayCoord) select 0) - ((ctrlPosition _picture) select 2)/2 + 0.07, (GVAR(displayCoord) select 1)-((ctrlPosition _text) select 3)/2, (ctrlPosition _text) select 2, (ctrlPosition _text) select 3];
(_text) ctrlCommit 0;

private ["_pos", "_posX", "_posY", "_posW", "_posH"];

_pos = ctrlPosition _text;
_posX = _pos select 0;
_posY = _pos select 1;
_posW = _pos select 2;
_posH = _pos select 3;
_pos set [1,_posY - 1*_posH];
_pos set [3,2*_posH];
_description ctrlSetPosition _pos;
_description ctrlCommit 0;
_channButt ctrlSetPosition [_pos select 0, _pos select 1, 0.7*_posW,_posH];
_channButt ctrlCommit 0;

// Setup info buttons
[_info,'info'] call FUNC(infoButtons);

// Arrange info group and info button
_pos set [1,_posY + 2 * _posH + 0.01];
_pos set [3,0];
_swt_info_group ctrlSetPosition [_pos select 0, _pos select 1, ((ctrlPosition _swt_info_group) select 2)+0.69 * (((safeZoneW / safeZoneH) min 1.2) / 40), 0];
_swt_info_group ctrlCommit 0;
_swt_info_group ctrlShow true;
_pos set [1,_posY + 1 * _posH + 0.005];
_pos set [3,0];
_show_coef = 2;
if (GVAR(showInfo)) then {_pos set [3,_posH];_show_coef = 2} else {_show_coef = 1};
_buttonInfo ctrlSetPosition _pos;
_buttonInfo ctrlCommit 0;
_buttonInfo ctrlShow true;
_pos set [1,_posY + _show_coef * _posH + 2 * 0.005];
_pos set [2,_posW / 2 - 0.005];
_buttonOk ctrlSetPosition _pos;
_buttonOk ctrlCommit 0;
_pos set [0,_posX + _posW / 2];
_pos set [2,_posW / 2];
_buttonCancel ctrlSetPosition _pos;
_buttonCancel ctrlCommit 0;

// Scale dialog
call FUNC(scale);

// Restore saved text if needed
if (GVAR(saveText)) then {_text ctrlSetText GVAR(text)};
if !(GVAR(showButt)) then {
	// Hide OK/Cancel if not needed
	{
		(_display displayCtrl _x) ctrlSetPosition [(ctrlPosition (_display displayCtrl _x)) select 0,(ctrlPosition (_display displayCtrl _x)) select 1,(ctrlPosition (_display displayCtrl _x)) select 2,0];
		(_display displayCtrl _x) ctrlCommit 0;
	} forEach [1,2];
};
if !(GVAR(showBack)) then {
	// Hide background if not needed
	_description ctrlSetBackgroundColor [0,0,0,0];
};

// Set channel
[_display,GVAR(channel)] call FUNC(setChannel);

// Set marker icon and color
_picture ctrlSetText GVAR(pic);
_picture ctrlSetTextColor GVAR(colorArr);

_pos_control_base = ctrlPosition (_description);

_w_color = (ctrlPosition (_display displayCtrl IDC_COLOR_00)) select 2;
_h_color = (ctrlPosition (_display displayCtrl IDC_COLOR_00)) select 3;

_w_icon = (ctrlPosition (_display displayCtrl IDC_ICON_00)) select 2;
_h_icon = (ctrlPosition (_display displayCtrl IDC_ICON_00)) select 3;

_coef_h_color = (_h_color/_w_color);
_coef_h_icon = (_h_icon/_w_icon);

// Arrange color controls, set color and visibility
{
	_control = _display displayCtrl _x;
	_pos = ctrlPosition _control;
	_control ctrlSetPosition [((_pos_control_base select 0) + (((_pos_control_base select 2)/6) * _forEachIndex)), (_pos_control_base select 1) - (_pos select 3), _pos select 2, _pos select 3];
	_control ctrlCommit 0;
	_markColor = getArray (configFile >> "CfgMarkerColors" >> (GVAR(colorSlotParams) select _forEachIndex) >> "color");

	// Convert string color values to numbers if needed
	{
		if (typeName _x != "SCALAR") then {
			_markColor set [_forEachIndex, call compile _x];
		};
	} forEach _markColor;
	_control ctrlSetTextColor [_markColor select 0, _markColor select 1, _markColor select 2, 0.6];
	_control ctrlSetActiveColor _markColor;
	if !(GVAR(showColor)) then {_control ctrlShow false};
} forEach _controls_color;

// Arrange icon picture controls, set icon and color, hide if needed
{
	_control = _display displayCtrl _x;
	_control ctrlSetPosition [((_pos_control_base select 0) + (((_pos_control_base select 2)/6) * _forEachIndex)), (_pos_control_base select 1) - (_pos select 3) - 0.2*(_pos_control_base select 3) - (_coef_h_icon * ((_pos_control_base select 2)/6)), ((_pos_control_base select 2)/6), (_coef_h_icon * ((_pos_control_base select 2)/6))];
	if (!isNil {GVAR(colorArr)}) then {_control ctrlSetTextColor GVAR(colorArr)};
	_control ctrlCommit 0;
	_pic = getText (configFile >> "cfgMarkers" >> (GVAR(iconSlotParams) select _forEachIndex) >> "icon");
	_control ctrlSetText _pic;
	if !(GVAR(showIcon)) then {_control ctrlShow false};
} forEach _controls_icon_pic;

// Arrange icon controls, set icon, hide if needed
{
	_control = _display displayCtrl _x;
	_control ctrlSetPosition [((_pos_control_base select 0) + (((_pos_control_base select 2)/6) * _forEachIndex)), (_pos_control_base select 1) - (_pos select 3) - 0.2*(_pos_control_base select 3) - (_coef_h_icon * ((_pos_control_base select 2)/6)), ((_pos_control_base select 2)/6), (_coef_h_icon * ((_pos_control_base select 2)/6))];
	_control ctrlCommit 0;
	_pic = getText (configFile >> "cfgMarkers" >> (GVAR(iconSlotParams) select _forEachIndex) >> "icon");
	_control ctrlSetText _pic;
	if !(GVAR(showIcon)) then {_control ctrlShow false};
} forEach _controls_icon;

// Arrange fast text buttons
{
	_control = _display displayCtrl _x;
	_control_pos = ctrlPosition _control;
	_control ctrlSetPosition [(_pos_control_base select 0) + (_pos_control_base select 2) - (_control_pos select 2)*(_forEachIndex+1),(_pos_control_base select 1),_control_pos select 2,_control_pos select 3];
	_control ctrlCommit 0;
} forEach [IDC_ADD_TEXT,IDC_ADD_NAME,IDC_ADD_GROUP];

// Setup fast text if saveMode enabled
if (GVAR(saveMode)) then {
	[_display displayCtrl IDC_ADD_TEXT,"T",true] call FUNC(fastText);
	[_display displayCtrl IDC_ADD_GROUP,"G",true] call FUNC(fastText);
	[_display displayCtrl IDC_ADD_NAME,"N",true] call FUNC(fastText);
};

// Arrange color/icon listboxes, hide if needed
_control_pic_pos = ctrlPosition _picture;
{
	_control = (_display displayCtrl _x);
	_control_pos = ctrlPosition _control;
	_control ctrlSetPosition [(_control_pic_pos select 0) - ((3*(((safeZoneW / safeZoneH) min 1.2) / 40))*(_forEachIndex+1)), (_control_pic_pos select 1) + (_control_pic_pos select 3)/2 - (_control_pos select 3)/2,(_control_pos select 2),(_control_pos select 3)];
	_control ctrlCommit 0;
	if !(GVAR(showLb)) then {_control ctrlShow false};
} forEach [IDC_LB_PIC,IDC_LB_COLOR];

// Arrange combo controls for color/icon selection
_pos_control_button = (ctrlPosition _buttonInfo);
_butt_cor_pos = 0;
if (GVAR(showButt)) then {_butt_cor_pos = 1.1*(1 * ((((safeZoneW / safeZoneH) min 1.2) / 1.2) / 25))};
{
	_control = (_display displayCtrl _x);
	_pos_control = (ctrlPosition _control);
	_control ctrlSetPosition [(_pos_control_button select 0) + (_pos_control_button select 2)/2 + (_pos_control_button select 2)*0.02, (_pos_control_button select 1) + (_pos_control_button select 3)*1 + (0.3 * ((((safeZoneW / safeZoneH) min 1.2) / 1.2) / 25)) + (_pos_control select 3)*_forEachIndex + _butt_cor_pos,_pos_control select 2, _pos_control select 3];
	_control ctrlCommit 0;
} forEach _combo_icon;

{
	_control = (_display displayCtrl _x);
	_pos_control = (ctrlPosition _control);
	_control ctrlSetPosition [(_pos_control_button select 0) + (_pos_control_button select 2)/2 - (_pos_control_button select 2)*0.02 - (_pos_control select 2), (_pos_control_button select 1) + (_pos_control_button select 3)*1+(0.3 * ((((safeZoneW / safeZoneH) min 1.2) / 1.2) / 25)) + (_pos_control select 3)*_forEachIndex + _butt_cor_pos,_pos_control select 2, _pos_control select 3];
	_control ctrlCommit 0;
} forEach _combo_color;

// Arrange advanced button and advanced controls group
_control = _display displayCtrl IDC_BUTTON_ADV;
_pos = ctrlPosition _control;
_control ctrlSetPosition [(_pos_control_button select 0), (_pos_control_button select 1) + (_pos_control_button select 3)*1 + (0.6 * ((((safeZoneW / safeZoneH) min 1.2) / 1.2) / 25)) + ((ctrlPosition (_display displayCtrl IDC_COMBO_11)) select 3)*6 + _butt_cor_pos,_pos select 2,_pos select 3];
_control ctrlCommit 0;

_control = _display displayCtrl IDC_CONTROLS_GROUP_ADV;
_pos = ctrlPosition (_display displayCtrl IDC_BUTTON_ADV);
_control ctrlSetPosition [_pos select 0, (_pos select 1) + (_pos select 3)*1.3, (ctrlPosition _control) select 2,(ctrlPosition _control) select 3];
_control ctrlCommit 0;

// Arrange settings button
_control = _display displayCtrl IDC_SETTINGS_BUTTON;
_pos = ctrlPosition _control;
_control ctrlSetPosition [(ctrlPosition (_text) select 0) + (ctrlPosition (_text) select 2),(ctrlPosition (_text) select 1),_pos select 2,_pos select 3];
_control ctrlCommit 0;

// Populate color listbox with slot params
{
	_color_type = (configFile >> "CfgMarkerColors" >> _x);
	_markColor = getArray (_color_type >> "color");

	// Convert string color values to numbers if needed
	{
		if (typeName _x != "SCALAR") then {
			_markColor set [_forEachIndex, call compile _x];
		};
	} forEach _markColor;
	_index = (_display displayCtrl IDC_LB_COLOR) lbAdd "";
	(_display displayCtrl IDC_LB_COLOR) lbSetValue [_index, _forEachIndex];
	(_display displayCtrl IDC_LB_COLOR) lbSetPicture [_index, format["#(argb,8,8,3)color(%1,%2,%3,%4)", _markColor select 0, _markColor select 1, _markColor select 2, _markColor select 3]];
	(_display displayCtrl IDC_LB_COLOR) lbSetData [_index, configName _color_type];
} forEach GVAR(colorSlotParams);

// Add extra colors from config if not already in slot params
{
	_color_type = _x;
	if !((configName _x) in GVAR(colorSlotParams)) then {
		_markColor = getArray (_color_type >> "color");

		{
			if (typeName _x != "SCALAR") then {
				_markColor set [_forEachIndex, call compile _x];
			};
		} forEach _markColor;
		_index = (_display displayCtrl IDC_LB_COLOR) lbAdd "";
		(_display displayCtrl IDC_LB_COLOR) lbSetValue [_index, _forEachIndex];
		(_display displayCtrl IDC_LB_COLOR) lbSetPicture [_index, format["#(argb,8,8,3)color(%1,%2,%3,%4)", _markColor select 0, _markColor select 1, _markColor select 2, _markColor select 3]];
		(_display displayCtrl IDC_LB_COLOR) lbSetData [_index, configName _color_type];
	};
} forEach GVAR(cfgMarkerColors);

// Populate icon listbox with slot params
{
	_marker = (configFile >> "CfgMarkers" >> _x);
	_pic = getText (_marker >> "icon");
	_index = (_display displayCtrl IDC_LB_PIC) lbAdd "";
	(_display displayCtrl IDC_LB_PIC) lbSetValue [_index, _forEachIndex];
	(_display displayCtrl IDC_LB_PIC) lbSetPicture [_index, _pic];
	(_display displayCtrl IDC_LB_PIC) lbSetData [_index, configName _marker];
} forEach GVAR(iconSlotParams);

// Add extra icons from config if not already in slot params
{
	_marker = _x;
	if !((configName _marker) in GVAR(iconSlotParams)) then {
		_pic = getText (_marker >> "icon");
		_index = (_display displayCtrl IDC_LB_PIC) lbAdd "";
		(_display displayCtrl IDC_LB_PIC) lbSetValue [_index, _forEachIndex];
		(_display displayCtrl IDC_LB_PIC) lbSetPicture [_index, _pic];
		(_display displayCtrl IDC_LB_PIC) lbSetData [_index, configName _marker];
	};
} forEach GVAR(cfgMarkers);

// Save current text to temp variable
GVAR(tempText) = ctrlText _text;
