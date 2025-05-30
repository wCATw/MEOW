#include "../script_component.hpp"

params ["_player", "_mark"];

TRACE_2("called logicServerRegMark with params:",_player,_mark);

private ["_channel", "_cond", "_units"];

private _fnc_areFriendly = {
	params ["_sideA","_sideB"];

	if (_sideA in [civilian,sideLogic] || _sideB in [civilian,sideLogic]) then {
		true;
	} else {
		private ["_conflictLimit"];
		_conflictLimit = 0.6;

		[false, true] select (_sideA getFriend _sideB >= _conflictLimit && _sideB getFriend _sideA >= _conflictLimit);
	};
};

private _addToChannel = { 
	params ["_channelData", "_channelUnit", "_mark"];

	_channelData = missionNamespace getVariable (DOUBLES(GVAR(logicServer),_channelData));
	if (_channelData find _channelUnit == -1) then {
		_channelData pushBack _channelUnit;
		_channelData pushBack [_mark];
	} else {
		(_channelData select ((_channelData find _channelUnit) + 1)) pushBack _mark;
	};
};

_channel = _mark select 1;
_mark pushBack (dayTime - GVAR(daytime)) * 3600;
GVAR(count) = GVAR(count) + 1;
_mark set [0, "SWT_M#"+ str GVAR(count)]; // BAD
_mark set [10, false];
_mark set [11, CBA_missionTime]; // changetime
GVAR(sendMark) = _mark;
_cond = "";
_units = [];
///////////////////////
// OCAP
[QFUNC(createMarker), [_player, GVAR(sendMark)]] call CBA_fnc_localEvent;
///////////////////////
switch (_channel) do {
	// side channel
	case "S": {
		_cond = "(side _x == side _player)";
		[_channel, side _player, _mark] call _addToChannel;
		_units = (playableUnits+switchableUnits);
	};
	// command channel
	case "C": {
		_cond = "((((leader _x == _x) or (((effectiveCommander (vehicle _x)) == _x) and (vehicle _x != _x))) and (side _x == side _player)) or (_player == _x))";
		[_channel, side _player, _mark] call _addToChannel;
		_units = (playableUnits+switchableUnits);
	};
	// global channel
	case "GL": {
		_cond = "true";
		GVAR(logicServer_GL) pushBack _mark;
		_units = (playableUnits+switchableUnits);
	};
	// vehicle channel
	case "V": {
		_cond = "(_x in vehicle _player)";
		[_channel, vehicle _player, _mark] call _addToChannel;
		_units = (playableUnits+switchableUnits);
	};
	// group channel
	case "GR": {
		_cond = "((group _x == group _player) || (GVAR(groupMarkersViaRadio) > 0 && {(side _x isEqualTo side _player) && {([_player, _x] call FUNC(listenSameTFRadio))}}))";
		[_channel, group _player, _mark] call _addToChannel;
		_units = if (GVAR(groupMarkersViaRadio) > 0) then {playableUnits+switchableUnits} else {units group _player};
	};
	// direct channel
	case "D": {
		_cond = "(_x distance _player < 15)";
		_units = (playableUnits+switchableUnits);
	};
};

{
	if (isPlayer _x or {time==0 and {_player in GVAR(isPlayerBug)}}) then {
		private _cond_x = call compile _cond;
		if _cond_x then {
			(owner _x) publicVariableClient QGVAR(sendMark);
			if (!isMultiplayer and {_x == player}) then {GVAR(sendMark) call FUNC(clientLogicCreate)};
		};
	};
} forEach _units;