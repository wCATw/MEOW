#include "../script_component.hpp"
    /*
        Function: fnc_setIcon

            Description:
                Sets the marker icon type and updates the marker icon preview in the UI when a user selects a new icon.

            Arguments:
                _control   <Control>  - The control that triggered the icon change.
                _num       <Scalar>   - The index of the selected icon in the icon slot parameters.
                Global:
                    iconSlotParams <Array>  - Icon slot parameters (read)
                    pic           <String> - Marker icon (read/set)
                    markType      <String> - Marker type (read/set)

            Returns:
                none
                Global:
                    markType      <String> - Marker type (set)
                    pic           <String> - Marker icon (set)

            Variables:
                _control        <Control>  - The triggering control.
                _num            <Scalar>   - Index of the selected icon.
    */

params ["_control", "_num"];

PARAM_INVALID(_control,"CONTROL")
PARAM_INVALID(_num,"SCALAR")
GVAR_ISNIL(iconSlotParams)
GVAR_ISNIL(pic)
GVAR_ISNIL(markType)

// Focus text input after icon selection
ctrlSetFocus ((ctrlParent _control) displayCtrl IDC_TEXT);

// Update global marker type and icon
GVAR(markType) = GVAR(iconSlotParams) select _num;
GVAR(pic) = (ctrlText _control);

// Update icon preview in UI
((ctrlParent _control) displayCtrl IDC_PICTURE) ctrlSetText GVAR(pic);
