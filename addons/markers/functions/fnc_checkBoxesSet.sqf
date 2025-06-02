#include "../script_component.hpp"
	/*
		Function: fnc_checkBoxesSet

			Description:
				Handles toggling and updating of various marker dialog UI settings and controls based on user actions.

			Arguments:
				_ctrls   <Array>   - Array of controls involved in the action.
				_action  <String>  - The action to perform (e.g., "SHOW OK", "SHOW ICON", etc.).
				Global:
					showInfo      <Any> - Advanced info panel state (read/set)
					showButt      <Any> - Show button state (read/set)
					settingsParams <Any> - Marker settings (read/set)
					showIcon      <Any> - Show icon state (read/set)
					showColor     <Any> - Show color state (read/set)
					showLb        <Any> - Show listbox state (read/set)
					saveMode      <Any> - Save mode state (read/set)
					saveText      <Any> - Save text state (read/set)
					showBack      <Any> - Show background state (read/set)
					saveMark      <Any> - Save marker state (read/set)
					logging       <Any> - Logging state (read/set)
					markInfo      <Any> - Marker info state (read/set)

			Returns:
				none
				Global:
					(see above) - Various UI and marker state globals may be updated (set)

			Variables:
				_ctrl, _display, _controls_color, _controls_icon, _combo_color, _combo_icon, _controls_icon_pic, and many local UI variables.
	*/

params ["_ctrls", "_action"];

PARAM_INVALID(_ctrls,"ARRAY")
PARAM_INVALID(_action,"STRING")
GVAR_ISNIL(showInfo)
GVAR_ISNIL(showButt)
GVAR_ISNIL(settingsParams)
GVAR_ISNIL(showIcon)
GVAR_ISNIL(showColor)
GVAR_ISNIL(showLb)
GVAR_ISNIL(saveMode)
GVAR_ISNIL(saveText)
GVAR_ISNIL(showBack)
GVAR_ISNIL(saveMark)
GVAR_ISNIL(logging)
GVAR_ISNIL(markInfo)

private ["_controls_color", "_controls_icon", "_combo_color", "_combo_icon", "_controls_icon_pic", "_ctrl", "_display"];

_ctrl = _ctrls select 0;
_display = ctrlParent _ctrl;

_controls_color = [IDC_COLOR_00,IDC_COLOR_01,IDC_COLOR_02,IDC_COLOR_03,IDC_COLOR_04,IDC_COLOR_05];
_controls_icon = [IDC_ICON_00,IDC_ICON_01,IDC_ICON_02,IDC_ICON_03,IDC_ICON_04,IDC_ICON_05];
_combo_color = [IDC_COMBO_00,IDC_COMBO_01,IDC_COMBO_02,IDC_COMBO_03,IDC_COMBO_04,IDC_COMBO_05];
_combo_icon = [IDC_COMBO_06,IDC_COMBO_07,IDC_COMBO_08,IDC_COMBO_09,IDC_COMBO_10,IDC_COMBO_11];
_controls_icon_pic = [IDC_ICON_10,IDC_ICON_11,IDC_ICON_12,IDC_ICON_13,IDC_ICON_14,IDC_ICON_15];

