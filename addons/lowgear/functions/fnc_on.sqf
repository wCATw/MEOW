#include "../script_component.hpp"

params [];

if (!([] call FUNC(canEnable)) || GVAR(ripLowGearActionInUse)) exitWith {};

cutText [localize LSTRING(ON), "PLAIN DOWN"];
if (GVAR(displayIcon)) then {
	(QGVAR(Rsc) call BIS_fnc_rscLayer) cutRsc ["RscLowGearIcon", "PLAIN NOFADE", -1, false, false];
};

playSound3D ["\x\meow\addons\lowgear\sounds\gear.ogg", vehicle player, false, getPosASL vehicle player, 2, 1, 50];

GVAR(ripLowGearActionInUse) = true;
	if (!isNil QGVAR(ripLowGearAction)) then {
		player setUserActionText [
		GVAR(ripLowGearAction),
		format [
			"<img image='\x\meow\addons\lowgear\UI\car_gear.paa'/><t color='#baa71c'>%1</t>",
			localize LSTRING(ACTION_OFF)
		]
	];
};

GVAR(prevtime) = diag_tickTime - 1/diag_fps;
GVAR(fuel_timer) = 0;

[{
    params ["_args", "_idPFH"];
    _args params ["_driver", "_veh"];
	
	private _dt = diag_tickTime - GVAR(prevtime);
	GVAR(prevtime) = diag_tickTime;
		
    if (!GVAR(ripLowGearActionInUse) || !([] call FUNC(canEnable))) exitWith {
		GVAR(ripLowGearActionInUse) = false;
		if (!isNil QGVAR(ripLowGearAction)) then {
			_driver setUserActionText [
				GVAR(ripLowGearAction),
				format [
					"<img image='\x\meow\addons\lowgear\UI\car_gear.paa'/><t color='#baa71c'>%1</t>",
					localize LSTRING(ACTION_ON)
				]
			];
		};
		if (GVAR(displayIcon)) then {
			(QGVAR(Rsc) call BIS_fnc_rscLayer) cutText ["", "PLAIN"];
		};	
        [_idPFH] call CBA_fnc_removePerFrameHandler;
    };


	
	private _isWater = surfaceIsWater position _veh; 
	private _isTouch = isTouchingGround _veh;
	private _absSpeed = abs(speed _veh);
	private _realMax = [meow_lowgear_speedLand, meow_lowgear_speedWater] select (_isWater);
	private _dv = (3 * _dt); 
	private _v = (vectorNormalized vectorDir _veh) vectorMultiply _dv;
	
	
	switch true do {
		case(speed _veh >= 0 && {isEngineOn _veh} && {speed _veh < _realMax} && {inputAction "CarForward" > 0} && { _isWater || _absSpeed < 5 || _isTouch }) : {
			private _newvel = ((velocity _veh) vectorAdd _v); 
			_newvel set [2, 5 min _newvel#2];
			_veh setVelocity (_newvel); 
		};
		case (speed _veh <= 0 && {isEngineOn _veh} && {_absSpeed < _realMax} && {inputAction "CarBack" > 0} && { _isWater || _absSpeed < 5 || _isTouch }): {
			private _newvel = ((velocity _veh) vectorAdd (_v vectorMultiply -1)); 
			_newvel set [2, 5 min _newvel#2];
			_veh setVelocity (_newvel); 
		};
		case (_absSpeed > _realMax * GVAR(speedLimitMultiplier) && { _isWater || _isTouch }):{
			private _magn = vectorMagnitude velocity _veh;
			private _newvel = ((velocity _veh) vectorMultiply ( _magn/(_magn + _dv)));
			_veh setVelocity (_newvel); 
		};

	};
	
	
	if (isEngineOn _veh && {abs(speed _veh) >= 3}) then {
		GVAR(fuel_timer) = GVAR(fuel_timer) + _dt;
	
		if (GVAR(fuelConsumption) > 0.001 && GVAR(fuel_timer) >= 5) then {
			GVAR(fuel_timer) = GVAR(fuel_timer) - 5;
			_veh setFuel ( fuel _veh - GVAR(fuelConsumption) * 5 / 60 );
		};
	};
	
}, 0, [player, vehicle player]] call CBA_fnc_addPerFrameHandler;


