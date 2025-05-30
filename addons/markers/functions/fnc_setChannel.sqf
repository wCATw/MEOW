#include "../script_component.hpp"

params ["_display", "_text"];

TRACE_2("called setChannel with params:",_display,_text);

private _control = _display displayCtrl IDC_BACKGROUND_DESCRIPTION;
_control ctrlSetStructuredText parseText format ["<t size='0.8'>%1</t>","Description:"];
if (_text == "") then {_text = localize "STR_Channel_Group"};
_control = _display displayCtrl IDC_BACKGROUND_DESCRIPTION;
_control ctrlSetStructuredText parseText format ["<t size='0.8'>%1</t>",_text];

switch (_text) do {
	case (localize "STR_Channel_Side"): {_control ctrlSetTextColor COLOR_SIDE_CHANNEL;};
	case (localize "STR_Channel_Command"): {_control ctrlSetTextColor COLOR_COMMAND_CHANNEL;};
	case (localize "STR_Channel_Direct"): {_control ctrlSetTextColor [1,1,1,1]};
	case (localize "STR_Channel_Global"): {_control ctrlSetTextColor COLOR_GLOBAL_CHANNEL;};
	case (localize "STR_Channel_Vehicle"): {_control ctrlSetTextColor COLOR_VEHICLE_CHANNEL;};
	case (localize "STR_Channel_Group"): {_control ctrlSetTextColor COLOR_GROUP_CHANNEL;};
};