#include "../script_component.hpp"
	/*
		Function: fnc_changeChannel

			Description:
				Changes the current marker channel to the next or previous available channel and updates the UI.

			Arguments:
				_channelDisplay   <Display>  - The display containing the channel control.
				_dir              <String>   - Direction to change ("UP" or "DOWN").
				Global:
					channel            <Any>   - Current channel (read/set)
					availableChannels  <Array> - List of available channels (read)
					allChannels        <Array> - List of all channels (read)

			Returns:
				none
				Global:
					channel <Any> - Updated channel (set)

			Variables:
				_curNum   <Number>  - Current channel index.
	*/

params ["_channelDisplay", "_dir"];

PARAM_INVALID(_channelDisplay,"DISPLAY")
PARAM_INVALID(_dir,"STRING")
GVAR_ISNIL(channel)
GVAR_ISNIL(availableChannels)
GVAR_ISNIL(allChannels)

// Get the current channel index
private _curNum = GVAR(availableChannels) find GVAR(channel);

switch (_dir) do
{
	case "UP":
	{
		// Next channel
		_curNum = _curNum + 1;
		// upper bound
		if (_curNum > ((count GVAR(availableChannels)) - 1)) then
		{
			_curNum = 0;
		};
	};
	case "DOWN":
	{
		// Previous channel
		_curNum = _curNum - 1;
		// lower bound
		if (_curNum < 0) then
		{
			_curNum = (count GVAR(availableChannels)) - 1;
		};
	};
	default
	{
		hint "Change Channel Error.";
	};
};

GVAR(channel) = GVAR(availableChannels) select _curNum;

[_channelDisplay,GVAR(channel)] call FUNC(setChannel);

setCurrentChannel (GVAR(allChannels) find GVAR(channel));