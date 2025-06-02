#include "../script_component.hpp"
    /*
        Function: fnc_radioListenFreqs

            Description:
                Retrieves the list of radio listening frequencies for a player, including long-range and short-range radios, if enabled.

            Arguments:
                _player   <Object>  - The player object to get radio frequencies for.
                Global:
                    groupMarkersViaRadio <Scalar> - Controls LR radio group marker logic (read)

            Returns:
                <Array> - Array of radio frequencies the player is listening to.

            Variables:
                _player         <Object>  - The player.
                _result         <Array>   - Array to store frequencies.
                _radiolist      <Array>   - List of LR radios.
                _lr_settings    <Array>   - Settings for the LR radio.
                _sw_settings    <Array>   - Settings for the SW radio.
    */

params ["_player"];

PARAM_INVALID(_player,"OBJECT")
GVAR_ISNIL(groupMarkersViaRadio)

private _result = [];

// Exit if player is dead or not a player
if (!alive _player || !isPlayer _player) exitWith {_result};

// Get LR radios if groupMarkersViaRadio enabled
private _radiolist = if (GVAR(groupMarkersViaRadio) > 1) then {
    _player call TFAR_fnc_lrRadiosList;
} else {[]};

// Extract LR radio frequencies if available
private _lr_settings = [];
if (count(_radiolist) > 0) then {
    _lr_settings =  (_radiolist # 0) call tfar_fnc_getLRSettings;
    if (!isNil{_lr_settings}) then {
        _result pushBack ((_lr_settings #2) # (_lr_settings #0)); // Main freq
        if (_lr_settings# 5 isNotEqualTo -1) then {
            _result pushBack ((_lr_settings #2) # (_lr_settings #5)); // Additional freq
        };
    };
};

// Extract SW radio frequencies if available
private _sw_settings = [_player call FUNC(getActiveSWRadio), _player] call FUNC(getRadioWSSettings);
if (!isNil{_sw_settings}) then {
    _result pushBack ((_sw_settings #2) # (_sw_settings #0)); // Main freq
    if (_sw_settings# 5 isNotEqualTo -1) then {
        _result pushBack ((_sw_settings #2) # (_sw_settings #5)); // Additional freq
    };
};

_result;
