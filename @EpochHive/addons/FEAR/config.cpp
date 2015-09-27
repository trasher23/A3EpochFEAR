class CfgPatches {
	class FEAR {
		units[] = {};
		weapons[] = {};
		requiredVersion = 1.0;
		FEARVersion = "1.0";
		requiredAddons[] = {"a3_epoch_code","a3_epoch_server"};
	};
};

class CfgFunctions {
	class FEAR {
		class FEAR_Server {
			file = "FEAR";
				class FEAR_init {
					preInit = 1;
				};
			};
	};
};
