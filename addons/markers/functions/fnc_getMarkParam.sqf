#include "../script_component.hpp"
/*
    Function: fnc_getMarkParam

        Description:
            Retrieves all relevant parameters for a given marker and returns them as an array.

        Arguments:
            _mark   <String>  - The marker name.

        Returns:
            <Array> - Array containing the marker name and an array of its type, color, position, text, direction, size, and alpha.

        Variables:
            _mark         <String>  - Marker name.
            _markerType   <String>  - Marker type.
            _markerColor  <String>  - Marker color.
            _markerPos    <Array>   - Marker position.
            _markerText   <String>  - Marker text.
            _markerDir    <Number>  - Marker direction.
            _markerSize   <Array>   - Marker size.
            _markerAlpha  <Number>  - Marker alpha.
*/



params ["_mark"];

PARAM_INVALID(_mark,"STRING")

private ["_markerType", "_markerColor", "_markerPos", "_markerText", "_markerDir", "_markerSize", "_markerAlpha"];

_markerType  = markerType _mark;
_markerColor = markerColor _mark;
_markerPos   = markerPos _mark;
_markerText  = markerText _mark;
_markerDir   = markerDir _mark;
_markerSize  = markerSize _mark;
_markerAlpha = markerAlpha _mark;

[_mark,[_markerType,_markerColor,_markerPos,_markerText,_markerDir,_markerSize,_markerAlpha]];