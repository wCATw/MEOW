#include "../script_component.hpp"

params ["_display", "_dikCode", "_shift", "_ctrlKey", "_alt"];

PARAM_INVALID(_display,"DISPLAY")
PARAM_INVALID(_dikCode,"NUMBER")
PARAM_INVALID(_shift,"BOOL")
PARAM_INVALID(_ctrlKey,"BOOL")
PARAM_INVALID(_alt,"BOOL")
GVAR_ISNIL(lineParamsWorld)
GVAR_ISNIL(posM)
GVAR_ISNIL(allMarkers)
GVAR_ISNIL(disableLoc)
GVAR_ISNIL(changeMark)

if (!isNil {GVAR(lineParamsWorld)}) then {
	if ((_alt || _ctrlKey) && !(_alt && _ctrlKey)) then {
		_thickness = GVAR(lineParamsWorld) select 3;
		if (_alt) then {
			_thickness = _thickness + 5;
			if (_thickness <= 100) then {
				GVAR(lineParamsWorld) set [3, _thickness];
				"SWT_MARKERS LOCAL INFO" setMarkerTextLocal format [localize LSTRING(THICKNESS), _thickness];
			};
		} else {
			if (_ctrlKey) then {
				_thickness = _thickness - 5;
				if (_thickness >= 5) then {
					GVAR(lineParamsWorld) set [3, _thickness];
					"SWT_MARKERS LOCAL INFO" setMarkerTextLocal format [localize LSTRING(THICKNESS), _thickness];
				};
			};
		};
		"SWT_MARKERS LOCAL LINE" setMarkerSizeLocal [GVAR(lineParamsWorld) select 3,(((GVAR(lineParamsWorld) select 0) distance (GVAR(lineParamsWorld) select 1)))/2];
		true
	};
} else {
	if (_dikCode == DIK_DELETE) then {
		if (GVAR(disableLoc)) exitWith {diag_log "SWT MARKERS: DEL DISABLED";};
		{
			private _pos = getMarkerPos _x;
			_pos = (_display displayCtrl 51) ctrlMapWorldToScreen _pos;
			if (([_pos,GVAR(posM)] call BIS_fnc_distance2D) < 0.025) exitWith { // MEOW
				GVAR(changeMark)  = ["DEL", player, _x, _x call FUNC(getChannel)];
				if (!isMultiplayer) then {GVAR(changeMark) call FUNC(logicServerChangeMark)};
				publicVariableServer QGVAR(changeMark);
			};
		} forEach GVAR(allMarkers);
	};
	false
};