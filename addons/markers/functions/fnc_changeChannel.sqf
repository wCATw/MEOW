#include "../script_component.hpp"

params ["_channelDisplay", "_dir"];

PARAM_INVALID(_channelDisplay,"DISPLAY")
PARAM_INVALID(_dir,"STRING")
GVAR_ISNIL(channel)
GVAR_ISNIL(availableChannels)
GVAR_ISNIL(allChannels)

private _curNum = GVAR(availableChannels) find GVAR(channel);

switch (_dir) do {
	case "UP": {
		_curNum = _curNum+1;
		if (_curNum>((count GVAR(availableChannels)) - 1)) then {_curNum = 0};
	};
	case "DOWN": {
		_curNum = _curNum-1;
		if (_curNum<0) then {_curNum = (count GVAR(availableChannels)) - 1};
	};
	default {
		hint "Change Channel Error."
	};
};

GVAR(channel) = GVAR(availableChannels) select _curNum;

[_channelDisplay, GVAR(channel)] call FUNC(setChannel);

setCurrentChannel (GVAR(allChannels) find GVAR(channel));