switch (_action) do {
	case "SHOW OK": {
		// Animate and toggle OK/Cancel buttons, update their positions and visibility
		private ["_text", "_buttonOK", "_buttonCancel", "_pos", "_posX", "_posY", "_posW", "_poH", "_show_coef"];

		_show_coef = 2;

		if (GVAR(showInfo)) then {
			_show_coef = 2
		} else {
			_show_coef = 1
		};

		_text = _display displayCtrl IDC_TEXT;
		_buttonOK = _display displayCtrl 1;
		_buttonCancel = _display displayCtrl 2;
		_pos = ctrlPosition _text;
		_posX = (_pos select 0);
		_posY = _pos select 1;
		_posW = _pos select 2;
		_posH = _pos select 3;
		_pos set [0,_posX];
		if (isNil {GVAR(RscDisplayInsertMarkerInfo)}) then {_pos set [1,_posY + _show_coef * _posH + 2 * 0.005]} else {_pos set [1,_posY + 10 * _posH + 3 * 0.005]};
		_pos set [2,_posW / 2 - 0.005];
		_pos set [3,_posH];

		_combo_color = [IDC_COMBO_00,IDC_COMBO_01,IDC_COMBO_02,IDC_COMBO_03,IDC_COMBO_04,IDC_COMBO_05];
		_combo_icon = [IDC_COMBO_06,IDC_COMBO_07,IDC_COMBO_08,IDC_COMBO_09,IDC_COMBO_10,IDC_COMBO_11];

		GVAR(showButt) = !(GVAR(showButt));
		GVAR(settingsParams) set [0, GVAR(showButt)];
		profileNamespace setVariable [QGVAR(settingsParams), GVAR(settingsParams)];

		private ["_control_button", "_pos_control_button", "_butt_cor_pos"];

		_control_button = (_display displayCtrl IDC_MENU_INFO);
		_pos_control_button = (ctrlPosition _control_button);
		_butt_cor_pos = -1.1*(1 * ((((safeZoneW / safeZoneH) min 1.2) / 1.2) / 25));

		if (GVAR(showButt)) then {_butt_cor_pos = 1.1*(1 * ((((safeZoneW / safeZoneH) min 1.2) / 1.2) / 25))};
		{
			private ["_control", "_pos_control"];
			_control = (_display displayCtrl _x);
			_pos_control = (ctrlPosition _control);
			_control ctrlSetPosition [_pos_control select 0, (_pos_control select 1)+_butt_cor_pos, _pos_control select 2, _pos_control select 3];
			_control ctrlCommit 0.2;
		} forEach (_combo_color+_combo_icon+[IDC_CONTROLS_GROUP_ADV,IDC_BUTTON_ADV]);

		if !(GVAR(showButt)) then {
			// Hide OK/Cancel buttons
			{
				(_display displayCtrl _x) ctrlSetPosition [(ctrlPosition (_display displayCtrl _x)) select 0,(ctrlPosition (_display displayCtrl _x)) select 1,(ctrlPosition (_display displayCtrl _x)) select 2,0];
				(_display displayCtrl _x) ctrlCommit 0.2;
			} forEach [1,2];
		} else {
			// Show and reposition OK/Cancel buttons
			_buttonOK ctrlSetPosition _pos;
			_buttonOK ctrlCommit 0.2;
			_pos set [0,_posX + _posW / 2];
			_pos set [2,_posW / 2];
			_pos set [3,_posH];
			_buttonCancel ctrlSetPosition _pos;
			_buttonCancel ctrlCommit 0.2;
		};
	};

	case "SHOW ICON": {
		// Toggle icon controls visibility and fade
		GVAR(showIcon) = !(GVAR(showIcon));
		GVAR(settingsParams) set [1,GVAR(showIcon)];
		profileNamespace setVariable [QGVAR(settingsParams), GVAR(settingsParams)];
		saveProfileNamespace;
		if (GVAR(showIcon)) then {
			{
				_control = _display displayCtrl _x;
				_control ctrlSetFade 1;
				_control ctrlCommit 0;
				_control ctrlShow true;
				_control ctrlSetFade 0;
				_control ctrlCommit 0.2;
			} forEach (_controls_icon+_controls_icon_pic);
		} else {
			{
				_control = _display displayCtrl _x;
				_control ctrlSetFade 1;
				_control ctrlCommit 0.2;
			} forEach (_controls_icon+_controls_icon_pic);

			{
				_control = _display displayCtrl _x;
				waitUntil {ctrlCommitted _control};
				_control ctrlShow false;
			} forEach (_controls_icon+_controls_icon_pic);
		};
	};

	case "SHOW COLOR": {
		// Toggle color controls visibility and fade
		GVAR(showColor) = !(GVAR(showColor));
		GVAR(settingsParams) set [2,GVAR(showColor)];
		profileNamespace setVariable [QGVAR(settingsParams), GVAR(settingsParams)];
		saveProfileNamespace;
		if (GVAR(showColor)) then {
			{
				_control = _display displayCtrl _x;
				_control ctrlSetFade 1;
				_control ctrlCommit 0;
				_control ctrlShow true;
				_control ctrlSetFade 0;
				_control ctrlCommit 0.2;
			} forEach (_controls_color);
		} else {
			{
				_control = _display displayCtrl _x;
				_control ctrlSetFade 1;
				_control ctrlCommit 0.2;
			} forEach (_controls_color);

			{
				_control = _display displayCtrl _x;
				waitUntil {ctrlCommitted _control};
				_control ctrlShow false;
			} forEach (_controls_color);
		};
	};

	case "SHOW LB": {
		// Toggle advanced listboxes (color/icon) visibility and fade
		GVAR(showLb) = !(GVAR(showLb));
		GVAR(settingsParams) set [3,GVAR(showLb)];
		profileNamespace setVariable [QGVAR(settingsParams), GVAR(settingsParams)];
		saveProfileNamespace;
		if (GVAR(showLb)) then {
			{
				_control = _display displayCtrl _x;
				if (ctrlShown _control) exitWith {};
				_control ctrlSetFade 1; _control ctrlCommit 0;
				_control ctrlShow true;
				_control ctrlSetFade 0;
				_control ctrlCommit 0.2;
			} forEach [IDC_LB_COLOR,IDC_LB_PIC];
		} else {
			{
				_control = _display displayCtrl _x;
				if !(ctrlShown _control) exitWith {};
				_control ctrlSetFade 1;
				_control ctrlCommit 0.2;
			} forEach [IDC_LB_COLOR,IDC_LB_PIC];

			{
				_control = _display displayCtrl _x;
				waitUntil {ctrlCommitted _control};
				_control ctrlShow false;
				_control ctrlSetFade 0;
				_control ctrlCommit 0;
			} forEach [IDC_LB_COLOR,IDC_LB_PIC];
		};
	};

	case "FAST LOAD": {
		// Toggle fast load setting and persist
		GVAR(saveMode) = !(GVAR(saveMode));
		GVAR(settingsParams) set [4,GVAR(saveMode)];
		profileNamespace setVariable [QGVAR(settingsParams), GVAR(settingsParams)];
		saveProfileNamespace;
	};

	case "SAVE TEXT": {
		// Toggle save text setting and persist
		GVAR(saveText) = !(GVAR(saveText));
		GVAR(settingsParams) set [5,GVAR(saveText)];
		profileNamespace setVariable [QGVAR(settingsParams), GVAR(settingsParams)];
		saveProfileNamespace;
	};

	case "SHOW _INFO": {
		// Toggle info panel, animate, update settings, reposition controls
		GVAR(showInfo) = !(GVAR(showInfo));
		GVAR(settingsParams) set [6,GVAR(showInfo)];
		profileNamespace setVariable [QGVAR(settingsParams), GVAR(settingsParams)];
		saveProfileNamespace;
		if (!isNil {GVAR(RscDisplayInsertMarkerInfo)}) then {
			((findDisplay IDD_DISPLAY_INSERT_MARKER) displayCtrl IDC_MENU_INFO) call FUNC(infoAnim);
			uiSleep 0.25;
		};

		waitUntil {ctrlCommitted (_display displayCtrl 1)};
		_butt_cor_pos = -1.1*(1 * ((((safeZoneW / safeZoneH) min 1.2) / 1.2) / 25));

		if (GVAR(showInfo)) then {_butt_cor_pos = 1.1*(1 * ((((safeZoneW / safeZoneH) min 1.2) / 1.2) / 25))};
		{
			_control = (_display displayCtrl _x);
			_pos_control = (ctrlPosition _control);
			_control ctrlSetPosition [_pos_control select 0, (_pos_control select 1)+_butt_cor_pos, _pos_control select 2, _pos_control select 3];
			_control ctrlCommit 0.2;
		} forEach (_combo_color+_combo_icon+[IDC_CONTROLS_GROUP_ADV,IDC_BUTTON_ADV,1,2]);

		_pos = ctrlPosition (_display displayCtrl IDC_MENU_INFO);
		(_display displayCtrl IDC_MENU_INFO) ctrlSetPosition [_pos select 0,_pos select 1,_pos select 2, if (GVAR(showInfo)) then {1 * ((((safeZoneW / safeZoneH) min 1.2) / 1.2) / 25)} else {0}];
		(_display displayCtrl IDC_MENU_INFO) ctrlCommit 0.2;
	};

	case "SHOW BACK": {
		// Animate background fade in/out
		GVAR(showBack) = !(GVAR(showBack));
		GVAR(settingsParams) set [7,GVAR(showBack)];
		profileNamespace setVariable [QGVAR(settingsParams), GVAR(settingsParams)];
		saveProfileNamespace;
		if (GVAR(showBack)) then {
			for "_i" from 0 to 40 do {
				uiSleep (0.2/40);
				(_display displayCtrl IDC_BACKGROUND_DESCRIPTION) ctrlSetBackgroundColor [0,0,0,(_i/57)];
			};
		} else {
			for "_i" from 40 to 0 step -1 do {
				uiSleep (0.2/40);
				(_display displayCtrl IDC_BACKGROUND_DESCRIPTION) ctrlSetBackgroundColor [0,0,0,(_i/57)];
			};
		};
	};

	case "SAVE MARK": {
		// Toggle save mark setting and persist
		GVAR(saveMark) = !(GVAR(saveMark));
		GVAR(settingsParams) set [8,GVAR(saveMark)];
		profileNamespace setVariable [QGVAR(settingsParams), GVAR(settingsParams)];
		saveProfileNamespace;
	};

	case "_LOG": {
		// Toggle logging setting and persist
		GVAR(logging) = !(GVAR(logging));
		GVAR(settingsParams) set [10,GVAR(logging)];
		profileNamespace setVariable [QGVAR(settingsParams), GVAR(settingsParams)];
		saveProfileNamespace;
	};

	case "MARK _INFO": {
		// Toggle mark info, update settings, hide advanced button in map display
		GVAR(markInfo) = !(GVAR(markInfo));
		GVAR(settingsParams) set [11,GVAR(markInfo)];
		profileNamespace setVariable [QGVAR(settingsParams), GVAR(settingsParams)];
		saveProfileNamespace;
		_displayMap = ({if !(isNull(findDisplay _x)) exitWith {findDisplay _x}} forEach [37,52,53,12]);
		(_displayMap displayCtrl IDC_BUTTON_ADV) ctrlShow false;
	};
};
