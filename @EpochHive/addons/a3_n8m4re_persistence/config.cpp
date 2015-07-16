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
		class a3_n8m4re_persistence_init {	
			file = "\x\addons\a3_n8m4re_persistence";
			class init {preInit = 1;};
			class postinit {postInit = 1;};
		};
	};
};

class CfgPersistence {
	PersistenceTablePrefix = "PERSIST"; 	// change will create a new table in db
		
	PersistenceHolder = true; 				// enable/disable storing of groundholder items
	PersistenceHolderCanExpire = true; 		// enable/disable expiring of holders
	PersistenceHolderExpires = "172800"; 	// 1day=86400, 2days=172800, 4days=345600, 8days=691200 
	PersistenceHolderLimit = 1500; 			// max groundholder can stored (a groundholder can hold more than one item)
	
	
	PersistenceMines = true;				// enable/disable storing of mines
	PersistenceMinesCanExpire = true;		// enable/disable expiring of mines
	PersistenceMinesExpires = "172800";		// 1day=86400, 2days=172800, 4days=345600, 8days=691200 
	PersistenceMinesLimit = 10; 			// max mines can stored per player 
	
	PersistenceDayTime = true;				// enable/disable storing of server daytime (StaticDateTime only)
};