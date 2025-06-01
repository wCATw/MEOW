#include "../script_component.hpp"

params ['_mark','_dir','_player','_ctime'];

PARAM_INVALID(_mark,"STRING")
PARAM_INVALID(_dir,"NUMBER")
PARAM_INVALID(_player,"OBJECT")
PARAM_INVALID(_ctime,"NUMBER")
GVAR_ISNIL(allMarkers)
GVAR_ISNIL(allMarkersParams)
GVAR_ISNIL(disableLoc)

if (GVAR(disableLoc)) exitWith {diag_log "SWT MARKERS: MARKERS DISABLED"};

private _mindex = GVAR(allMarkers) find _mark;

if (_mindex isEqualTo -1) exitWith {};

_mark setMarkerDirLocal _dir;
private _paramsOut = GVAR(allMarkersParams) # _mindex;
_paramsOut set [6,_dir];
_paramsOut set [11, _ctime];

_mark call FUNC(dimMarkersFromOtherChannels);
["DIR", [name _player, _paramsOut]] call FUNC(log);