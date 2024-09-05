#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"meow_main"};
        author = "swatSTEAM, Kotovskiy34";
        url = "https://github.com/wCATw/MEOW";
    };
};

#include "CfgEventHandlers.hpp"
