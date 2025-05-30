#include "script_component.hpp"

ADDON = false;

#include "initSettings.inc.sqf"
#include "initKeybinds.inc.sqf"

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

ADDON = true;