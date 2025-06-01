#include "../script_component.hpp"

private _createOne = {
    params ["_marker", "_params"];

    PARAM_INVALID(_marker,"STRING")
    PARAM_INVALID(_params,"ARRAY")

    private _mark = _marker + str (random 1000);
    _Text  = _params select 0;
    _Pos   = _params select 1;
    _Type  = _params select 2;
    _Color = _params select 3;

    _mark = createMarkerLocal [_mark,_Pos];
    _mark setMarkerTextLocal _Text;
    _mark setMarkerTypeLocal (GVAR(cfgMarkersNames) select _Type);
    _mark setMarkerColorLocal (GVAR(cfgMarkerColorsNames) select _Color);
};

private _getParams = {
    private ["_data","_obj"];

    _obj = nearestObject [_this,"Logic"];
    _data = (_obj) getVariable "p_d";
    [_data,_obj];
};

private _findMin = {
    params ["_arr"];

    PARAM_INVALID(_arr,"ARRAY")

    private ["_min", "_min_f", "_min_cell"];

    _min = 0;
    _min_f = 100000000;
    for "_i" from 0 to (count _arr)-1 do {
        private ["_curr_d"];

        _curr_d = ((_arr select _i) call _getParams) select 0;
        if (_curr_d select 0 < _min_f) then {
                _min = _i;
                _min_f = _curr_d select 0;
        };
    };
    _min_cell = _arr select _min;
    _arr deleteAt _min;
    _min_cell;
};

private _pathTo = {
    params ["_curr_road"];

    PARAM_INVALID(_curr_road,"OBJECT")

    _parent = (_curr_road call _getParams) select 0 select 3;
    _path = [];
    diag_log ((_curr_road call _getParams) select 0 select 1);
    while {!isNull _parent} do {
        _path pushBack _curr_road;
        _curr_road = (_curr_road call _getParams) select 0 select 3;
        _parent = (_curr_road call _getParams) select 0 select 3;
    };
    reverse _path;
    {
        [str _forEachIndex,["", (getPosATL _x),15,3]] call _createOne;
    } forEach _path;
};

private _deleteObjects = {
    params ['_objs'];

    PARAM_INVALID(_objs,"ARRAY")    

    {
        deleteVehicle _x;
    } forEach _objs;
};

params ["_first_pos", "_second_pos"];

[_first_pos, _second_pos] spawn {
    params ["_first_pos", '_second_pos'];

    private ["_rdischeck", "_start_road", "_end_road", "_done", "_objs", "_obj", "_black_roads", "_open_roads", "_count"];

    diag_log "SEARCH START -------------------------------------";
    _rdischeck = 35;
    _start_road = (_first_pos nearRoads 20) select 0;
    _end_road = (_second_pos nearRoads 20) select 0;
    _done = false;
    _objs = [];
    _obj = "Logic" createVehicleLocal (getPosATL _start_road);
    _obj setVariable ["p_d", [0,0,0,objNull]];

    _black_roads = [];
    _open_roads = [_start_road];
    _count = 0;
    while {count _open_roads > 0} do {
        private ["_curr_road", "_curr_params"];

        _curr_road = [_open_roads] call _findMin;
        _count = _count + 1;
        [str _count,["", (getPosATL _curr_road),15,10]] call _createOne;
        _black_roads pushBack _curr_road;
        if (_curr_road isEqualTo _end_road) exitWith {
            _done = true;
            _curr_road call _pathTo;
        };


        _roads = (roadsConnectedTo _curr_road) - _black_roads;

        _curr_params = (_curr_road call _getParams) select 0;

        {
            private ["_g", "_h"];

            _params = _x call _getParams;
            _g = (_x distance _curr_road) + (_curr_params select 1);
            if (!(_x in _open_roads)) then {
                _h = _x distance _end_road;
                _obj = "Logic" createVehicleLocal (getPosATL _x);
                        _obj setVariable ["p_d", [_g + _h, _g, _h, _curr_road]];
                        _objs pushBack _obj;
                _open_roads pushBack _x;
            } else {
                _obj = _params select 1;
                _params = _params select 0;

                if (_params select 1 > _g) then {
                        _h = _params select 2;
                        _params = [_g + _h, _g, _h, _curr_road];
                        _obj setVariable ["p_d", _params];
                };
            };
        } forEach _roads;
    };
    hint str ("LENGTH: " + str ((_end_road call _getParams) select 0 select 1));
    _objs call _deleteObjects;
    if (!_done) then {hint "ERROR"} else {};
};