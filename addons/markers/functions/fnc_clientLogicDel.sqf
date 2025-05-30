#include "../script_component.hpp"

params ['_mark','_player'];

TRACE_2("called clientLogicDel with params:",_mark,_player);

private _m_index = GVAR(allMarkers) find _mark;

if (_m_index isEqualTo -1) exitWith {};

deleteMarkerLocal _mark;

private _paramsOut = GVAR(allMarkersParams) deleteAt _m_index;

GVAR(allMarkers) deleteAt _m_index;

["DEL", [name _player, _paramsOut]] call FUNC(log);