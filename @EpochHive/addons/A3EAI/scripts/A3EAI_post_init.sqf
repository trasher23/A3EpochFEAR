/*
	A3EAI Startup
	
	Description: Handles post-initialization tasks

*/

if (A3EAI_debugLevel > 0) then {diag_log "A3EAI Debug: A3EAI Startup is running required script files..."};

//Set internal-use variables
A3EAI_unitLevels = [0,1,2,3];								
A3EAI_unitLevelsAll = A3EAI_unitLevels;				
A3EAI_curHeliPatrols = 0;									//Current number of active air patrols
A3EAI_curLandPatrols = 0;									//Current number of active land patrols
A3EAI_dynTriggerArray = [];									//List of all generated dynamic triggers.
A3EAI_staticTriggerArray = [];								//List of all static triggers
A3EAI_respawnQueue = [];									//Queue of AI groups that require respawning. Group ID is removed from queue after it is respawned.
A3EAI_areaBlacklists = [];									//Queue of temporary dynamic spawn area blacklists for deletion
A3EAI_reinforcePlaces = [];									//AI helicopter patrols will periodically check this array for dynamic trigger objects to use as reinforcement positions.
A3EAI_checkedClassnames = [[],[],[]];						//Classnames verified - Weapons/Magazines/Vehicles
A3EAI_invalidClassnames = [[],[],[]];						//Classnames known as invalid - Weapons/Magazines/Vehicles
A3EAI_respawnTimeVariance = (abs (A3EAI_respawnTimeMax - A3EAI_respawnTimeMin));
A3EAI_respawnTimeVarAir = (abs (A3EAI_respawnAirMaxTime - A3EAI_respawnAirMinTime));
A3EAI_respawnTimeVarLand = (abs (A3EAI_respawnLandMaxTime - A3EAI_respawnLandMaxTime));
A3EAI_monitoredObjects = []; //used to cleanup AI vehicles that may not be destroyed.
A3EAI_activeGroups = [];
A3EAI_locations = [];
A3EAI_locationsLand = [];
A3EAI_heliTypesUsable = [];
A3EAI_vehTypesUsable = [];
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
A3EAI_hiddenObjectsList = [];

if (A3EAI_enableHC) then {
	[] call compile preprocessFileLineNumbers format ["%1\init\A3EAI_ServerHC_functions.sqf",A3EAI_directory];
	[] call compile preprocessFileLineNumbers format ["%1\init\A3EAI_ServerHC_PVEH.sqf",A3EAI_directory];
	diag_log "[A3EAI] A3EAI is now listening for headless client connection.";
};

//Create default trigger object if AI is spawned without trigger object specified (ie: for custom vehicle AI groups)
_nul = [] spawn {
	A3EAI_defaultTrigger = createTrigger ["EmptyDetector",[configFile >> "CfgWorlds" >> worldName,"centerPosition",[0,0,0]] call BIS_fnc_returnConfigEntry];
	A3EAI_defaultTrigger enableSimulationGlobal false;
	A3EAI_defaultTrigger setVariable ["isCleaning",true];
	A3EAI_defaultTrigger setVariable ["patrolDist",100];
	A3EAI_defaultTrigger setVariable ["unitLevel",1];
	A3EAI_defaultTrigger setVariable ["unitLevelEffective",1];
	A3EAI_defaultTrigger setVariable ["locationArray",[]];
	A3EAI_defaultTrigger setVariable ["maxUnits",[0,0]];
	A3EAI_defaultTrigger setVariable ["GroupSize",0];
	A3EAI_defaultTrigger setVariable ["initialized",true];
	A3EAI_defaultTrigger setVariable ["spawnChance",0];
	A3EAI_defaultTrigger setVariable ["spawnType",""];
	A3EAI_defaultTrigger setTriggerText "Default Trigger Object";
	if (A3EAI_debugLevel > 1) then {diag_log format ["A3EAI Extended Debug: Default trigger check result: %1",[!(isNull A3EAI_defaultTrigger),(typeOf A3EAI_defaultTrigger),(getPosASL A3EAI_defaultTrigger)]]};
};

[] call compile preprocessFileLineNumbers format ["%1\scripts\buildWeightedTables.sqf",A3EAI_directory];

if (A3EAI_verifyClassnames) then {
	A3EAI_tableChecklist = ["A3EAI_pistolList","A3EAI_rifleList","A3EAI_machinegunList","A3EAI_sniperList","A3EAI_headgearTypes0","A3EAI_headgearTypes1","A3EAI_headgearTypes2","A3EAI_headgearTypes3",
				"A3EAI_backpackTypes0","A3EAI_backpackTypes1","A3EAI_backpackTypes2","A3EAI_backpackTypes3","A3EAI_foodLoot","A3EAI_MiscLoot1","A3EAI_MiscLoot2",
				"A3EAI_uniformTypes0","A3EAI_uniformTypes1","A3EAI_uniformTypes2","A3EAI_uniformTypes3","A3EAI_launcherTypes","A3EAI_vestTypes0","A3EAI_vestTypes1","A3EAI_vestTypes2","A3EAI_vestTypes3"];
};


