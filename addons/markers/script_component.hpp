#define COMPONENT markers
#define COMPONENT_BEAUTIFIED Markers
#include "\x\meow\addons\main\script_mod.hpp"

#define DEBUG_MODE_FULL
#define DISABLE_COMPILE_CACHE

#include "\x\meow\addons\main\script_macros.hpp"

#include "definesIDCs.hpp"

#define	COLOR_GLOBAL_CHANNEL [1,0,0,1]
#define	COLOR_SIDE_CHANNEL [0.196*1.4, 0.592*1.4, 0.706*1.4, 1]
#define	COLOR_COMMAND_CHANNEL [0.8275*1.4, 0.8196*1.4, 0.1961*1.4, 1]
#define	COLOR_GROUP_CHANNEL [208/255, 240/255, 192/255, 1]
#define	COLOR_VEHICLE_CHANNEL [0.863*1.4, 0.584*1.4, 0.0*1.4, 1]
#define	COLOR_DIRECT_CHANNEL [1, 1, 1, 1]
#define	COLOR_PLAYER_CHANNEL [0.8, 0.7, 1, 1]
#define GR_W (((safeZoneW/safeZoneH) min 1.2)/40)
#define GR_H ((((safeZoneW/safeZoneH) min 1.2)/1.2)/25)