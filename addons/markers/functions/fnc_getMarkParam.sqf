#include "../script_component.hpp"

params ["_mark"];

TRACE_1("called getMarkParam with params:",_mark);

private ["_markerType", "_markerColor", "_markerPos", "_markerText", "_markerDir", "_markerSize", "_markerAlpha"];

_markerType  = markerType _mark;
_markerColor = markerColor _mark;
_markerPos   = markerPos _mark;
_markerText  = markerText _mark;
_markerDir   = markerDir _mark;
_markerSize  = markerSize _mark;
_markerAlpha = markerAlpha _mark;

[_mark,[_markerType,_markerColor,_markerPos,_markerText,_markerDir,_markerSize,_markerAlpha]];