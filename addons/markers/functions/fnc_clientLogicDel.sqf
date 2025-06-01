#include "../script_component.hpp"
/*
    Function: fnc_clientLogicDel

        Description:
            Deletes a marker for a client and logs the deletion.

        Arguments:
            _mark     <String>  - Marker name to delete.
            _player   <Object>  - Player requesting the deletion.

        Returns:
            none

        Variables:
            _m_index    <Number>  - Index of the marker in the global array.
            _paramsOut  <Array>   - Marker parameters array.
*/



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