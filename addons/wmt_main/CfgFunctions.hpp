class CfgFunctions {
	class ADDON {
		file = "\z\meow\addons\wmt_main\functions";

		class Init {
			file = "\z\meow\addons\wmt_main\functions\init";

			class preInit {
				preInit = 1;
				postInit = 0;
			};

			class postInit {
				preInit = 0;
				postInit = 1;
			};
		};

		class announcement {};
	};
};