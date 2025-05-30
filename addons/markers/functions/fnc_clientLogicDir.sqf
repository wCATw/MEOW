#include "../script_component.hpp"

params ['_mark','_dir','_player','_ctime'];

TRACE_4("called clientLogicDir with params:",_mark,_dir,_player,_ctime);

if (GVAR(disableLoc)) exitWith {diag_log "SWT MARKERS: MARKERS DISABLED"};

private _mindex = GVAR(allMarkers) find _mark;

if (_mindex isEqualTo -1) exitWith {};

_mark setMarkerDirLocal _dir;
private _paramsOut = GVAR(allMarkersParams) # _mindex;
_paramsOut set [6,_dir];
_paramsOut set [11, _ctime];

_mark call FUNC(dimMarkersFromOtherChannels);
["DIR", [name _player, _paramsOut]] call FUNC(log);