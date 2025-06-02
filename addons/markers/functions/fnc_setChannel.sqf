#include "../script_component.hpp"
/*
	Function: fnc_setChannel
		Description:
			Sets the channel description and color in the marker UI based on the selected channel text.
		Arguments:
			_display   <Display>  - The display containing the channel description control.
			_text      <String>   - The channel name or description to display.
		Returns:
			none
		Variables:
			_display     <Display>  - The display.
			_text        <String>   - Channel name/description.
			_control     <Control>  - The description control being updated.
*/

params ["_display", "_text"];

PARAM_INVALID(_display,"DISPLAY")
PARAM_INVALID(_text,"STRING")

private _control = _display displayCtrl IDC_BACKGROUND_DESCRIPTION;

// Set default description text
_control ctrlSetStructuredText parseText format ["<t size='0.8'>%1</t>","Description:"];

// If no channel text, fallback to group channel
if (_text == "") then {_text = localize "STR_Channel_Group"};

// Update description control with channel text
_control = _display displayCtrl IDC_BACKGROUND_DESCRIPTION;
_control ctrlSetStructuredText parseText format ["<t size='0.8'>%1</t>",_text];

// Set text color based on channel type
switch (_text) do
{
	case (localize "STR_Channel_Side"):
	{
		_control ctrlSetTextColor COLOR_SIDE_CHANNEL;
	};
	case (localize "STR_Channel_Command"):
	{
		_control ctrlSetTextColor COLOR_COMMAND_CHANNEL;
	};
	case (localize "STR_Channel_Direct"):
	{
		_control ctrlSetTextColor [1,1,1,1];
	};
	case (localize "STR_Channel_Global"):
	{
		_control ctrlSetTextColor COLOR_GLOBAL_CHANNEL;
	};
	case (localize "STR_Channel_Vehicle"):
	{
		_control ctrlSetTextColor COLOR_VEHICLE_CHANNEL;
	};
	case (localize "STR_Channel_Group"):
	{
		_control ctrlSetTextColor COLOR_GROUP_CHANNEL;
	};
};
