#include "../script_component.hpp"

params ["_player"];

TRACE_1("called radioListenFreqs with params:",_player);

private _result = [];

if (!alive _player || !isPlayer _player) exitWith {_result};

private _radiolist = if (GVAR(groupMarkersViaRadio) > 1) then {
    _player call TFAR_fnc_lrRadiosList;
} else {[]};

private _lr_settings = [];
if (count(_radiolist) > 0) then {
    _lr_settings =  (_radiolist # 0) call tfar_fnc_getLRSettings;
    if (!isNil{_lr_settings}) then {
        _result pushBack ((_lr_settings #2) # (_lr_settings #0));
        if (_lr_settings# 5 isNotEqualTo -1) then {
            _result pushBack ((_lr_settings #2) # (_lr_settings #5));
        };
    };
};

private _sw_settings = [_player call FUNC(getActiveSWRadio), _player] call FUNC(getRadioWSSettings);
if (!isNil{_sw_settings}) then {
    _result pushBack ((_sw_settings #2) # (_sw_settings #0));
    if (_sw_settings# 5 isNotEqualTo -1) then {
        _result pushBack ((_sw_settings #2) # (_sw_settings #5));
    };
};
_result;