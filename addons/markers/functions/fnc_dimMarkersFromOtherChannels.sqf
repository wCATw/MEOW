#include "../script_component.hpp"

if (isNil {GVAR(dimNonActiveChannels)}) then { GVAR(dimNonActiveChannels) = false; };
if (isNil {GVAR(dimOldMarkers)}) then { GVAR(dimOldMarkers) = false; };
if (!GVAR(dimNonActiveChannels) && !GVAR(dimOldMarkers)) exitWith {};

private _swt_to_arma_channel = ["GL","S","C","GR","V","D"];
private _currentChannel = _swt_to_arma_channel # currentChannel;

private _setMrkAlpha = {
	params ['_mrk', '_mrk_chan','_cur_chan',['_ctime',-1],['_loaded', false]];
	private _mrk_alpha = 1;
	if (GVAR(dimNonActiveChannels) && {_mrk_chan isNotEqualTo _cur_chan}) then {
		_mrk_alpha = _mrk_alpha min GVAR(dimNonActiveChannelsAlpha);
	};

	if (GVAR(dimOldMarkers) && time > 0 && ((missionNamespace getVariable [QEGVAR(wmaptools,frzState),3]) >= 3) && {(!GVAR(timedimOnlyRedBlueGreen) || {getMarkerColor _mrk in ["ColorRed","ColorGreen","ColorBlue"]})&& {!GVAR(notdimLoadedMarkers) || !_loaded} && {_ctime isNotEqualTo -1} && {((CBA_missionTime - _ctime) / 60) > GVAR(dimOldMarkersTime)}}) then {
		_mrk_alpha = _mrk_alpha min GVAR(dimOldMarkersAlpha);
	};
	_mrk setMarkerAlphaLocal _mrk_alpha;
};

params ["_mrk"];

if (isNil{_mrk} || {_mrk isEqualTo ""} || {!(_mrk isEqualType "")} ) then {
	{
		if (count _x < 12) then {
			diag_log [QGVAR(dimMarkersFromOtherChannels),"BAD MARKER DATA", _x];
			_x set [11, CBA_missionTime];
		};
		[_x#0,_x#1, _currentChannel, _x#11,_x#10] call _setMrkAlpha ;
	} forEach GVAR(allMarkersParams);
} else {
	private ["_mindex", "_mparams"];

	_mindex = GVAR(allMarkers) find _mrk;
	
	if (_mindex isEqualTo -1) exitWith {};

	_mparams = GVAR(allMarkersParams) # _mindex;
	[_mrk,_mparams#1, _currentChannel, _mparams#11, _mparams#10] call _setMrkAlpha;
};