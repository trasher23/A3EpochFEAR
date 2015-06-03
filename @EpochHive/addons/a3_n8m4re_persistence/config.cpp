class CfgPatches {
	class a3_n8m4re_persistence {
		units[] = {};
		weapons[] = {};
		requiredVersion = 0.1;
		requiredAddons[] = {"A3_epoch_server","A3_epoch_config","A3_server_settings"};
	};
};

class CfgFunctions {
	class a3_n8m4re_persistence {
		class persistence_main {	
			file = "\x\addons\a3_n8m4re_persistence\init";
			class init {preInit = 1;};
			class postinit {postInit = 1;};
		};
	};
};

class CfgPersistence {
	PersistenceTablePrefix = "PERSIST"; // change will create a new table in db
	PersistenceHolderExpires = 172800; 	// 1day=86400, 2days=172800, 4days=345600, 8days=691200 
	PersistenceHolderLimit = 5000; 		// max. groundholder limit to store
	PersistenceMines = true;			// enable/disable storing of mines
	PersistenceMinesLimit = 10; 		// max. mines limit per player  
};