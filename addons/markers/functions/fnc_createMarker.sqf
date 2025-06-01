#include "../script_component.hpp"

params ["_mark", "_Chan", "_Text", "_Pos", "_Type", "_Color", "_Dir", "_Scale", "_Name"];
 
PARAM_INVALID(_mark,"STRING")
PARAM_INVALID(_Chan,"STRING")
PARAM_INVALID(_Text,"STRING")
PARAM_INVALID(_Pos,"ARRAY")
PARAM_INVALID(_Type,"SCALAR")
PARAM_INVALID(_Color,"STRING")
PARAM_INVALID(_Dir,"SCALAR")
PARAM_INVALID(_Scale,"ARRAY") // CAN BE SCALAR
PARAM_INVALID(_Name,"STRING")
GVAR_ISNIL(allMarkers)
GVAR_ISNIL(allMarkersParams)
GVAR_ISNIL(cfgMarkerColorsNames)
GVAR_ISNIL(cfgMarkersNames)

private _params = _this;

GVAR(allMarkers) pushBack _mark;
GVAR(allMarkersParams) pushBack _params;

_mark = createMarkerLocal [_mark,_Pos];

_mark setMarkerColorLocal (GVAR(cfgMarkerColorsNames) select _Color);
_mark setMarkerDirLocal _Dir;

if (_Type == -2) then {
	_mark setMarkerSizeLocal [_Scale select 0,_Scale select 1];
	_mark setMarkerBrushLocal "Solid";
	_mark setMarkerShapeLocal "RECTANGLE";
} else {
	if (_Type == -3) then {
		_mark setMarkerSizeLocal [_Scale select 0,_Scale select 1];
		_mark setMarkerBrushLocal "Solid";
		_mark setMarkerShapeLocal "ELLIPSE";
	} else {
		_mark setMarkerTypeLocal (GVAR(cfgMarkersNames) select _Type);
		_mark setMarkerShapeLocal "ICON";
		_mark setMarkerTextLocal _Text;
		_mark setMarkerSizeLocal [_Scale,_Scale];
	};
};
_mark call FUNC(dimMarkersFromOtherChannels);