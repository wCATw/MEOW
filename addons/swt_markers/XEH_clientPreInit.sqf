#include "script_component.hpp"

// Exit on Headless
if (!hasInterface) exitWith {};

// UI

GVAR(disable) = false;
GVAR(loadEnabled) = true;
GVAR(loadEnabledFor) = true;
GVAR(loadEnabledWhen) = true;
GVAR(bisMarkers) = false;
GVAR(sweetk_s) = 1;
GVAR(markersTime) = 0;
GVAR(markersMapTime) = 0;
GVAR(fastTextN) = false;
GVAR(fastTextG) = false;
GVAR(fastTextT) = false;
GVAR(shiftState) = false;
GVAR(ctrlState) = false;
GVAR(altState) = false;
GVAR(channel) = localize "str_channel_group";
GVAR(delayCoeff) = 25;

_zero = [0,0];
ISNILS(GVAR(posM),_zero);

//mapHandlers
//displayHandlers

GVAR(avaliableChannels) = [localize "str_channel_global",localize "str_channel_side",localize "str_channel_command",localize "str_channel_group",localize "str_channel_vehicle",localize "str_channel_direct"];
GVAR(unavaliableChannels) = getArray (missionConfigFile >> "disableChannels");

call{
    _arr = GVAR(avaliableChannels);
    GVAR(avaliableChannels) = [];

    {
        if !(_forEachIndex in GVAR(unavaliableChannels)) then {
            GVAR(avaliableChannels) pushBack _x;
        };
    } forEach _arr;
}
