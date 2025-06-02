#include "../script_component.hpp"
/*
    Function: fnc_log

        Description:
            Logs marker actions (create, delete, direction, position, load) to the player's diary if logging is enabled.

        Arguments:
            _action   <String>  - The action type ("CREATE", "DEL", "DIR", "POS", "LOAD").
            _params   <Array>   - Parameters for the action.
            Global:
                logging     <Bool>   - If true, enables logging (read)
                markersLog  <String> - Diary subject for marker logs (read)

        Returns:
            none

        Variables:
            _sep, _text
*/

params ["_action", "_params"];

PARAM_INVALID(_action,"STRING")
PARAM_INVALID(_params,"ARRAY")
GVAR_ISNIL(logging)
GVAR_ISNIL(markersLog)

if (GVAR(logging)) then {
    // Ensure diary subject exists
    if !(player diarySubjectExists QGVAR(markersLog)) then {
        player createDiarySubject [QGVAR(markersLog), GVAR(markersLog)];
    };

    private ["_sep", "_text"];
    _sep = "<img image='#(argb,8,8,3)color(1,1,1,0.1)' height='2' width='512'/>";
    _text = "";

    // Format log entry based on action and params
    switch (_action) do {
        case "CREATE": {
            private ["_mark", "_Chan", "_Type", "_Owner"];
            _mark = _params select 0;
            _Chan = [(_params select 1),"font"] call FUNC(getColorChannel);
            _Type = _params select 4;
            _Owner = _params select 8;
            _text = format [
                (([time] call FUNC(getFormatedTime)) 
                + (localize LSTRING(MARKCREATED)) 
                + _sep),
                _Owner,
                _mark,
                _Chan,
                (
                    if (_Type==-2) then {
                        toLower(localize LSTRING(LINE))
                    } else {
                        if (_Type==-3) then {
                            toLower(localize LSTRING(ELLIPSE))
                        } else {
                            toLower(localize LSTRING(MARKER))
                        }
                    }
                )
            ];
        };
        case "DEL": {
            private ["_Name", "_markParams", "_mark", "_owner", "_Type"];
            _Name  = _params select 0;
            _markParams = _params select 1;
            _mark = _markParams select 0;
            _owner = _markParams select 8;
            _Type = _markParams select 4;
            _text = format [
                (([time] call FUNC(getFormatedTime)) 
                + (localize LSTRING(MARKDELETED)) 
                + _sep),
                _Name,
                _owner,
                _mark,
                (if (_Type==-2) then {
                    toLower(localize LSTRING(LINE))
                } else {
                    if (_Type==-3) then {
                        toLower(localize LSTRING(ELLIPSE))
                    } else {
                        toLower(localize LSTRING(MARKER))
                    }
                })
            ];
        };
        case "DIR": {
            private ["_Name", "_markParams", "_mark", "_owner", "_Type"];
            _Name  = _params select 0;
            _markParams = _params select 1;
            _mark = _markParams select 0;
            _owner = _markParams select 8;
            _Type = _markParams select 4;
            _text = format [
                (([time] call FUNC(getFormatedTime)) 
                + (localize LSTRING(MARKDIR)) 
                + "<font color='#F88379'><marker name='%3'>%4</marker></font>" + _sep),
                _Name,
                _owner,
                _mark,
                (if (_Type==-2) then {
                    toLower(localize LSTRING(LINE))
                } else {
                    if (_Type==-3) then {
                        toLower(localize LSTRING(ELLIPSE))
                    } else {
                        toLower(localize LSTRING(MARKER))
                    }
                })
            ];
        };
        case "POS": {
            private ["_Name", "_markParams", "_mark", "_owner", "_Type"];
            _Name  = _params select 0;
            _markParams = _params select 1;
            _mark = _markParams select 0;
            _owner = _markParams select 8;
            _Type = _markParams select 4;
            _text = format [
                (([time] call FUNC(getFormatedTime)) 
                + (localize LSTRING(MARKPOS)) 
                + "<font color='#F88379'><marker name='%3'>%4</marker></font>" 
                + _sep),
                _Name,
                _owner,
                _mark,
                (if (_Type==-2) then {
                    toLower(localize LSTRING(LINE))
                } else {
                    if (_Type==-3) then {
                        toLower(localize LSTRING(ELLIPSE))
                    } else {
                        toLower(localize LSTRING(MARKER))
                    }
                })
            ];
        };
        case "LOAD": {
            private ["_Name", "_count"];
            _Name  = _params select 0;
            _count = _params select 1;
            _text = format [
                str (([time] call FUNC(getFormatedTime)) 
                + (localize LSTRING(MARKLOAD)) 
                + _sep), 
                _Name, 
                _count
            ];
        };
    };
    // Add entry to diary
    player createDiaryRecord [QGVAR(markersLog), [localize LSTRING(LOG_DIARY_RECORD), _text]];
};
