#include "../script_component.hpp"
/*
	Function: fnc_advancedSetButton

		Description:
			Toggles the advanced settings panel in the marker dialog and updates all advanced setting controls to reflect current global states.

		Arguments:
			_displayCtrl   <Control>  - The control that triggered the advanced settings panel.

		Returns:
			none

		Variables:
			_display   <Display>  - The parent display.
*/

params ["_displayCtrl"];

PARAM_INVALID(_displayCtrl,"CONTROL");
GVAR_ISNIL(showButt)
GVAR_ISNIL(showIcon)
GVAR_ISNIL(showColor)
GVAR_ISNIL(showLb)
GVAR_ISNIL(saveText)
GVAR_ISNIL(saveMode)
GVAR_ISNIL(showInfo)
GVAR_ISNIL(showBack)
GVAR_ISNIL(saveMark)
GVAR_ISNIL(logging)
GVAR_ISNIL(markInfo)
GVAR_ISNIL(disableLoc)
GVAR_ISNIL(fastTextTSaved)

private _display = ctrlParent _displayCtrl;
ctrlSetFocus (_display displayCtrl IDC_TEXT);

if (isNil {GVAR(advSet)}) then {
	/*
		Advanced settings panel is currently hidden.
		- Set all checkboxes and controls to match global states.
		- Show the advanced settings panel.
	*/
	GVAR(advSet) = true;
	(_display displayCtrl IDC_ADV_CB_SHOW_BUTTON) cbSetChecked GVAR(showButt);
	(_display displayCtrl IDC_ADV_CB_SHOW_ICON) cbSetChecked GVAR(showIcon);
	(_display displayCtrl IDC_ADV_CB_SHOW_COLOR) cbSetChecked GVAR(showColor);
	(_display displayCtrl IDC_ADV_CB_SHOW_LB) cbSetChecked GVAR(showLb);
	(_display displayCtrl IDC_ADV_CB_SAVE_TEXT) cbSetChecked GVAR(saveText);
	(_display displayCtrl IDC_ADV_CB_FAST_LOAD) cbSetChecked GVAR(saveMode);
	(_display displayCtrl IDC_ADV_SHOW_INFO) cbSetChecked GVAR(showInfo);
	(_display displayCtrl IDC_ADV_CB_SHOW_BACK) cbSetChecked GVAR(showBack);
	(_display displayCtrl IDC_ADV_CB_SAVE_MARK) cbSetChecked GVAR(saveMark);
	(_display displayCtrl IDC_ADV_CB_LOG) cbSetChecked GVAR(logging);
	(_display displayCtrl IDC_ADV_CB_MARKINFO) cbSetChecked GVAR(markInfo);
	if (GVAR(disableLoc)) then {
		(_display displayCtrl IDC_ADV_BUTTON_DISABLE) ctrlSetText (localize LSTRING(ENABLE));
	} else {
		(_display displayCtrl IDC_ADV_BUTTON_DISABLE) ctrlSetText (localize LSTRING(DISABLE));
	};
	(_display displayCtrl IDC_ADV_EDIT_SAVED) ctrlSetText GVAR(fastTextTSaved);
	(_display displayCtrl IDC_CONTROLS_GROUP_ADV) ctrlShow true;
	(_display displayCtrl IDC_CONTROLS_GROUP_ADV) ctrlSetFade 0;
	(_display displayCtrl IDC_CONTROLS_GROUP_ADV) ctrlCommit 0.2;
} else {
	/*
		Advanced settings panel is currently shown.
		- Hide the advanced settings panel and reset state.
	*/
	GVAR(advSet) = nil;
	(_display displayCtrl IDC_CONTROLS_GROUP_ADV) ctrlSetFade 1;
	(_display displayCtrl IDC_CONTROLS_GROUP_ADV) ctrlCommit 0.2;
	waitUntil {ctrlCommitted (_display displayCtrl IDC_CONTROLS_GROUP_ADV)};
	(_display displayCtrl IDC_CONTROLS_GROUP_ADV) ctrlShow false;
};