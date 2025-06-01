#include "../script_component.hpp"

params ['_mark','_player'];

PARAM_INVALID(_mark,"STRING")
PARAM_INVALID(_player,"OBJECT")
GVAR_ISNIL(allMarkers)
GVAR_ISNIL(allMarkersParams)

private _m_index = GVAR(allMarkers) find _mark;

if (_m_index isEqualTo -1) exitWith {};

deleteMarkerLocal _mark;

private _paramsOut = GVAR(allMarkersParams) deleteAt _m_index;

GVAR(allMarkers) deleteAt _m_index;

["DEL", [name _player, _paramsOut]] call FUNC(log);