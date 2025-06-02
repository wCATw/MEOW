#include "../script_component.hpp"
    /*
        Function: fnc_clientLogicDir

            Description:
                Updates the direction of a marker for a client and logs the change. Exits if location updates are disabled.

            Arguments:
                _mark     <String>  - Marker name.
                _dir      <Scalar>  - New marker direction.
                _player   <Object>  - Player making the change.
                _ctime    <Scalar>  - Change timestamp.
                Global:
                    allMarkers       <Array> - Global array of all marker names (read/set)
                    allMarkersParams <Array> - Global array of all marker parameters (read/set)
                    disableLoc       <Bool>  - If true, disables marker direction update (read)

            Returns:
                none
                Global:
                    allMarkersParams <Array> - Updated with new direction and timestamp (set)

            Variables:
                _mindex     <Number>  - Index of the marker in the global array.
                _paramsOut  <Array>   - Marker parameters array.
    */



params ['_mark','_dir','_player','_ctime'];

PARAM_INVALID(_mark,"STRING")
PARAM_INVALID(_dir,"SCALAR")
PARAM_INVALID(_player,"OBJECT")
PARAM_INVALID(_ctime,"SCALAR")
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