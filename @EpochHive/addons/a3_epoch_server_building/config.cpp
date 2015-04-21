class CfgPatches {
	class A3_epoch_building {
		units[] = {};
		weapons[] = {};
		requiredVersion = 0.1;
		requiredAddons[] = {"A3_server_settings"};
	};
};
class CfgFunctions {
	class building {
		class main {
			file = "x\addons\a3_epoch_server_building\init";
			class init {
				postInit = 1;
			};
		};
	};
};