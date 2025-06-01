#include "../script_component.hpp"

params ["_action", "_params"];

PARAM_INVALID(_action,"STRING")
PARAM_INVALID(_params,"ARRAY")
GVAR_ISNIL(logging)
GVAR_ISNIL(MarkersLog)

private _getFormatedTime = {
    params ["_time"];

    PARAM_INVALID(_time,"NUMBER")

    private ["_time", "_hour", "_minute", "_second"];

    _time = _this;
    _hour = floor(abs(_time)/3600);
    _minute = floor(abs(_time)/60)%60;
    _second = round(abs(_time)%60);
    format ["%1:%2:%3: ", _hour call FUNC(addZero), _minute call FUNC(addZero), _second call FUNC(addZero)];
};

if (GVAR(logging)) then {
    if !(player diarySubjectExists QGVAR(MarkersLog)) then {
        player createDiarySubject [QGVAR(MarkersLog), GVAR(MarkersLog)];
    };

    private ["_sep", "_text"];

    _sep = "<img image='#(argb,8,8,3)color(1,1,1,0.1)' height='2' width='512' />";
    _text = "";

    switch (_action) do {
        case "CREATE": {
            private ["_mark", "_Chan", "_Type", "_Name", "_colorName", "_text"];

            _mark = _params select 0;
            _Chan = _params select 1;
            _Chan = [_Chan,"font"] call FUNC(getColorChannel);
            _Type = _params select 4;
            _Name = _params select 8;
            _colorName = [_Name,"font"] call FUNC(getColorChannel);
            _text = format [(time call _getFormatedTime) + (localize LSTRING(MARKCREATED)) + _sep,
                        _colorName,
                        _mark,
                        _Chan,
                        (if (_Type==-2) then {toLower(localize LSTRING(LINE))} else {if (_Type==-3) then {toLower(localize LSTRING(ELLIPSE))} else {toLower(localize LSTRING(MARKER))}})
                    ];
        };
        case "DEL": {
            private ["_Name", "_colorName", "_markParams", "_mark", "_owner", "_Type", "_text"];

            _Name  = _params select 0;
            _colorName = [_Name,"font"] call FUNC(getColorName);
            _markParams = _params select 1;
            _mark = _markParams select 0;
            _owner = [(_markParams select 8),"font"] call FUNC(getColorName);;
            _Type = _markParams select 4;
            _text = format [(time call _getFormatedTime) + (localize LSTRING(MARKDELETED)) + _sep,
                        _colorName,
                        _owner,
                        _mark,
                        (if (_Type==-2) then {toLower(localize LSTRING(LINE))} else {if (_Type==-3) then {toLower(localize LSTRING(ELLIPSE))} else {toLower(localize LSTRING(MARKER))}})
                    ];
        };
        case "DIR": {
            private ["_Name", "_colorName", "_markParams", "_mark", "_owner", "_Type", "_text"];

            _Name  = _params select 0;
            _colorName = [_Name,"font"] call FUNC(getColorName);;
            _markParams = _params select 1;
            _mark = _markParams select 0;
            _owner = [(_markParams select 8),"font"] call FUNC(getColorName);;
            _Type = _markParams select 4;
            _text = format [(time call _getFormatedTime) + (localize LSTRING(MARKDIR)) + "<font color='#F88379'><marker name='%3'>%4</marker></font>" + _sep,
                        _colorName,
                        _owner,
                        _mark,
                        (if (_Type==-2) then {toLower(localize LSTRING(LINE))} else {if (_Type==-3) then {toLower(localize LSTRING(ELLIPSE))} else {toLower(localize LSTRING(MARKER))}})
                    ];
        };
        case "POS": {
            private ["_Name", "_colorName", "_markParams", "_mark", "_owner", "_Type", "_text"];

            _Name  = _params select 0;
            _colorName = [_Name,"font"] call FUNC(getColorName);
            _markParams = _params select 1;
            _mark = _markParams select 0;
            _owner = [(_markParams select 8),"font"] call FUNC(getColorName);
            _Type = _markParams select 4;
            _text = format [(time call _getFormatedTime) + (localize LSTRING(MARKPOS)) + "<font color='#F88379'><marker name='%3'>%4</marker></font>" + _sep,
                        _colorName,
                        _owner,
                        _mark,
                        (if (_Type==-2) then {toLower(localize LSTRING(LINE))} else {if (_Type==-3) then {toLower(localize LSTRING(ELLIPSE))} else {toLower(localize LSTRING(MARKER))}})
                    ];
        };
        case "LOAD": {
            private ["_Name", "_colorName", "_count", "_text"];

            _Name  = _params select 0;
            _colorName = [_Name,"font"] call FUNC(getColorName);
            _count = _params select 1;
            _text = format [(time call _getFormatedTime) + (localize LSTRING(MARKLOAD)) + _sep, _colorName, _count];
        };
    };
    player createDiaryRecord [QGVAR(MarkersLog), ["Log", _text]];
};