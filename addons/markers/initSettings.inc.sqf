private _category = COMPONENT_NAME;

[
    QGVAR(groupMarkersViaRadio), "LIST",
    [localize LSTRING(SET_GROUP_MARKER)],
    _category,
    [[0,1,2],[localize LSTRING(SET_GROUP_MARKER_OPT0), localize LSTRING(SET_GROUP_MARKER_OPT1), localize LSTRING(SET_GROUP_MARKER_OPT2)],1],
    true,
    {},
    true
] call CBA_fnc_addSetting;

[
    QGVAR(dimNonActiveChannels), "CHECKBOX",
    [localize LSTRING(SET_DIM_CHANNELS)],
    _category,
    true,
    false,
    {},
    true
] call CBA_fnc_addSetting;

[
    QGVAR(dimNonActiveChannelsAlpha), "SLIDER",
    [localize LSTRING(SET_DIM_CHANNELS_ALPHA)],
    _category,
    [0, 1, 0.4, 2],
    false,
    {},
    true
] call CBA_fnc_addSetting;

[
    QGVAR(limitSideMarkers), "LIST",
    [localize LSTRING(SET_LIMIT_SIDE_MARKERS)],
    _category,
    [[0,1,2],[localize LSTRING(SET_LIMIT_SIDE_MARKERS_OPT0), localize LSTRING(SET_LIMIT_SIDE_MARKERS_OPT1), localize LSTRING(SET_LIMIT_SIDE_MARKERS_OPT2)],2],
    true,
    {},
    true
] call CBA_fnc_addSetting;

[
    QGVAR(dimOldMarkers), "CHECKBOX",
    [localize LSTRING(SET_DIM_OLD_MARKERS)],
    _category,
    true,
    false,
    {},
    true
] call CBA_fnc_addSetting;

[
    QGVAR(dimOldMarkersAlpha), "SLIDER",
    [localize LSTRING(SET_DIM_OLD_MARKERS_ALPHA)],
    _category,
    [0, 1, 0.2, 2],
    false,
    {},
    true
] call CBA_fnc_addSetting;

[
    QGVAR(dimOldMarkersTime), "SLIDER",
    [localize LSTRING(SET_DIM_OLD_MARKERS_TIME)],
    _category,
    [5, 180, 15, 0],
    false,
    {},
    true
] call CBA_fnc_addSetting;

[
    QGVAR(notdimLoadedMarkers), "CHECKBOX",
    [localize LSTRING(NOT_DIM_LOADED_MARKERS)],
    _category,
    true,
    false,
    {},
    true
] call CBA_fnc_addSetting;

[
    QGVAR(timedimOnlyRedBlueGreen), "CHECKBOX",
    [localize LSTRING(DIM_ONLY_RED_BLUE_GREEN)],
    _category,
    true,
    false,
    {},
    true
] call CBA_fnc_addSetting;
