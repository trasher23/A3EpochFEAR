class CfgPatches {
	class FEAR {
		units[] = {};
		weapons[] = {};
		requiredVersion = 0.1;
		A3EAIVersion = "0.1.1 Alpha";
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