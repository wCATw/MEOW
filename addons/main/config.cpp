#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        author = "Kotovskiy34";
        url = "https://github.com/wCATw/MEOW";
    };
};

class CfgMods {
    class PREFIX {
        dir = "@MEOW";
        name = "Modify, Enhance, Optimize, Weave";
        picture = "A3\Ui_f\data\Logos\arma3_expansion_alpha_ca";
        hidePicture = "true";
        hideName = "true";
        actionName = "GitHub";
        action = "https://github.com/wCATw/MEOW";
        description = "Meow!";
    };
};
