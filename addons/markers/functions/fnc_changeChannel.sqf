#include "../script_component.hpp"

params ["_channelDisplay", "_dir"];

TRACE_2("called changeChannel with params:",_channelDisplay,_dir);

private _curNum = GVAR(avaliableChannels) find GVAR(channel);

switch (_dir) do {
	case "UP": {
		_curNum = _curNum+1;
		if (_curNum>((count GVAR(avaliableChannels)) - 1)) then {_curNum = 0};
	};
	case "DOWN": {
		_curNum = _curNum-1;
		if (_curNum<0) then {_curNum = (count GVAR(avaliableChannels)) - 1};
	};
	default {
		hint "Change Channel Error."
	};
};

GVAR(channel) = GVAR(avaliableChannels) select _curNum;

[_channelDisplay, GVAR(channel)] call FUNC(setChannel);

setCurrentChannel (GVAR(allChannels) find GVAR(channel));