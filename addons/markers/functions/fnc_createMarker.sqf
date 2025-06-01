#include "../script_component.hpp"
/*
	Function: fnc_createMarker

		Description:
			Creates a new marker with the specified parameters and adds it to the global marker arrays. Handles different marker shapes and types.

		Arguments:
			_mark    <String>  - Marker name.
			_Chan    <String>  - Channel code.
			_Text    <String>  - Marker text.
			_Pos     <Array>   - Marker position.
			_Type    <Scalar>  - Marker type index.
			_Color   <Scalar>  - Marker color index (can be string).
			_Dir     <Scalar>  - Marker direction.
			_Scale   <Array>   - Marker scale (can be scalar).
			_Name    <String>  - Marker creator name.

		Returns:
			none

		Variables:
			_params   <Array>   - All marker parameters.
*/

params ["_mark", "_Chan", "_Text", "_Pos", "_Type", "_Color", "_Dir", "_Scale", "_Name"];
 
PARAM_INVALID(_mark,"STRING")
PARAM_INVALID(_Chan,"STRING")
PARAM_INVALID(_Text,"STRING")
PARAM_INVALID(_Pos,"ARRAY")
PARAM_INVALID(_Type,"SCALAR")
PARAM_INVALID(_Color,"SCALAR") // CAN BE STRING
PARAM_INVALID(_Dir,"SCALAR")
PARAM_INVALID(_Scale,"ARRAY") // CAN BE SCALAR
PARAM_INVALID(_Name,"STRING")
GVAR_ISNIL(allMarkers)
GVAR_ISNIL(allMarkersParams)
GVAR_ISNIL(cfgMarkerColorsNames)
GVAR_ISNIL(cfgMarkersNames)

private _params = _this;

// Add marker to global arrays
GVAR(allMarkers) pushBack _mark;
GVAR(allMarkersParams) pushBack _params;

// Create marker and set basic properties
_mark = createMarkerLocal [_mark,_Pos];
_mark setMarkerColorLocal (GVAR(cfgMarkerColorsNames) select _Color);
_mark setMarkerDirLocal _Dir;

// Handle marker shape/type
if (_Type == -2) then {
	// Rectangle marker
	_mark setMarkerSizeLocal [_Scale select 0,_Scale select 1];
	_mark setMarkerBrushLocal "Solid";
	_mark setMarkerShapeLocal "RECTANGLE";
} else {
	if (_Type == -3) then {
		// Ellipse marker
		_mark setMarkerSizeLocal [_Scale select 0,_Scale select 1];
		_mark setMarkerBrushLocal "Solid";
		_mark setMarkerShapeLocal "ELLIPSE";
	} else {
		// Icon marker
		_mark setMarkerTypeLocal (GVAR(cfgMarkersNames) select _Type);
		_mark setMarkerShapeLocal "ICON";
		_mark setMarkerTextLocal _Text;
		_mark setMarkerSizeLocal [_Scale,_Scale];
	};
};

// Update marker alpha for channel visibility
_mark call FUNC(dimMarkersFromOtherChannels);
