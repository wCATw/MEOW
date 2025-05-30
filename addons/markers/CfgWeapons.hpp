class CfgWeapons
{
	class ItemGPS;
	class GVAR(ItemSGPS): ItemGPS
	{
		displayName=CSTRING(SIMPLEGPS_DISPLAYNAME);
		picture=QPATHTOF(pictures\gear_item_simplegps_ca.paa);
		descriptionShort=CSTRING(SIMPLEGPS_DESCRIPTIONSHORT);
	};
};