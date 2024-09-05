#include "script_component.hpp"

// Exit on Headless
if (!hasInterface) exitWith {};

ISNILS(GVAR(enabled),true);
ISNILS(GVAR(specialObjects),[]);
ISNILS(GVAR(noRoadway),[]);

0 spawn {
    waitUntil {time > 1};
    if !(isNil "babe_em_fnc_walkonstuff")then{
        ["EH_em_walkonstuff"] call babe_core_fnc_removeEH;
        babe_em_help setPosASL [0,0,0];
    };
    GVAR(noRoadway) = GVAR(noRoadway) + ["NonSteerable_Parachute_F","Steerable_Parachute_F","B_Parachute_02_F","O_Parachute_02_F","I_Parachute_02_F"];
    if !(isNull (configFile >> "CfgPatches" >> "acex_sitting"))then{
        GVAR(noRoadway) = GVAR(noRoadway) + ["Land_OfficeChair_01_F","Land_ChairWood_F","Land_RattanChair_01_F","Land_CampingChair_V2_F","Land_CampingChair_V2_white_F","Land_ChairPlastic_F","Land_CampingChair_V1_F","Land_Bench_01_F","Land_Bench_02_F","Land_Bench_03_F","Land_Bench_04_F","Land_Bench_05_F"];
    };
    //["walkHandler","onEachFrame",FUNC(setPos)] call BIS_fnc_addStackedEventHandler;
    GVAR(MISSIONEVHID) = addMissionEventHandler ["EachFrame",FUNC(setPos)];
};
ISNILS(GVAR(enter),[]);
ISNILS(GVAR(exit),[]);

GVAR(help) = "BW_roadway_obj" createVehicleLocal [0,0,0];
GVAR(help) setMass 0;
GVAR(anker) = objNull;

GVAR(collision) = true;
GVAR(dmgEvh) = player addEventHandler ["HandleDamage", FUNC(handleDamage)];
