#include "../script_component.hpp"
/*
	Function: fnc_getColorChannel

		Description:
			Returns a formatted string for a channel name with the appropriate color for display.

		Arguments:
			_channel   <String>  - The channel code (e.g., "S", "C", "GL", etc.).
			_tag       <String>  - The tag to use in the formatted string (e.g., "t").

		Returns:
			<String> - The formatted and colored channel name string.

		Variables:
			_channel   <String>  - Channel code.
			_tag       <String>  - Tag for formatting.
*/



params ["_channel", "_tag"];

PARAM_INVALID(_channel,"STRING")
PARAM_INVALID(_tag,"STRING")

_channel = switch (_channel) do {
	case "S": {format ["<%2 color='#46D3FF'>%1</%2>", localize "STR_Channel_Side", _tag]};
	case "C": {format ["<%2 color='#FFFF46'>%1</%2>", localize "STR_Channel_Command", _tag]};
	case "GL": {format ["<%2 color='#E34234'>%1</%2>", localize "STR_Channel_Global", _tag]};
	case "V": {format ["<%2 color='#FFD000'>%1</%2>", localize "STR_Channel_Vehicle", _tag]};
	case "GR": {format ["<%2 color='#D0F0C0'>%1</%2>", localize "STR_Channel_Group", _tag]};
	case "D": {format ["<%2 color='#FFFFFF'>%1</%2>", localize "STR_Channel_Direct", _tag]};
};
_channel;