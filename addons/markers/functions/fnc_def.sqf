#include "../script_component.hpp"

GVAR_ISNIL(colorSlotParams)
GVAR_ISNIL(iconSlotParams)
GVAR_ISNIL(settingsParams)

hintSilent (localize LSTRING(DEF_MESSAGE));
profileNamespace setVariable [QGVAR(colorSlotParams), ["ColorBlue","ColorRed","ColorGreen","ColorBlack","ColorWhite","ColorYellow"]];
profileNamespace setVariable [QGVAR(iconSlotParams), ["mil_dot","o_inf","o_armor","hd_pickup","hd_warning","hd_unknown"]];
profileNamespace setVariable [QGVAR(settingsParams), [false,true,true,false,true,false,true,true,true,"",true, true]];
saveProfileNamespace;
call FUNC(profileNil);