if (A3EAI_dynamicUniformList) then {
	_skinlist = [] execVM format ['%1\scripts\A3EAI_buildUniformList.sqf',A3EAI_directory];
	waitUntil {uiSleep 0.05; scriptDone _skinlist};
};

//Build weapon classname tables
if (A3EAI_dynamicWeaponList) then {
	_weaponlist = [] execVM format ['%1\scripts\A3EAI_buildWeaponList.sqf',A3EAI_directory];
	waitUntil {uiSleep 0.05; scriptDone _weaponlist};
};

//Build backpack classname tables
if (A3EAI_dynamicBackpackList) then {
	_backpacklist = [] execVM format ['%1\scripts\A3EAI_buildBackpackList.sqf',A3EAI_directory];
	waitUntil {uiSleep 0.05; scriptDone _backpacklist};
};

//Build vest classname tables
if (A3EAI_dynamicVestList) then {
	_vestlist = [] execVM format ['%1\scripts\A3EAI_buildVestList.sqf',A3EAI_directory];
	waitUntil {uiSleep 0.05; scriptDone _vestlist};
};

//Build headgear classname tables
if (A3EAI_dynamicHeadgearList) then {
	_headgearlist = [] execVM format ['%1\scripts\A3EAI_buildHeadgearList.sqf',A3EAI_directory];
	waitUntil {uiSleep 0.05; scriptDone _headgearlist};
};

//Build food classname tables (1)
if (A3EAI_dynamicFoodList) then {
	_foodlist = [] execVM format ['%1\scripts\A3EAI_buildFoodList.sqf',A3EAI_directory];
	waitUntil {uiSleep 0.05; scriptDone _foodlist};
};

//Build generic loot classname tables (1)
if (A3EAI_dynamicLootList) then {
	_lootlist = [] execVM format ['%1\scripts\A3EAI_buildLootList.sqf',A3EAI_directory];
	waitUntil {uiSleep 0.05; scriptDone _lootlist};
};

//Build generic loot classname tables (2)
if (A3EAI_dynamicLootLargeList) then {
	_lootlistlarge = [] execVM format ['%1\scripts\A3EAI_buildLootLargeList.sqf',A3EAI_directory];
	waitUntil {uiSleep 0.05; scriptDone _lootlistlarge};
};


//Check classname tables if enabled
if (A3EAI_verifyClassnames) then {
	_verifyClassnames = [] execVM format ["%1\scripts\verifyClassnames.sqf",A3EAI_directory];
	waitUntil {uiSleep 0.05; scriptDone _verifyClassnames};
};

if (A3EAI_enableHC && {A3EAI_waitForHC}) then {
	diag_log "[A3EAI] Waiting for headless client to connect. A3EAI post-initialization process paused.";
	waitUntil {uiSleep 5; A3EAI_HCIsConnected};
	diag_log format ["[A3EAI] Headless client connected with owner ID %1. A3EAI post-initialization process continuing.",A3EAI_HCObjectOwnerID];
};

A3EAI_classnamesVerified = true;

//Build map location list.
_setupLocations = [] execVM format ['%1\scripts\setup_locations.sqf',A3EAI_directory];

//Set up auto-generated static spawns
if (A3EAI_autoGenerateStatic) then {
	_staticSpawns = [] execVM format ["%1\scripts\setup_autoStaticSpawns.sqf",A3EAI_directory];
};

//Start dynamic spawn manager
if !(A3EAI_dynMaxSpawns isEqualTo 0) then {
	_dynManagerV2 = [] execVM format ['%1\scripts\dynamicSpawn_manager.sqf',A3EAI_directory];
};

//Start allowDamage fix (disabled)
//_ADP = [] execVM format ['%1\scripts\allowDamage_fix.sqf',A3EAI_directory];

//Set up vehicle patrols
if ((A3EAI_maxHeliPatrols > 0) or {(A3EAI_maxLandPatrols > 0)}) then {
	_vehicles = [] execVM format ['%1\scripts\setup_veh_patrols.sqf',A3EAI_directory];
};

//Load custom definitions file
if (A3EAI_loadCustomFile) then {
	_customLoader = [] execVM format ["%1\init\A3EAI_custom_loader.sqf",A3EAI_directory]; //Load custom spawns
};

//Load A3EAI server monitor
_serverMonitor = [] execVM format ['%1\scripts\A3EAI_serverMonitor.sqf',A3EAI_directory];
