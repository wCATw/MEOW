#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {QGVAR(disableModule), QGVAR(paramsModule)};
        weapons[] = {QGVAR(ItemSGPS)};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"meow_main"};
        authors[] = {"Kotovskiy"};
        url = ECSTRING(main,URL);
        VERSION_CONFIG;
    };
};

#include "CfgEventHandlers.hpp"
#include "CfgFontFamilies.hpp"
#include "CfgWeapons.hpp"
#include "CfgFactionClasses.hpp"
#include "CfgVehicles.hpp"
#include "MEOW_Settings.hpp"

class RscListBox;
class RscIGUIListBox;
class RscXListBox;
class RscStructuredText;
class RscButtonMenu;
class RscButton;
class RscPicture;
class RscText;
class RscEdit;
class RscActivePicture;
class RscToolbox;
class RscIGUIShortcutButton;
class RscShortcutButton;
class RscActiveText;
class ScrollBar;
class RscCombo;
class RscControlsGroup;
class RscButtonMenuOK;
class RscButtonMenuCancel;
class RscCheckBox;
class RscMapControl
{
	class CustomMark
	{
		color[]={0,0,0,0};
	};
};

#include "resources/ScrollBar.hpp"
#include "resources/MDL_RscButton.hpp"
#include "resources/RscActivePicture.hpp"
#include "resources/RscButton.hpp"
#include "resources/RscButtonMenu.hpp"
#include "resources/RscCheckBox.hpp"
#include "resources/RscCombo.hpp"
#include "resources/RscControlsGroup.hpp"
#include "resources/RscDisplayChannel.hpp"
#include "resources/RscStructuredText.hpp"
#include "resources/RscDisplayInsertMarker.hpp"