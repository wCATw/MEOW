private _category = COMPONENT_NAME;

[
    QGVAR(speedLand), "SLIDER", "Максимальная скорость на суше", _category,
    [10, 40, 20, 0], true, {}
] call CBA_fnc_addSetting;

[
    QGVAR(speedWater), "SLIDER", "Максимальная скорость на воде", _category,
    [10, 40, 20, 0], true, {}
] call CBA_fnc_addSetting;

[
    QGVAR(speedLimitMultiplier), "SLIDER", "Лимит скорости при включенной пониженой", _category,
    [1, 5, 1.5, 1], true, {}
] call CBA_fnc_addSetting;

[
    QGVAR(fuel_consumption), "SLIDER", "Дополнительное потребление топлива в мин", _category,
    [0, 0.1, 0.05, 3], true, {}
] call CBA_fnc_addSetting;

[
    QGVAR(displayIcon), "CHECKBOX", "Показывать значок при включении", _category,
    true, false, {}
] call CBA_fnc_addSetting;