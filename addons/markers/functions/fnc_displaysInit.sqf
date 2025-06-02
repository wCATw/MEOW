#include "../script_component.hpp"
/*
    Function: fnc_displaysInit

        Description:
            Initializes event handlers and UI controls for map displays used in the marker system.

        Arguments:
            Global:
                limitSideMarkers    <Any>   - Used to determine if side marker limiting is enabled (read-only)
            none

        Returns:
            Global:
                none
            none

        Variables:
            _addHandlers   <Code>    - Function to add event handlers to a map display.
            _mapDisplay    <Display> - The map display being initialized.
*/

GVAR_ISNIL(limitSideMarkers)

private _addHandlers = {
    params ["_mapDisplay"];

    PARAM_INVALID(_mapDisplay,"DISPLAY")

    _control = _mapDisplay displayCtrl IDC_MAP;

    // Add mouse and keyboard event handlers to the map control
    _id0 = _control ctrlAddEventHandler [
        "MouseButtonDblClick",
        {
            _this spawn FUNC(mapButtonDblClick)
        }
    ];
    _id1 = _control ctrlAddEventHandler [
        "MouseButtonDown",
        {
            _this call FUNC(mapMouseDown);
        }
    ];
    _id2 = _control ctrlAddEventHandler [
        "MouseButtonUp",
        {
            _this call FUNC(mapMouseUp);
        }
    ];
    _id3 = _mapDisplay displayAddEventHandler [
        "KeyDown",
        {
            _this call FUNC(mapKeyDown);
        }
    ];
    _id4 = _control ctrlAddEventHandler [
        "MouseMoving",
        {
            _this call FUNC(mapMouseMoving);
        }
    ];
    _id5 = _control ctrlAddEventHandler [
        "MouseHolding",
        {
            _this call FUNC(mapMouseHold);
        }
    ];

    // Add handler for limiting side markers (if enabled)
    _control ctrlAddEventHandler [
        "KeyDown",
        {
            params ["_dispCtrl", "_key", "_shift", "_ctrl", "_alt"];
            if (GVAR(limitSideMarkers) isNotEqualTo 0) then {
                (
                    (_key == DIK_LMENU && _ctrl)
                    || (_key == DIK_LCONTROL && _alt)
                )
                || (
                    _key in [DIK_LCONTROL, DIK_LMENU]
                    && currentChannel == 1
                    && {
                        !(0 call FUNC(checkSideChannel))
                    }
                )
            } else {
                false
            };
        }
    ];

    // Create and configure advanced marker info control (hidden by default)
    _ctrl = _mapDisplay ctrlCreate [
        "RscStructuredText",
        IDC_BUTTON_ADV
    ];
    _ctrl ctrlShow false;
    _ctrl ctrlSetBackgroundColor [0, 0, 0, 0.7];
    _ctrl ctrlSetPosition [0, 0, 10.8 * GR_W, 3.5 * GR_H];
    _ctrl ctrlCommit 0;
};

// Close marker dialog if opened in unsupported display
[] spawn {
    private ["_display"];
    disableSerialization;
    while {true} do {
        waitUntil {
            _display = uiNamespace getVariable ["RscDisplayInsertMarker", displayNull];
            !isNull _display
        };
        _display closeDisplay 0;
    };
};

// Wait for a supported map display and initialize handlers
waitUntil {
    (!isNull (findDisplay 12))
    or (!isNull (findDisplay 37))
    or (!isNull (findDisplay 52))
    or (!isNull (findDisplay 53))
};
_mapDisplay = ({
    if !(isNull (findDisplay _x)) exitWith {
        findDisplay _x;
    };
} forEach [37, 52, 53, 12]);
if (_mapDisplay == (findDisplay 12)) then {
    [_mapDisplay] call _addHandlers;
} else {
    [_mapDisplay] call _addHandlers;
    sleep 1;
    waitUntil {
        (!isNull (findDisplay 12))
    };
    [(findDisplay 12)] call _addHandlers;
};
