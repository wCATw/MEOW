#include "../script_component.hpp"

params ["_control", "_act"];

TRACE_2("called infoButtons with params:",_control,_act);

private ["_pos","_display"];

_display = ctrlParent _control;
switch (_act) do {
	case 'info': {
		_pos = ctrlPosition (_display displayCtrl IDC_CONTROLS_GROUP_INFO);
		(_display displayCtrl IDC_CONTROLS_GROUP_INFO) ctrlSetPosition [_pos select 0, _pos select 1, _pos select 2, 25 * ((((safeZoneW / safeZoneH) min 1.2) / 1.2) / 25)];
		(_display displayCtrl IDC_CONTROLS_GROUP_INFO) ctrlCommit 0;
		(_display displayCtrl IDC_CONTROLS_GROUP_INFO) ctrlSetStructuredText parseText format [
				localize LSTRING(INFOTXT),
				"#F88379"
			];
	};

		case 'sett': {
		_pos = ctrlPosition (_display displayCtrl IDC_CONTROLS_GROUP_INFO);
		(_display displayCtrl IDC_CONTROLS_GROUP_INFO) ctrlSetPosition [_pos select 0, _pos select 1, _pos select 2, 20 * ((((safeZoneW / safeZoneH) min 1.2) / 1.2) / 25)];
		(_display displayCtrl IDC_CONTROLS_GROUP_INFO) ctrlCommit 0;
		(_display displayCtrl IDC_CONTROLS_GROUP_INFO) ctrlSetStructuredText parseText format [
				localize LSTRING(SETTXT),
				"#F88379"
			];
	};

		case 'author': {
		_pos = ctrlPosition (_display displayCtrl IDC_CONTROLS_GROUP_INFO);
		(_display displayCtrl IDC_CONTROLS_GROUP_INFO) ctrlSetPosition [_pos select 0, _pos select 1, _pos select 2, 10 * ((((safeZoneW / safeZoneH) min 1.2) / 1.2) / 25)];
		(_display displayCtrl IDC_CONTROLS_GROUP_INFO) ctrlCommit 0;
		(_display displayCtrl IDC_CONTROLS_GROUP_INFO) ctrlSetStructuredText parseText format [
				localize LSTRING(ATXT),
				"#F88379","http://goo.gl/AcloSD","http://goo.gl/rc5eKA"
			];
	};
};