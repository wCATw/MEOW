#include "../script_component.hpp"
/*
	Function: fnc_infoButtons

		Description:
			Updates the info/settings/author text and size in the marker dialog info group based on the requested action.

		Arguments:
			_control   <Control>  - The info group control to update.
			_act       <String>   - The action to perform ("info", "sett", "author").

		Returns:
			none

		Variables:
			_control, _act, _pos, _display - UI controls and display references.
*/

params ["_control", "_act"];

PARAM_INVALID(_control,"CONTROL")
PARAM_INVALID(_act,"STRING")

private ["_pos","_display"];

_display = ctrlParent _control;

switch (_act) do {
	case 'info': {
		// Set info group height for info, update text
		_pos = ctrlPosition (_display displayCtrl IDC_CONTROLS_GROUP_INFO);
		(_display displayCtrl IDC_CONTROLS_GROUP_INFO) ctrlSetPosition [_pos select 0,_pos select 1,_pos select 2,25 * ((((safeZoneW / safeZoneH) min 1.2) / 1.2) / 25)];
		(_display displayCtrl IDC_CONTROLS_GROUP_INFO) ctrlCommit 0;
		(_display displayCtrl IDC_CONTROLS_GROUP_INFO) ctrlSetStructuredText parseText format [
			localize LSTRING(INFOTXT),
			"#F88379"
		];
	};
	case 'sett': {
		// Set info group height for settings, update text
		_pos = ctrlPosition (_display displayCtrl IDC_CONTROLS_GROUP_INFO);
		(_display displayCtrl IDC_CONTROLS_GROUP_INFO) ctrlSetPosition [_pos select 0,_pos select 1,_pos select 2,20 * ((((safeZoneW / safeZoneH) min 1.2) / 1.2) / 25)];
		(_display displayCtrl IDC_CONTROLS_GROUP_INFO) ctrlCommit 0;
		(_display displayCtrl IDC_CONTROLS_GROUP_INFO) ctrlSetStructuredText parseText format [
			localize LSTRING(SETTXT),
			"#F88379"
		];
	};
	case 'author': {
		// Set info group height for author, update text with links
		_pos = ctrlPosition (_display displayCtrl IDC_CONTROLS_GROUP_INFO);
		(_display displayCtrl IDC_CONTROLS_GROUP_INFO) ctrlSetPosition [_pos select 0,_pos select 1,_pos select 2,10 * ((((safeZoneW / safeZoneH) min 1.2) / 1.2) / 25)];
		(_display displayCtrl IDC_CONTROLS_GROUP_INFO) ctrlCommit 0;
		(_display displayCtrl IDC_CONTROLS_GROUP_INFO) ctrlSetStructuredText parseText format [
			localize LSTRING(ATXT),
			"#F88379","http://goo.gl/AcloSD","http://goo.gl/rc5eKA"
		];
	};
};
