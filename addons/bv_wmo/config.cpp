#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {"WMO_roadway_obj","WMO_roadway_obj_debug"};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        author = "Bloodwyn";
        requiredAddons[] = {"meow_main"};
        url = "https://github.com/wCATw/MEOW";
        VERSION_CONFIG;
    };
};

#include "CfgEventHandlers.hpp"
#include "CfgVehicles.hpp"
