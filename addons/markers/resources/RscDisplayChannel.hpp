class RscDisplayChannel {
	#pragma hemtt suppress pw3_padded_arg
	onLoad = QUOTE(\
	_this spawn { \
		params ['_control']; \
		GVAR(channel) = ctrlText(_control displayCtrl 101); \
	}; \
	[ARR_2('GVAR(channelChanged)',[])] call CBA_fnc_localEvent; \
	);
};