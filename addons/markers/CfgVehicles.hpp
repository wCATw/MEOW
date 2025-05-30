class CfgVehicles
{
	class Logic;
	class Module_F;
	class GVAR(disableModule): Module_F
	{
		scope=2;
		author="swatSTEAM";
		displayName=CSTRING(MODULE_BRIEF);
		category=QUOTE(ADDON);
		function=QFUNC(disableModule);
		functionPriority=1;
		isGlobal=2;
		isTriggerActivated=0;
	};
	class GVAR(paramsModule): Module_F
	{
		scope=2;
		author="swatSTEAM";
		displayName=CSTRING(MODULE_CONF);
		category=QUOTE(ADDON);
		function=QFUNC(paramsModule);
		functionPriority=1;
		isGlobal=2;
		isTriggerActivated=0;
		class Arguments
		{
			class Loads
			{
				displayName=CSTRING(MODULE_LOAD);
				description=CSTRING(MODULE_LOAD_T);
				typeName="BOOL";
				class values
				{
					class On
					{
						name="On";
						value="true";
						default=1;
					};
					class Off
					{
						name="Off";
						value="false";
					};
				};
			};
			class Loads_for
			{
				displayName=CSTRING(MODULE_LOAD_FOR);
				description=CSTRING(MODULE_LOAD_FOR_T);
				typeName="BOOL";
				class values
				{
					class On
					{
						name=CSTRING(MODULE_LOAD_FOR_LEAD);
						value="true";
						default=1;
					};
					class Off
					{
						name=CSTRING(MODULE_LOAD_FOR_ALL);
						value="false";
					};
				};
			};
			class Loads_brif
			{
				displayName=CSTRING(MODULE_LOAD_WHEN);
				description=CSTRING(MODULE_LOAD_WHEN);
				typeName="BOOL";
				class values
				{
					class On
					{
						name=CSTRING(MODULE_LOAD_WHEN_A);
						value="true";
						default=1;
					};
					class Off
					{
						name=CSTRING(MODULE_LOAD_WHEN_BRIEF);
						value="false";
					};
				};
			};
		};
	};
};