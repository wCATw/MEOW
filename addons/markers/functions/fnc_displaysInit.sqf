#include "../script_component.hpp"

private _addHandlers = {
    params ["_mapDisplay"];

    TRACE_1("called _addHandlers in displaysInit with params:",_mapDisplay);

    _control = _mapDisplay displayCtrl 51;
    
    _id0 = _control ctrlAddEventHandler ["MouseButtonDblClick", {_this spawn FUNC(mapButtonDblClick)}];
    _id1 = _control ctrlAddEventHandler ["MouseButtonDown", {_this call FUNC(mapMouseDown);}];
    _id2 = _control ctrlAddEventHandler ["MouseButtonUp", {_this call FUNC(mapMouseUp);}];
    _id3 = _mapDisplay displayAddEventHandler ["KeyDown", {_this call FUNC(mapKeyDown);}];
    _id4 = _control ctrlAddEventHandler ["MouseMoving", {_this call FUNC(mapMouseMoving);}];
    _id5 = _control ctrlAddEventHandler ["MouseHolding", {_this call FUNC(mapMouseHold);}];
    
    _control ctrlAddEventHandler ["KeyDown", {
        params ["_dispCtrl", "_key", "_shift", "_ctrl", "_alt"];
        if (GVAR(limitSideMarkers) isNotEqualTo 0) then {
            (_key == DIK_LMENU && _ctrl || _key == DIK_LCONTROL && _alt) || _key in [DIK_LCONTROL,DIK_LMENU] && currentChannel == 1 && {!(0 call FUNC(checkSideChannel))}
        } else {
            false
        };
    }];

    
    _ctrl = _mapDisplay ctrlCreate ["RscStructuredText", IDC_BUTTON_ADV];
    _ctrl ctrlShow false;
    _ctrl ctrlSetBackgroundColor [0,0,0,0.7];
    _ctrl ctrlSetPosition [0, 0, 10.8*GR_W, 3.5*GR_H];
    _ctrl ctrlCommit 0;
};

waitUntil {(!isNull (findDisplay 12)) or (!isNull (findDisplay 37)) or (!isNull (findDisplay 52)) or (!isNull (findDisplay 53))};
_mapDisplay = (
    {
        if !(isNull (findDisplay _x)) exitWith {findDisplay _x;}
    } forEach [37,52,53,12]
);
if (_mapDisplay == (findDisplay 12)) then {
    [_mapDisplay] call _addHandlers;
} else {
    [_mapDisplay] call _addHandlers;
    sleep 1;
    waitUntil {(!isNull (findDisplay 12))};
    [(findDisplay 12)] call _addHandlers;
};