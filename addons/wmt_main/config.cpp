#include "script_component.hpp"

class CfgPatches {
    class SUBADDON {
        name = COMPONENT_NAME;
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"meow_main","cba_keybinding"};
        author = "Ezhuk, Zealot, Kotovskiy34";
        url = "https://github.com/wCATw/MEOW";
    };
};

#include "CfgEventHandlers.hpp"
