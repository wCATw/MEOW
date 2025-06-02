#include "../script_component.hpp"
	/*
		Function: fnc_dimMarkersFromOtherChannels

			Description:
				Adjusts the alpha (transparency) of markers that are not on the current channel or are considered old, to visually dim them in the UI.

			Arguments:
				_mrk   <String>  - The marker name to dim, or empty/undefined to process all markers.
				Global:
					dimNonActiveChannels      <Any>   - Controls dimming of non-active channels (read)
					dimNonActiveChannelsAlpha <Any>   - Alpha value for dimmed non-active channels (read)
					dimOldMarkers             <Any>   - Controls dimming of old markers (read)
					dimOldMarkersAlpha        <Any>   - Alpha value for dimmed old markers (read)
					dimOldMarkersTime         <Any>   - Time threshold for old markers (read)
					timedimOnlyRedBlueGreen   <Any>   - Restricts dimming to certain colors (read)
					notdimLoadedMarkers       <Any>   - Controls dimming of loaded markers (read)
					allMarkers                <Array> - Global array of all marker names (read/set)
					allMarkersParams          <Array> - Global array of all marker parameters (read/set)
					wmaptools_frzState        <Any>   - Mission freeze state (read)

			Returns:
				none
				Global:
					allMarkersParams <Array> - May be updated with marker timestamps (set)

			Variables:
				_swt_to_arma_channel      <Array>   - Mapping of SWT to Arma channel codes.
				_currentChannel           <String>  - The current channel code.
				_setMrkAlpha              <Code>    - Function to set marker alpha based on channel and age.
				_mrk                      <String>  - Marker name.
				_mindex                   <Number>  - Index of the marker in the global array.
				_mparams                  <Array>   - Marker parameters array.
	*/

GVAR_ISNIL(dimNonActiveChannels)
GVAR_ISNIL(dimNonActiveChannelsAlpha)
GVAR_ISNIL(dimOldMarkers)
GVAR_ISNIL(dimOldMarkersAlpha)
GVAR_ISNIL(dimOldMarkersTime)
GVAR_ISNIL(timedimOnlyRedBlueGreen)
GVAR_ISNIL(notdimLoadedMarkers)
GVAR_ISNIL(allMarkers)
GVAR_ISNIL(allMarkersParams)
EGVAR_ISNIL(wmaptools,frzState)

private _swt_to_arma_channel = ["GL","S","C","GR","V","D"];
private _currentChannel = _swt_to_arma_channel # currentChannel;

// Helper: sets marker alpha based on channel and age
private _setMrkAlpha = {
	params [
		'_mrk',
		'_mrk_chan',
		'_cur_chan',
		['_ctime',-1],
		['_loaded', false]
	];
	private _mrk_alpha = 1;
	// Dim if not on current channel
	if (
		GVAR(dimNonActiveChannels)
		&& {
			_mrk_chan isNotEqualTo _cur_chan
		}
	) then {
		_mrk_alpha = _mrk_alpha min GVAR(dimNonActiveChannelsAlpha);
	};
	// Dim if marker is old and meets conditions
	if (
		GVAR(dimOldMarkers)
		&& {time > 0}
		&& {
			(
				missionNamespace getVariable [QEGVAR(wmaptools,frzState),3]
			) >= 3
		}
		&& {
			(
				!GVAR(timedimOnlyRedBlueGreen)
				|| {
					getMarkerColor _mrk in ["ColorRed","ColorGreen","ColorBlue"]
				}
			)
			&& {
				!GVAR(notdimLoadedMarkers)
				|| {!_loaded}
			}
			&& {
				_ctime isNotEqualTo -1
			}
			&& {
				((CBA_missionTime - _ctime) / 60) > GVAR(dimOldMarkersTime)
			}
		}
	) then {
		_mrk_alpha = _mrk_alpha min GVAR(dimOldMarkersAlpha);
	};
	_mrk setMarkerAlphaLocal _mrk_alpha;
};

params ["_mrk"];

// If no marker specified, process all markers
if (
	isNil{_mrk}
	|| {
		_mrk isEqualTo ""
	}
	|| {
		!(_mrk isEqualType "")
	}
) then {
	{
		// Ensure marker params have timestamp
		if (count _x < 12) then {
			_x set [11, CBA_missionTime];
		};
		// Dim marker based on channel/age
		[
			_x#0,
			_x#1,
			_currentChannel,
			_x#11,
			_x#10
		] call _setMrkAlpha;
	} forEach GVAR(allMarkersParams);
} else {
	private ["_mindex", "_mparams"];
	// Find marker index
	_mindex = GVAR(allMarkers) find _mrk;
	if (_mindex isEqualTo -1) exitWith {};
	// Dim only the specified marker
	_mparams = GVAR(allMarkersParams) # _mindex;
	[
		_mrk,
		_mparams#1,
		_currentChannel,
		_mparams#11,
		_mparams#10
	] call _setMrkAlpha;
};
