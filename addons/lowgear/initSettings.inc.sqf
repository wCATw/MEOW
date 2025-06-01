private _category = localize LSTRING(Settings_Category);

[
    QGVAR(speedLand), "SLIDER", localize LSTRING(max_speed_on_land), _category,
    [10, 40, 20, 0], true, {}
] call CBA_fnc_addSetting;

[
    QGVAR(speedWater), "SLIDER", localize LSTRING(max_speed_on_water), _category,
    [10, 40, 20, 0], true, {}
] call CBA_fnc_addSetting;

[
    QGVAR(speedLimitMultiplier), "SLIDER", localize LSTRING(speed_limit_multiplier), _category,
    [1, 5, 1.5, 1], true, {}
] call CBA_fnc_addSetting;

[
    QGVAR(fuelConsumption), "SLIDER", localize LSTRING(fuel_consumption), _category,
    [0, 0.1, 0.05, 3], true, {}
] call CBA_fnc_addSetting;

[
    QGVAR(displayIcon), "CHECKBOX", localize LSTRING(display_icon), _category,
    true, false, {}
] call CBA_fnc_addSetting;