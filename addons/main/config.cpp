#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"cba_main"};
        author = "Kotovskiy";
        url = CSTRING(URL);
        VERSION_CONFIG;
    };
};



class CfgMods {
    class PREFIX {
        dir = "@MEOW";
        name = "MEOW";
        picture = "x\meow\MEOW.paa";
        hidePicture = "true";
        hideName = "true";
        actionName = "GitHub";
        action = CSTRING(URL);
    };
};