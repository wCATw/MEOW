class CfgVehicles {
    class Items_base_F;

    class WMO_roadway_obj : Items_base_F {
        scope = 2;
        author = "Bloodwyn";
        model = QPATHTOF(models\rw.p3d);
        displayName = CSTRING(Inivisible Roadway LOD for the adaptive roadway);
        vehicleClass = "Objects";
        armor = 20000;
        icon = "iconObject";
        mapSize = 0.7;
        accuracy = 0.2;
    };

    class WMO_roadway_obj_debug : Items_base_F {
        scope = 2;
        author = "Bloodwyn";
        model = QPATHTOF(models\rw_debug.p3d);
        displayName = CSTRING(Inivisible Roadway LOD for the adaptive roadway);
        vehicleClass = "Objects";
        armor = 20000;
        icon = "iconObject";
        mapSize = 0.7;
        accuracy = 0.2;
    };
};
