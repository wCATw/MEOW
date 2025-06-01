#include "../script_component.hpp"

params ["_ctrl", "_action", "_changeState"];

PARAM_INVALID(_ctrl,"CONTROL")
PARAM_INVALID(_action,"STRING")
PARAM_INVALID(_changeState,"BOOL")
GVAR_ISNIL(fastTextN)
GVAR_ISNIL(fastTextG)
GVAR_ISNIL(fastTextT)

ctrlSetFocus ((ctrlParent _ctrl) displayCtrl IDC_TEXT);
switch (_action) do {
	case "N": {
		if (isNil {_changeState}) then {
			GVAR(fastTextN) = !GVAR(fastTextN);
		};
		if (GVAR(fastTextN)) then {
			_ctrl ctrlSetTextColor [IDC_ADV_CB_LOG/255,176/255,74/255,1];
		} else {
			_ctrl ctrlSetTextColor [1,1,1,0.5];
		};
	};

	case "G": {
		if (isNil {_changeState}) then {
			GVAR(fastTextG) = !GVAR(fastTextG);
		};
		if (GVAR(fastTextG)) then {
			_ctrl ctrlSetTextColor [IDC_ADV_CB_LOG/255,176/255,74/255,1];
		} else {
			_ctrl ctrlSetTextColor [1,1,1,0.5];
		};
	};

	case "T": {
		if (isNil {_changeState}) then {
			GVAR(fastTextT) = !GVAR(fastTextT);
		};
		if (GVAR(fastTextT)) then {
			_ctrl ctrlSetTextColor [IDC_ADV_CB_LOG/255,176/255,74/255,1];
		} else {
			_ctrl ctrlSetTextColor [1,1,1,0.5];
		};
	};
};