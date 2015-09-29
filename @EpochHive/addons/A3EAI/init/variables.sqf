//Set internal-use variables
A3EAI_unitLevels = [0,1,2,3];								
A3EAI_unitLevelsAll = A3EAI_unitLevels;				
A3EAI_curHeliPatrols = 0;									//Current number of active air patrols
A3EAI_curLandPatrols = 0;									//Current number of active land patrols
A3EAI_curUAVPatrols = 0;
A3EAI_curUGVPatrols = 0;
A3EAI_dynTriggerArray = [];									//List of all generated dynamic triggers.
A3EAI_staticTriggerArray = [];								//List of all static triggers
A3EAI_respawnQueue = [];									//Queue of AI groups that require respawning. Group ID is removed from queue after it is respawned.
A3EAI_areaBlacklists = [];									//Queue of temporary dynamic spawn area blacklists for deletion
A3EAI_checkedClassnames = [[],[],[]];						//Classnames verified - Weapons/Magazines/Vehicles
A3EAI_invalidClassnames = [[],[],[]];						//Classnames known as invalid - Weapons/Magazines/Vehicles
A3EAI_respawnTimeVariance = (abs (A3EAI_respawnTimeMax - A3EAI_respawnTimeMin));
A3EAI_respawnTimeVarAir = (abs (A3EAI_respawnAirMaxTime - A3EAI_respawnAirMinTime));
A3EAI_respawnTimeVarLand = (abs (A3EAI_respawnLandMaxTime - A3EAI_respawnLandMaxTime));
A3EAI_monitoredObjects = []; //used to cleanup AI vehicles that may not be destroyed.
A3EAI_activeGroups = [];
A3EAI_locations = [];
A3EAI_locationsAir = [];
A3EAI_locationsLand = [];
A3EAI_heliTypesUsable = [];
A3EAI_vehTypesUsable = [];
A3EAI_UAVTypesUsable = [];
A3EAI_UGVTypesUsable = [];
A3EAI_randTriggerArray = [];
A3EAI_mapMarkerArray = [];
A3EAI_weaponTypeIndices0 = [];
A3EAI_weaponTypeIndices1 = [];
A3EAI_weaponTypeIndices2 = [];
A3EAI_weaponTypeIndices3 = [];
A3EAI_failedDynamicSpawns = [];
A3EAI_HCObject = objNull;
A3EAI_HCIsConnected = false;
A3EAI_HCObjectOwnerID = 0;
A3EAI_activeGroupAmount = 0;
A3EAI_staticInfantrySpawnQueue = [];
A3EAI_customBlacklistQueue = [];
A3EAI_customInfantrySpawnQueue = [];
A3EAI_createCustomSpawnQueue = [];
A3EAI_customVehicleSpawnQueue = [];
A3EAI_randomInfantrySpawnQueue = [];
A3EAI_activeReinforcements = [];
A3EAI_reinforcedPositions = [];
A3EAI_spawnChanceMultiplier = 1;
A3EAI_HCAllowedTypes = ["static", "dynamic", "random", "air", "land", "staticcustom", "aircustom", "landcustom", "vehiclecrew", "air_reinforce", "uav", "ugv"];
A3EAI_lastGroupTransfer = 0;
A3EAI_automatedUnitTypes = ["uav","ugv"];
A3EAI_kryptoAreas = [];
A3EAI_kryptoObjects = [];
A3EAI_noAggroAreas = [];
