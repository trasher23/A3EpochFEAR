/*
	A3EAI Configuration File
	
	Description: Contains all configurable settings of A3EAI. Contains settings for debugging, customization of AI units, spawning, and loot.
	

*/

diag_log "[A3EAI] Reading A3EAI configuration file.";

/*	A3EAI Settings
--------------------------------------------------------------------------------------------------------------------*/	

//Enable or disable event logging to the server RPT file (named arma3server_[date]_[time].rpt). Debug level setting. 0: No debug output, 1: Basic Debug output, 2: Detailed Debug output. (Default: 0)
//Debug output may help finding additional information about A3EAI's background behavior. This output is helpful when asking for help regarding bugs or unexpected behaviors.
A3EAI_debugLevel = 0;

//Frequency of server monitor update to RPT log in seconds. The monitor periodically reports number of max/current AI units and dynamically spawned triggers into RPT log. (Default: 300, 0 = Disable reporting)										
A3EAI_monitorRate = 900;

//Enable or disable verification and error-correction of classname tables used by A3EAI. If invalid entries are found, they are removed and logged into the RPT log.
//If disabled, any invalid classnames will not be removed and clients may crash if AI bodies with invalid items are looted. Only disable if a previous scan shows no invalid classnames (Default: true).										
A3EAI_verifyClassnames = true;

//Enables checking of all A3EAI config settings. (Default: true)
A3EAI_verifySettings = true;

//Minimum seconds to pass until each dead AI body or destroyed vehicle can be cleaned up by A3EAI's task scheduler. A3EAI will not clean up a body/vehicle if there is a player close by (Default: 900).									
A3EAI_cleanupDelay = 900;									

//Enabled: A3EAI will load custom spawn/blacklist definitions file on startup (A3EAI_custom_defs.sqf) (Default: false)
A3EAI_loadCustomFile = false;


/*	A3EAI HC Settings
--------------------------------------------------------------------------------------------------------------------*/	

//Enables A3EAI headless client support. (Default: false)
A3EAI_enableHC = false;

//If HC support enabled, A3EAI will pause during post-initialization until HC has successfully connected. (Default: false)
//IMPORTANT: It is highly recommended to ensure that the HC is properly setup before enabling this option, otherwise A3EAI may be stuck waiting for HC to to connect.
A3EAI_waitForHC = false;


/*	Dynamic Classname Settings

	If a setting is disabled, A3EAI will use the corresponding classname table further below. See "AI skin, weapon, loot, and equipment settings" section.
--------------------------------------------------------------------------------------------------------------------*/	

//true: Generate AI weapons from Epoch loot tables (Default)
//false: Weapons defined by A3EAI_pistolList, A3EAI_rifleList, A3EAI_machinegunList, A3EAI_sniperList
A3EAI_dynamicWeaponList = true;

//true: Use Epoch loot table data as whitelist for AI-usable weapon scopes (Default)
//false: Scopes defined by A3EAI_weaponOpticsList
A3EAI_dynamicOpticsList = true;

//true: Generate AI uniform types from Epoch loot tables (Default)
//false: Uniforms defined by A3EAI_uniformTypes0, A3EAI_uniformTypes1, A3EAI_uniformTypes2, A3EAI_uniformTypes3
//A3EAI_dynamicUniformLevels: List of unit levels affected by dynamic classname function
A3EAI_dynamicUniformList = true;
A3EAI_dynamicUniformLevels = [0,1,2,3];

//true: Generate AI backpack types from Epoch loot tables (Default)
//false: Backpacks defined by A3EAI_backpackTypes0, A3EAI_backpackTypes1, A3EAI_backpackTypes2, A3EAI_backpackTypes3
//A3EAI_dynamicBackpackLevels: List of unit levels affected by dynamic classname function
A3EAI_dynamicBackpackList = true;
A3EAI_dynamicBackpackLevels = [0,1,2,3];

//true: Generate AI backpack types from Epoch loot tables (Default)
//false: Vests defined by A3EAI_vestTypes0, A3EAI_vestTypes1, A3EAI_vestTypes2, A3EAI_vestTypes3
//A3EAI_dynamicVestLevels: List of unit levels affected by dynamic classname function
A3EAI_dynamicVestList = true;
A3EAI_dynamicVestLevels = [0,1,2,3];

//true: Generate AI headgear types from Epoch loot tables (Default)
//false: Headgear defined by A3EAI_headgearTypes0, A3EAI_headgearTypes1, A3EAI_headgearTypes2, A3EAI_headgearTypes3
//A3EAI_dynamicHeadgearLevels: List of unit levels affected by dynamic classname function
A3EAI_dynamicHeadgearList = true;
A3EAI_dynamicHeadgearLevels = [0,1,2,3];

//true: Generate AI food types from Epoch loot tables (Default)
//false: Food defined by A3EAI_foodLoot
A3EAI_dynamicFoodList = true;

//true: Generate AI generic loot types from Epoch loot tables (Default)
//false: Loot defined by A3EAI_miscLoot1 and A3EAI_miscLoot2
A3EAI_dynamicLootList = true;

//Classnames of weapons to ignore from Epoch loot tables
A3EAI_dynamicWeaponBlacklist = [];


/*	A3EAI Client Addon features. These features require the A3EAI client addon to be installed in order to work.
--------------------------------------------------------------------------------------------------------------------*/	

//Enable or disable radio message receiving. Players with radios (Radio Quartz) will be able to intercept some AI communications. (Default: false)
A3EAI_radioMsgs = true;

//Enable or disable AI death messages. Messages will be sent only to player responsible for killing the unit. Messages will be sent in System chat in the format "(Unit name) was killed." (Default: false)
A3EAI_deathMessages = true;	


/*	Shared AI Unit Settings. These settings affect all AI spawned unless noted otherwise.
--------------------------------------------------------------------------------------------------------------------*/	

//Number of online players required for maximum (or minimum) AI spawn chance. Affects Static, Dynamic, Random AI spawns. (Default: 20)	
A3EAI_playerCountThreshold = 2;

//true: Spawn chance multiplier scales upwards from value defined by A3EAI_chanceScalingThreshold to 1.00. false: Spawn chance multiplier scales downwards from 1.00 to A3EAI_chanceScalingThreshold.
A3EAI_upwardsChanceScaling = true;

//If A3EAI_upwardsChanceScaling is true: Initial spawn chance multiplier. If A3EAI_upwardsChanceScaling is false: Final spawn chance multiplier. (Default: 0.50)
A3EAI_chanceScalingThreshold = 0.50;

//(Static/Dynamic/Random Spawns) minAI: Minimum number of units. addAI: maximum number of additional units. unitLevel: Unit level (0-3)
A3EAI_minAI_village = 1; //1
A3EAI_addAI_village = 1; //1
A3EAI_unitLevel_village = 0; //0
A3EAI_spawnChance_village = 0.40; //0.40

//(Static/Dynamic/Random Spawns) minAI: Minimum number of units. addAI: maximum number of additional units. unitLevel: Unit level (0-3)
A3EAI_minAI_city = 1; //1
A3EAI_addAI_city = 2; //2
A3EAI_unitLevel_city = 1; //1
A3EAI_spawnChance_city = 0.60; //0.60

//(Static/Dynamic/Random Spawns) minAI: Minimum number of units. addAI: maximum number of additional units. unitLevel: Unit level (0-3)
A3EAI_minAI_capitalCity = 2; //2
A3EAI_addAI_capitalCity = 1; //1
A3EAI_unitLevel_capitalCity = 1; //1
A3EAI_spawnChance_capitalCity = 0.70; //0.70

//(Static/Dynamic/Random Spawns) minAI: Minimum number of units. addAI: maximum number of additional units. unitLevel: Unit level (0-3)
A3EAI_minAI_remoteArea = 1; //1
A3EAI_addAI_remoteArea = 1; //1
A3EAI_unitLevel_remoteArea = 2; //2
A3EAI_spawnChance_remoteArea = 0.80; //0.80

//(Dynamic/Random Spawns) minAI: Minimum number of units. addAI: maximum number of additional units. unitLevel: Unit level (0-3)
A3EAI_minAI_wilderness = 1; //1
A3EAI_addAI_wilderness = 2; //2
A3EAI_unitLevel_wilderness = 1; //1
A3EAI_spawnChance_wilderness = 0.50; //0.50

//(For dynamic and random spawns only) Defines amount of time to wait in seconds until cleaning up temporary blacklist area after dynamic/random spawn is deactivated (Default: 1200)
A3EAI_tempBlacklistTime = 1200;

//If enabled, AI group will attempt to track down player responsible for killing a group member. (Default: true)
A3EAI_findKiller = true;	

//If normal probability check for spawning NVGs fails, then give AI temporary NVGs during night hours. Temporary NVGs are unlootable and will be removed at death (Default: false).									
A3EAI_tempNVGs = false;	

//Minimum AI unit level requirement to use underslung grenade launchers. Set to -1 to disable completely. (Default: 1)
A3EAI_GLRequirement = 1;	

//Minimum AI unit level requirement to use launcher weapons. Set to -1 to disable completely. (Default: -1)
A3EAI_launcherLevelReq = 2;	

//List of launcher-type weapons that AI can use.
A3EAI_launcherTypes = ["launch_NLAW_F","launch_RPG32_F","launch_B_Titan_F","launch_I_Titan_F","launch_O_Titan_F","launch_B_Titan_short_F","launch_I_Titan_short_F","launch_O_Titan_short_F"];	

//Maximum number of launcher weapons allowed per group (Default: 1)
A3EAI_launchersPerGroup = 1;

//Enable or disable AI self-healing. Level 0 AI cannot self-heal. (Default: true).
//Affects: All AI infantry units
A3EAI_enableHealing = true;

//If enabled, A3EAI will remove all explosive ammo (missiles, rockets, bombs - but not HE rounds) from spawned AI air vehicles.  (Default: true)
//Affects: All AI air vehicle types (patrols/custom/reinforcement). Does not affect UAV/UGVs.
A3EAI_removeExplosiveAmmo = true;

//if enabled, AI units suffer no damage from vehicle collisions. (Default: true)
A3EAI_noCollisionDamage = true;

//If enabled, AI killed by vehicle collisions will have their gear removed (Default: true)
A3EAI_roadKillPenalty = true;


/*	Static Infantry AI Spawning Settings

	A3EAI will spawn an AI group at various named locations on the map if players are nearby. 
--------------------------------------------------------------------------------------------------------------------*/	

//Enable or disable static AI spawns. If enabled, AI spawn points will be generated in cities, towns, and other named areas.
//Enabled: A3EAI automatically generates static spawns at named locations on map. Disabled: No static spawns will be generated. (Default: true)
A3EAI_enableStaticSpawns = true;

//Set minimum and maximum wait time in seconds to respawn an AI group after all units have been killed. Applies to both static AI and custom spawned AI (Default: Min 300, Max 600).									
A3EAI_respawnTimeMin = 300;
A3EAI_respawnTimeMax = 600;

//Time to allow spawned AI units to exist in seconds before being despawned when no players are present in a trigger area. Applies to both static AI and custom spawned AI (Default: 120)										
A3EAI_despawnWait = 120;										

//Respawn Limits. Set to -1 for unlimited respawns. (Default: -1 for each).
A3EAI_respawnLimit_village = -1;
A3EAI_respawnLimit_city = -1;
A3EAI_respawnLimit_capitalCity = -1;
A3EAI_respawnLimit_remoteArea = -1;

//Add name of location as displayed on map prevent static AI spawns from being created in these locations. Location names are case-sensitive (Example: ["Aggelochori","Panochori","Zaros"])
A3EAI_staticBlacklistLocations = [];


/*	Dynamic Infantry AI Spawning Settings. Probabilities should add up to 1.00	

	A3EAI will create ambient threat in the area for each player by periodically spawning AI to create unexpected ambush encounters. These AI may occasionally seek out and hunt a player. 
--------------------------------------------------------------------------------------------------------------------*/		

//Upper limit of dynamic spawns on map at once. Set to 0 to disable dynamic spawns (Default: 15)
A3EAI_dynMaxSpawns = 15;

//Minimum time (in seconds) that must pass between dynamic spawns for each player (Default: 900)
A3EAI_dynCooldownTime = 900;

//Players offline for this amount of time (seconds) will have their last spawn timestamp reset (Default: 3600)
A3EAI_dynResetLastSpawn = 3600;

//Probability for dynamic AI to actively hunt a targeted player. If probability check fails, dynamic AI will patrol the area instead of hunting (Default: 0.60)
A3EAI_huntingChance = 0.60;

//Time to wait before despawning all AI units in dynamic spawn area when no players are present. (Default: 120)
A3EAI_dynDespawnWait = 120;


/*	Random Infantry AI Spawning Settings

	A3EAI will create spawns that are randomly placed around the map and are periodically relocated. These spawns are preferentially created in named locations, but may be also created anywhere in the world. 
--------------------------------------------------------------------------------------------------------------------*/		

//Maximum number of placed random spawns on map. Set to -1 for A3EAI to automatically adjust spawn limit according to map size. Set to 0 to disable random spawns. (Default: -1)
A3EAI_maxRandomSpawns = -1;

//Time to wait before despawning all AI units in random spawn area when no players are present. (Default: 120)
A3EAI_randDespawnWait = 120;

//Minimum distance between a random spawn location and other random spawns. (Default: 0)
A3EAI_minRandSpawnDist = 0;


/*	Shared AI Vehicle Settings

	These settings affect the following AI vehicle patrol types: Air, Land, UAV, UGV
--------------------------------------------------------------------------------------------------------------------*/

//Add name of location as displayed on map prevent AI vehicle patrols from travelling to these locations. Location names are case-sensitive. (Example: ["Aggelochori","Panochori","Zaros"])
//Note: Vehicles may still pass through these areas, but will become non-hostile towards players until they travel 600m away from the area.
A3EAI_waypointBlacklistAir = []; //Affects Air vehicles (including UAVs)
A3EAI_waypointBlacklistLand = [];  //Affects Air vehicles (including UGVs)


/*	AI Air Vehicle patrol settings. 

	IMPORTANT: UAVs (Unmanned aerial vehicles) are not supported by this function. UAV spawns can be configured in the "UAV Patrol Settings" section further below.

	A3EAI will create AI vehicle patrols that will randomly travel between different cities and towns, and engage any players encountered.
	Helicopters with available cargo space may also occasionally deploy an AI group by parachute. 
--------------------------------------------------------------------------------------------------------------------*/		

//Global maximum number of active AI air vehicle patrols. Set at 0 to disable (Default: 0).							
A3EAI_maxHeliPatrols = 3;	

//Probability of spawning Level 0/1/2/3 AI air vehicle patrol spawns. Probabilities should add up to 1.00		
A3EAI_levelChancesAir = [0.00,0.50,0.35,0.15];	

//Set minimum and maximum wait time in seconds to respawn an AI vehicle patrol after vehicle is destroyed or disabled. (Default: Min 600, Max 900).
A3EAI_respawnAirMinTime = 600;
A3EAI_respawnAirMaxTime = 900;

//Classnames of air vehicle types to use, with the maximum amount of each type to spawn.
A3EAI_heliList = [
	["B_Heli_Light_01_armed_F",5],
	["B_Heli_Transport_01_F",5],
	["B_Heli_Transport_03_F",2]
];

//Maximum number of gunner units per air vehicle. Limited by actual number of available gunner positions. (Default: 2)
//Affects: All AI air vehicle patrols, including custom and reinforcement.
A3EAI_heliGunnerUnits = 2;

//Probability of AI helicopter sucessfully detecting player if there is line-of-sight. AI helicopters will conduct a visual sweep upon arriving at each waypoint and some distance after leaving. (Default: 0.80)
//Affects: All AI air vehicle patrols, including custom and reinforcement.
A3EAI_airDetectChance = 0.80;

//Probability of AI to deploy infantry units by parachute if players are nearby when helicopter is investigating a waypoint. (Default: 0.50)
//Affects: Air vehicle patrols.
A3EAI_paraDropChance = 0.50;

//Cooldown time for AI paradrop deployment in seconds. (Default: 1800).
//Affects: Air vehicle patrols.
A3EAI_paraDropCooldown = 1800;

//Number of infantry AI to paradrop if players are nearby when helicopter is investigating a waypoint, or if helicopter is reinforcing a dynamic AI spawn. Limited by number of cargo seats available in the vehicle. (Default: 3)
//Affects: Air vehicle patrols, air reinforcements.
A3EAI_paraDropAmount = 3;


/*	AI Land Vehicle patrol settings. These AI vehicles will randomly travel between different cities and towns.

	IMPORTANT: UGVs (Unmanned ground vehicles) are not supported by this function. UGV spawns can be configured in the "UGV Patrol Settings" section further below.
	
	A3EAI will create AI vehicle patrols that will randomly travel between different cities and towns, and engage any players encountered.
--------------------------------------------------------------------------------------------------------------------*/	

//Global maximum number of active AI land vehicle patrols. Set at 0 to disable (Default: 0).	
A3EAI_maxLandPatrols = 10;

//Probability of spawning Level 0/1/2/3 AI land vehicle spawns. Probabilities should add up to 1.00		
A3EAI_levelChancesLand = [0.00,0.50,0.35,0.15];	

//Set minimum and maximum wait time in seconds to respawn an AI vehicle patrol after vehicle is destroyed or disabled. (Default: Min 600, Max 900).
A3EAI_respawnLandMinTime = 600;
A3EAI_respawnLandMaxTime = 900;

//Classnames of land vehicle types to use, with the maximum amount of each type to spawn.
A3EAI_vehList = [
	["B_MRAP_01_EPOCH",5],
	["C_Van_01_box_EPOCH",5],
	["C_Van_01_transport_EPOCH",5],
	["C_Offroad_01_EPOCH",5],
	["C_Hatchback_02_EPOCH",5],
	["C_Hatchback_01_EPOCH",5],
	["C_SUV_01_EPOCH",5],
	["B_Truck_01_transport_EPOCH",5],
    ["B_Truck_01_covered_EPOCH",5],
    ["B_Truck_01_mover_EPOCH",5],
    ["B_Truck_01_box_EPOCH",5],
    ["O_Truck_02_covered_EPOCH",5],
    ["O_Truck_02_transport_EPOCH",5],
    ["O_Truck_03_covered_EPOCH",5],
    ["O_Truck_02_box_EPOCH",5]
];

//Maximum number of gunner units per land vehicle. Limited by actual number of available gunner positions. (Default: 2)
A3EAI_vehGunnerUnits = 2;

//Maximum number of cargo units per land vehicle. Limited by actual number of available cargo positions. (Default: 3)
A3EAI_vehCargoUnits = 3;


/*	AI Air Reinforcement Settings

	Allowed types of AI groups (defined by A3EAI_airReinforcementAllowedTypes) may call for temporary air reinforcements if a player kills one of their units.
	Probability to summon reinforcements determined by A3EAI_airReinforcementSpawnChance<AI level>, where <AI level> is the level of the calling group.
	Once summoned, armed reinforcement vehicles will remain in the area for a duration determined by A3EAI_airReinforcementDuration<AI level> and engage nearby players.
	Unarmed reinforcement vehicles will deploy a paradrop group and exit the area.
	
--------------------------------------------------------------------------------------------------------------------*/

//Maximum allowed number of simultaneous active reinforcements (Default: 5)
A3EAI_maxAirReinforcements = 5;

//Air vehicles to use as reinforcement vehicles. Default: ["B_Heli_Transport_01_F","B_Heli_Light_01_armed_F"]
//Armed air vehicles will detect and engage players within reinforcement area. Unarmed air vehicles will deploy an AI paradrop group.
A3EAI_airReinforcementVehicles = [
	"B_Heli_Transport_01_F",
	"B_Heli_Light_01_armed_F"
]; 

//Probability to spawn reinforcements for each AI level.
A3EAI_airReinforcementSpawnChance0 = 0.00; //Probability of reinforcing Level 0 AI (Default: 0.00)
A3EAI_airReinforcementSpawnChance1 = 0.10; //Probability of reinforcing Level 1 AI (Default: 0.10)
A3EAI_airReinforcementSpawnChance2 = 0.20; //Probability of reinforcing Level 2 AI (Default: 0.20)
A3EAI_airReinforcementSpawnChance3 = 0.30; //Probability of reinforcing Level 3 AI (Default: 0.30)

//AI types permitted to summon reinforcements. Default: ["static","dynamic","random"]
//Usable AI types: "static", "dynamic", "random", "air", "land", "staticcustom", "aircustom", "landcustom", "vehiclecrew"
A3EAI_airReinforcementAllowedTypes = ["static","dynamic","random"];

//Maximum time for reinforcement for armed air vehicles in seconds. AI air vehicle will leave the area after this time if not destroyed.
A3EAI_airReinforcementDuration0 = 120; //Level 0 Default: 120
A3EAI_airReinforcementDuration1 = 180; //Level 1 Default: 180
A3EAI_airReinforcementDuration2 = 240; //Level 2 Default: 240
A3EAI_airReinforcementDuration3 = 300; //Level 3 Default: 300


/*	UAV Patrol Settings

	IMPORTANT: UAV patrols are a feature in testing, and may undergo significant changes or possible removal in future versions.

	A3EAI can spawn UAVs that patrol between named locations, and deploy air reinforcements if players are found.
	In order for air reinforcements to be deployed, A3EAI_maxAirReinforcements must be greater than zero and the current limit of air reinforcements has not been exceeded.
--------------------------------------------------------------------------------------------------------------------*/

//Global maximum number of active UAV patrols. Set at 0 to disable (Default: 0).	
A3EAI_maxUAVPatrols = 2;

//Classnames of UAV types to use, with the maximum amount of each type to spawn.
A3EAI_UAVList = [
	["I_UAV_02_CAS_F",5],
	["I_UAV_02_F",5],
	["B_UAV_02_CAS_F",5],
	["B_UAV_02_F",5],
	["O_UAV_02_CAS_F",5],
	["O_UAV_02_F",5]
];

//Probability of spawning Level 0/1/2/3 UAV spawns. Probabilities should add up to 1.00	
A3EAI_levelChancesUAV = [0.35,0.50,0.15,0.00];	

//Set minimum and maximum wait time in seconds to respawn a UAV after vehicle is destroyed or disabled. (Default: Min 600, Max 900).
A3EAI_respawnUAVMinTime = 600;
A3EAI_respawnUAVMaxTime = 900;

//Set to 'true' to set detection-only behavior (UAV will not directly engage enemies). (Default: false)
A3EAI_UAVDetectOnly = true;

//Cooldown required in between air reinforcement summons when detecting players. Value in seconds. (Default: 1800)
A3EAI_UAVCallReinforceCooldown = 1800;

//Probability to successfully detect player if there is line-of-sight. If at least one player is detected, air reinforcements will be summoned to the area. (Default: 0.50)
A3EAI_UAVDetectChance = 0.80;


/*	UGV Patrol Settings

	IMPORTANT: UGV patrols are a feature in testing, and may undergo significant changes or possible removal in future versions.

	A3EAI can spawn UGVs that patrol between named locations, and deploy air reinforcements if players are found. Damaged UGVs repair themselves over time if not engaging enemes.
	In order for air reinforcements to be deployed, A3EAI_maxAirReinforcements must be greater than zero and the current limit of air reinforcements has not been exceeded.
--------------------------------------------------------------------------------------------------------------------*/

//Global maximum number of active UGV patrols. Set at 0 to disable (Default: 0).	
A3EAI_maxUGVPatrols = 5;

//Classnames of UGV types to use, with the maximum amount of each type to spawn.
A3EAI_UGVList = [
	["I_UGV_01_rcws_F",5],
	["B_UGV_01_rcws_F",5],
	["O_UGV_01_rcws_F",5]
];

//Probability of spawning Level 0/1/2/3 AI UGV spawns. Probabilities should add up to 1.00	
A3EAI_levelChancesUGV = [0.35,0.50,0.15,0.00];	

//Set minimum and maximum wait time in seconds to respawn a UGV patrol after vehicle is destroyed or disabled. (Default: Min 600, Max 900).
A3EAI_respawnUGVMinTime = 600;
A3EAI_respawnUGVMaxTime = 900;

//Set to 'true' to set detection-only behavior (UGV will not directly engage enemies). (Default: false)
A3EAI_UGVDetectOnly = true;

//Cooldown required in between air reinforcement summons when detecting players. Value in seconds. (Default: 1800)
A3EAI_UGVCallReinforceCooldown = 1800;

//Probability to successfully detect player if there is line-of-sight. If at least one player is detected, air reinforcements will be summoned to the area. (Default: 0.50)
A3EAI_UGVDetectChance = 0.80;


/*
	AI skill settings. 
	
	These settings affect all AI units spawned by A3EAI.
	
	Skill Level: Description
	0: Low-level AI found in villages
	1: Medium-level AI found in cities and capital cities
	2: High-level AI found in remote areas such as factories and military bases
	3: Expert-level AI.
	
	Valid skill range: 0.00 - 1.00.
	Hint: For all skill types, higher number = better skill. For skill sub-type explanation, see: https://community.bistudio.com/wiki/AI_Sub-skills
*/

//AI skill settings level 0 (Skill, Minimum skill, Maximum skill). Defaults: Accuracy 0.05-0.10, Others 0.30-0.50
A3EAI_skill0 = [	
	["aimingAccuracy",0.05,0.10],
	["aimingShake",0.30,0.50],
	["aimingSpeed",0.30,0.50],
	["spotDistance",0.30,0.50],
	["spotTime",0.30,0.50],
	["courage",0.30,0.50],
	["reloadSpeed",0.30,0.50],
	["commanding",0.30,0.50],
	["general",0.30,0.50]
];

//AI skill settings level 1 (Skill, Minimum skill, Maximum skill). Defaults: Accuracy 0.10-0.15, Others 0.40-0.60
A3EAI_skill1 = [	
	["aimingAccuracy",0.10,0.15],
	["aimingShake",0.40,0.60],
	["aimingSpeed",0.40,0.60],
	["spotDistance",0.40,0.60],
	["spotTime",0.40,0.60],
	["courage",0.40,0.60],
	["reloadSpeed",0.40,0.60],
	["commanding",0.40,0.60],
	["general",0.40,0.60]
];

//AI skill settings level 2 (Skill, Minimum skill, Maximum skill). Defaults: Accuracy 0.15-0.20, Others 0.50-0.70
A3EAI_skill2 = [	
	["aimingAccuracy",0.15,0.20],
	["aimingShake",0.50,0.70],
	["aimingSpeed",0.50,0.70],
	["spotDistance",0.50,0.70],
	["spotTime",0.50,0.70],
	["courage",0.50,0.70],
	["reloadSpeed",0.50,0.70],
	["commanding",0.50,0.70],
	["general",0.50,0.70]
];

//AI skill settings level 3 (Skill, Minimum skill, Maximum skill). Defaults: Accuracy 0.20-0.25, Others 0.60-0.80
A3EAI_skill3 = [	
	["aimingAccuracy",0.20,0.25],
	["aimingShake",0.60,0.80],
	["aimingSpeed",0.60,0.80],
	["spotDistance",0.60,0.80],
	["spotTime",0.60,0.80],
	["courage",0.60,0.80],
	["reloadSpeed",0.60,0.80],
	["commanding",0.60,0.80],
	["general",0.60,0.80]
];


/*	AI loadout probability settings.
--------------------------------------------------------------------------------------------------------------------*/

//Probabilities to equip uniform d other than default, according to AI level.
A3EAI_addUniformChance0 = 0.60;
A3EAI_addUniformChance1 = 0.70;
A3EAI_addUniformChance2 = 0.80;
A3EAI_addUniformChance3 = 0.90;

//Probabilities to equip backpack, according to AI level.
A3EAI_addBackpackChance0 = 0.60;
A3EAI_addBackpackChance1 = 0.70;
A3EAI_addBackpackChance2 = 0.80;
A3EAI_addBackpackChance3 = 0.90;

//Probabilities to equip vest other than default, according to AI level.
A3EAI_addVestChance0 = 0.60;
A3EAI_addVestChance1 = 0.70;
A3EAI_addVestChance2 = 0.80;
A3EAI_addVestChance3 = 0.90;

//Probabilities to equip headgear, according to AI level.
A3EAI_addHeadgearChance0 = 0.60;
A3EAI_addHeadgearChance1 = 0.70;
A3EAI_addHeadgearChance2 = 0.80;
A3EAI_addHeadgearChance3 = 0.90;

//Probabilities to equip level 0-3 AI with each weapon type. Order: [pistols, rifles, machineguns, sniper rifles]. Probabilities must add up to 1.00.
A3EAI_useWeaponChance0 = [0.20,0.80,0.00,0.00];
A3EAI_useWeaponChance1 = [0.00,0.90,0.05,0.05];
A3EAI_useWeaponChance2 = [0.00,0.80,0.10,0.10];
A3EAI_useWeaponChance3 = [0.00,0.70,0.15,0.15];

//Probability to select a random optics attachment (ie: scopes) for level 0-3 AI
A3EAI_opticsChance0 = 0.00;
A3EAI_opticsChance1 = 0.30;
A3EAI_opticsChance2 = 0.60;
A3EAI_opticsChance3 = 0.90;

//Probability to select a random pointer attachment (ie: flashlights) for level 0-3 AI
A3EAI_pointerChance0 = 0.00;
A3EAI_pointerChance1 = 0.30;
A3EAI_pointerChance2 = 0.60;
A3EAI_pointerChance3 = 0.90;

//Probability to select a random muzzle attachment (ie: suppressors) for level 0-3 AI
A3EAI_muzzleChance0 = 0.00;
A3EAI_muzzleChance1 = 0.30;
A3EAI_muzzleChance2 = 0.60;
A3EAI_muzzleChance3 = 0.90;

//Probability to select a random underbarrel attachment (ie: bipods) for level 0-3 AI
A3EAI_underbarrelChance0 = 0.00;
A3EAI_underbarrelChance1 = 0.30;
A3EAI_underbarrelChance2 = 0.60;
A3EAI_underbarrelChance3 = 0.90;


/*	AI loot quantity settings
--------------------------------------------------------------------------------------------------------------------*/

//Maximum amount of Krypto generated for level 0-3 AI. Actual amount will be randomized up to the specified amount.
A3EAI_kryptoAmount0 = 50; 	//Default for level 0 AI: 50
A3EAI_kryptoAmount1 = 75; 	//Default for level 1 AI: 75
A3EAI_kryptoAmount2 = 100; 	//Default for level 2 AI: 100
A3EAI_kryptoAmount3 = 150; 	//Default for level 3 AI: 150

//Krypto pickup assist time window in seconds. Players must be within 2 meters of a Krypto device for 5 seconds to pick up Krypto automatically. 0: Disabled (Default: 0)
//After this time limit, players must manually pick up any dropped Krypto.
A3EAI_kryptoPickupAssist = 0;

//Maximum number of food loot items found on AI. (Default: 1)								
A3EAI_foodLootCount = 2;

//Maximum number of items to select from A3EAI_miscLoot1 (generic loot) table. (Default: 1)											
A3EAI_miscLootCount1 = 2;						

//Maximum number of items to select from A3EAI_miscLoot2 (large generic loot) table. (Default: 1)					
A3EAI_miscLootCount2 = 1;	



/*	AI loot probability settings. AI loot is pre-generated into a pool for each unit and randomly pulled to units as time passes.
--------------------------------------------------------------------------------------------------------------------*/

//Chance to add a single First Aid Kit to group loot pool per unit (Default: 0.25)
A3EAI_chanceFirstAidKit = 0.25;

//Chance to add each edible item to group loot pool per unit (Default: 0.40)								
A3EAI_chanceFoodLoot = 0.40;

//Chance to add each generic loot item to group loot pool per unit (Default: 0.40)									
A3EAI_chancemiscLoot1 = 0.40;

//Chance to add each large generic loot item to group loot pool per unit (Default: 0.30)								
A3EAI_chancemiscLoot2 = 0.30;

//Probability to successfully pull a random item from loot pool for level 0-3 AI. Influences the rate at which loot items are added to units.
A3EAI_lootPullChance0 = 0.20; //Default for level 0 AI: 0.20
A3EAI_lootPullChance1 = 0.40; //Default for level 1 AI: 0.40
A3EAI_lootPullChance2 = 0.60; //Default for level 2 AI: 0.60
A3EAI_lootPullChance3 = 0.80; //Default for level 3 AI: 0.80


/*
	AI clothing, weapon, loot, and equipment settings

	Note: Some of the below tables may not be used by A3EAI if a dynamic classname setting is enabled. Check each section below for details.
*/


//AI uniform classnames. Note: A3EAI_uniformTypes0-3 will not be read if A3EAI_dynamicUniformList is enabled.
//------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
A3EAI_uniformTypes0 = ["U_O_CombatUniform_ocamo", "U_O_GhillieSuit", "U_O_PilotCoveralls", "U_O_Wetsuit", "U_OG_Guerilla1_1", "U_OG_Guerilla2_1", "U_OG_Guerilla2_3", "U_OG_Guerilla3_1", "U_OG_Guerilla3_2", "U_OG_leader", "U_C_Poloshirt_stripped", "U_C_Poloshirt_blue", "U_C_Poloshirt_burgundy", "U_C_Poloshirt_tricolour", "U_C_Poloshirt_salmon", "U_C_Poloshirt_redwhite", "U_C_Poor_1", "U_C_WorkerCoveralls", "U_C_Journalist", "U_C_Scientist", "U_OrestesBody", "U_Wetsuit_uniform", "U_Wetsuit_White", "U_Wetsuit_Blue", "U_Wetsuit_Purp", "U_Wetsuit_Camo", "U_CamoRed_uniform", "U_CamoBrn_uniform", "U_CamoBlue_uniform", "U_Camo_uniform", "U_ghillie1_uniform", "U_ghillie2_uniform", "U_ghillie3_uniform", "U_C_Driver_1", "U_C_Driver_2", "U_C_Driver_3", "U_C_Driver_4", "U_C_Driver_1_black", "U_C_Driver_1_blue", "U_C_Driver_1_green", "U_C_Driver_1_red", "U_C_Driver_1_white", "U_C_Driver_1_yellow", "U_C_Driver_1_orange", "U_C_Driver_1_red"];
A3EAI_uniformTypes1 = ["U_O_CombatUniform_ocamo", "U_O_GhillieSuit", "U_O_PilotCoveralls", "U_O_Wetsuit", "U_OG_Guerilla1_1", "U_OG_Guerilla2_1", "U_OG_Guerilla2_3", "U_OG_Guerilla3_1", "U_OG_Guerilla3_2", "U_OG_leader", "U_C_Poloshirt_stripped", "U_C_Poloshirt_blue", "U_C_Poloshirt_burgundy", "U_C_Poloshirt_tricolour", "U_C_Poloshirt_salmon", "U_C_Poloshirt_redwhite", "U_C_Poor_1", "U_C_WorkerCoveralls", "U_C_Journalist", "U_C_Scientist", "U_OrestesBody", "U_Wetsuit_uniform", "U_Wetsuit_White", "U_Wetsuit_Blue", "U_Wetsuit_Purp", "U_Wetsuit_Camo", "U_CamoRed_uniform", "U_CamoBrn_uniform", "U_CamoBlue_uniform", "U_Camo_uniform", "U_ghillie1_uniform", "U_ghillie2_uniform", "U_ghillie3_uniform", "U_C_Driver_1", "U_C_Driver_2", "U_C_Driver_3", "U_C_Driver_4", "U_C_Driver_1_black", "U_C_Driver_1_blue", "U_C_Driver_1_green", "U_C_Driver_1_red", "U_C_Driver_1_white", "U_C_Driver_1_yellow", "U_C_Driver_1_orange", "U_C_Driver_1_red"];
A3EAI_uniformTypes2 = ["U_O_CombatUniform_ocamo", "U_O_GhillieSuit", "U_O_PilotCoveralls", "U_O_Wetsuit", "U_OG_Guerilla1_1", "U_OG_Guerilla2_1", "U_OG_Guerilla2_3", "U_OG_Guerilla3_1", "U_OG_Guerilla3_2", "U_OG_leader", "U_C_Poloshirt_stripped", "U_C_Poloshirt_blue", "U_C_Poloshirt_burgundy", "U_C_Poloshirt_tricolour", "U_C_Poloshirt_salmon", "U_C_Poloshirt_redwhite", "U_C_Poor_1", "U_C_WorkerCoveralls", "U_C_Journalist", "U_C_Scientist", "U_OrestesBody", "U_Wetsuit_uniform", "U_Wetsuit_White", "U_Wetsuit_Blue", "U_Wetsuit_Purp", "U_Wetsuit_Camo", "U_CamoRed_uniform", "U_CamoBrn_uniform", "U_CamoBlue_uniform", "U_Camo_uniform", "U_ghillie1_uniform", "U_ghillie2_uniform", "U_ghillie3_uniform", "U_C_Driver_1", "U_C_Driver_2", "U_C_Driver_3", "U_C_Driver_4", "U_C_Driver_1_black", "U_C_Driver_1_blue", "U_C_Driver_1_green", "U_C_Driver_1_red", "U_C_Driver_1_white", "U_C_Driver_1_yellow", "U_C_Driver_1_orange", "U_C_Driver_1_red"];
A3EAI_uniformTypes3 = ["U_O_CombatUniform_ocamo", "U_O_GhillieSuit", "U_O_PilotCoveralls", "U_O_Wetsuit", "U_OG_Guerilla1_1", "U_OG_Guerilla2_1", "U_OG_Guerilla2_3", "U_OG_Guerilla3_1", "U_OG_Guerilla3_2", "U_OG_leader", "U_C_Poloshirt_stripped", "U_C_Poloshirt_blue", "U_C_Poloshirt_burgundy", "U_C_Poloshirt_tricolour", "U_C_Poloshirt_salmon", "U_C_Poloshirt_redwhite", "U_C_Poor_1", "U_C_WorkerCoveralls", "U_C_Journalist", "U_C_Scientist", "U_OrestesBody", "U_Wetsuit_uniform", "U_Wetsuit_White", "U_Wetsuit_Blue", "U_Wetsuit_Purp", "U_Wetsuit_Camo", "U_CamoRed_uniform", "U_CamoBrn_uniform", "U_CamoBlue_uniform", "U_Camo_uniform", "U_ghillie1_uniform", "U_ghillie2_uniform", "U_ghillie3_uniform", "U_C_Driver_1", "U_C_Driver_2", "U_C_Driver_3", "U_C_Driver_4", "U_C_Driver_1_black", "U_C_Driver_1_blue", "U_C_Driver_1_green", "U_C_Driver_1_red", "U_C_Driver_1_white", "U_C_Driver_1_yellow", "U_C_Driver_1_orange", "U_C_Driver_1_red"];


//AI weapon classnames. Note: A3EAI_pistolList, A3EAI_rifleList, A3EAI_machinegunList, A3EAI_sniperList will not be read if A3EAI_dynamicWeaponList is enabled.
//------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
A3EAI_pistolList = ["hgun_Pistol_heavy_01_F","hgun_P07_F","hgun_Rook40_F","hgun_Pistol_heavy_02_F","1911_pistol_epoch","hgun_ACPC2_F","ruger_pistol_epoch"];
A3EAI_rifleList = ["AKM_EPOCH","sr25_epoch","arifle_Katiba_GL_F","arifle_Katiba_C_F","arifle_Katiba_F","arifle_MX_GL_F","arifle_MX_GL_Black_F","arifle_MXM_Black_F","arifle_MXC_Black_F","arifle_MX_Black_F","arifle_MXM_F","arifle_MXC_F","arifle_MX_F","l85a2_epoch","l85a2_pink_epoch","l85a2_ugl_epoch","m4a3_EPOCH","m16_EPOCH","m16Red_EPOCH","arifle_Mk20_GL_F","arifle_Mk20_GL_plain_F","arifle_Mk20C_F","arifle_Mk20C_plain_F","arifle_Mk20_F","arifle_Mk20_plain_F","arifle_TRG21_GL_F","arifle_TRG21_F","arifle_TRG20_F","arifle_SDAR_F","Rollins_F","SMG_01_F","SMG_02_F","hgun_PDW2000_F"];
A3EAI_machinegunList = ["LMG_Zafir_F","arifle_MX_SW_F","arifle_MX_SW_Black_F","LMG_Mk200_F","m249_EPOCH","m249Tan_EPOCH","MMG_01_hex_F","MMG_01_tan_F","MMG_02_camo_F","MMG_02_black_F","MMG_02_sand_F"];
A3EAI_sniperList = ["m107_EPOCH","m107Tan_EPOCH","srifle_DMR_02_F","srifle_DMR_02_camo_F","srifle_DMR_02_sniper_F","srifle_DMR_03_F","srifle_DMR_03_khaki_F","srifle_DMR_03_tan_F","srifle_DMR_03_multicam_F","srifle_DMR_03_woodland_F","srifle_DMR_03_spotter_F","srifle_DMR_04_F","srifle_DMR_04_Tan_F","srifle_DMR_05_blk_F","srifle_DMR_05_hex_F","srifle_DMR_05_tan_f","srifle_DMR_06_camo_F","srifle_DMR_06_olive_F","srifle_LRR_F","srifle_GM6_F","srifle_DMR_01_F","M14_EPOCH","M14Grn_EPOCH","srifle_EBR_F"];


//AI weapon scope attachment settings. Note: A3EAI_weaponOpticsList will not be read if A3EAI_dynamicOpticsList is enabled.
A3EAI_weaponOpticsList = ["optic_NVS","optic_SOS","optic_LRPS","optic_AMS","optic_AMS_khk","optic_AMS_snd","optic_KHS_blk","optic_KHS_hex","optic_KHS_old","optic_KHS_tan","optic_DMS","optic_Arco","optic_Hamr","Elcan_epoch","Elcan_reflex_epoch","optic_MRCO","optic_Holosight","optic_Holosight_smg","optic_Aco","optic_ACO_grn","optic_Aco_smg","optic_ACO_grn_smg","optic_Yorris","optic_MRD"];


//AI backpack types (for AI levels 0-3). Note: A3EAI_backpackTypes0-3 will not be read if A3EAI_dynamicBackpackList is enabled.
//------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
A3EAI_backpackTypes0 = ["B_AssaultPack_cbr", "B_AssaultPack_dgtl", "B_AssaultPack_khk", "B_AssaultPack_mcamo", "B_AssaultPack_ocamo", "B_AssaultPack_rgr", "B_AssaultPack_sgg", "B_Carryall_cbr", "B_Carryall_khk", "B_Carryall_mcamo", "B_Carryall_ocamo", "B_Carryall_oli", "B_Carryall_oucamo", "B_FieldPack_blk", "B_FieldPack_cbr", "B_FieldPack_khk", "B_FieldPack_ocamo", "B_FieldPack_oli", "B_FieldPack_oucamo", "B_Kitbag_cbr", "B_Kitbag_mcamo", "B_Kitbag_rgr", "B_Kitbag_sgg", "B_Parachute", "B_TacticalPack_blk", "B_TacticalPack_mcamo", "B_TacticalPack_ocamo", "B_TacticalPack_oli", "B_TacticalPack_rgr", "smallbackpack_red_epoch", "smallbackpack_green_epoch", "smallbackpack_teal_epoch", "smallbackpack_pink_epoch"];
A3EAI_backpackTypes1 = ["B_AssaultPack_cbr", "B_AssaultPack_dgtl", "B_AssaultPack_khk", "B_AssaultPack_mcamo", "B_AssaultPack_ocamo", "B_AssaultPack_rgr", "B_AssaultPack_sgg", "B_Carryall_cbr", "B_Carryall_khk", "B_Carryall_mcamo", "B_Carryall_ocamo", "B_Carryall_oli", "B_Carryall_oucamo", "B_FieldPack_blk", "B_FieldPack_cbr", "B_FieldPack_khk", "B_FieldPack_ocamo", "B_FieldPack_oli", "B_FieldPack_oucamo", "B_Kitbag_cbr", "B_Kitbag_mcamo", "B_Kitbag_rgr", "B_Kitbag_sgg", "B_Parachute", "B_TacticalPack_blk", "B_TacticalPack_mcamo", "B_TacticalPack_ocamo", "B_TacticalPack_oli", "B_TacticalPack_rgr", "smallbackpack_red_epoch", "smallbackpack_green_epoch", "smallbackpack_teal_epoch", "smallbackpack_pink_epoch"];
A3EAI_backpackTypes2 = ["B_AssaultPack_cbr", "B_AssaultPack_dgtl", "B_AssaultPack_khk", "B_AssaultPack_mcamo", "B_AssaultPack_ocamo", "B_AssaultPack_rgr", "B_AssaultPack_sgg", "B_Carryall_cbr", "B_Carryall_khk", "B_Carryall_mcamo", "B_Carryall_ocamo", "B_Carryall_oli", "B_Carryall_oucamo", "B_FieldPack_blk", "B_FieldPack_cbr", "B_FieldPack_khk", "B_FieldPack_ocamo", "B_FieldPack_oli", "B_FieldPack_oucamo", "B_Kitbag_cbr", "B_Kitbag_mcamo", "B_Kitbag_rgr", "B_Kitbag_sgg", "B_Parachute", "B_TacticalPack_blk", "B_TacticalPack_mcamo", "B_TacticalPack_ocamo", "B_TacticalPack_oli", "B_TacticalPack_rgr", "smallbackpack_red_epoch", "smallbackpack_green_epoch", "smallbackpack_teal_epoch", "smallbackpack_pink_epoch"];
A3EAI_backpackTypes3 = ["B_AssaultPack_cbr", "B_AssaultPack_dgtl", "B_AssaultPack_khk", "B_AssaultPack_mcamo", "B_AssaultPack_ocamo", "B_AssaultPack_rgr", "B_AssaultPack_sgg", "B_Carryall_cbr", "B_Carryall_khk", "B_Carryall_mcamo", "B_Carryall_ocamo", "B_Carryall_oli", "B_Carryall_oucamo", "B_FieldPack_blk", "B_FieldPack_cbr", "B_FieldPack_khk", "B_FieldPack_ocamo", "B_FieldPack_oli", "B_FieldPack_oucamo", "B_Kitbag_cbr", "B_Kitbag_mcamo", "B_Kitbag_rgr", "B_Kitbag_sgg", "B_Parachute", "B_TacticalPack_blk", "B_TacticalPack_mcamo", "B_TacticalPack_ocamo", "B_TacticalPack_oli", "B_TacticalPack_rgr", "smallbackpack_red_epoch", "smallbackpack_green_epoch", "smallbackpack_teal_epoch", "smallbackpack_pink_epoch"];


//AI vest types (for AI levels 0-3). Note: A3EAI_vestTypes0-3 will not be read if A3EAI_dynamicVestList is enabled.
//------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
A3EAI_vestTypes0 = ["V_1_EPOCH", "V_2_EPOCH", "V_3_EPOCH", "V_4_EPOCH", "V_5_EPOCH", "V_6_EPOCH", "V_7_EPOCH", "V_8_EPOCH", "V_9_EPOCH", "V_10_EPOCH", "V_11_EPOCH", "V_12_EPOCH", "V_13_EPOCH", "V_14_EPOCH", "V_15_EPOCH", "V_16_EPOCH", "V_17_EPOCH", "V_18_EPOCH", "V_19_EPOCH", "V_20_EPOCH", "V_21_EPOCH", "V_22_EPOCH", "V_23_EPOCH", "V_24_EPOCH", "V_25_EPOCH", "V_26_EPOCH", "V_27_EPOCH", "V_28_EPOCH", "V_29_EPOCH", "V_30_EPOCH", "V_31_EPOCH", "V_32_EPOCH", "V_33_EPOCH", "V_34_EPOCH", "V_35_EPOCH", "V_36_EPOCH", "V_37_EPOCH", "V_38_EPOCH", "V_39_EPOCH", "V_40_EPOCH"];
A3EAI_vestTypes1 = ["V_1_EPOCH", "V_2_EPOCH", "V_3_EPOCH", "V_4_EPOCH", "V_5_EPOCH", "V_6_EPOCH", "V_7_EPOCH", "V_8_EPOCH", "V_9_EPOCH", "V_10_EPOCH", "V_11_EPOCH", "V_12_EPOCH", "V_13_EPOCH", "V_14_EPOCH", "V_15_EPOCH", "V_16_EPOCH", "V_17_EPOCH", "V_18_EPOCH", "V_19_EPOCH", "V_20_EPOCH", "V_21_EPOCH", "V_22_EPOCH", "V_23_EPOCH", "V_24_EPOCH", "V_25_EPOCH", "V_26_EPOCH", "V_27_EPOCH", "V_28_EPOCH", "V_29_EPOCH", "V_30_EPOCH", "V_31_EPOCH", "V_32_EPOCH", "V_33_EPOCH", "V_34_EPOCH", "V_35_EPOCH", "V_36_EPOCH", "V_37_EPOCH", "V_38_EPOCH", "V_39_EPOCH", "V_40_EPOCH"];
A3EAI_vestTypes2 = ["V_1_EPOCH", "V_2_EPOCH", "V_3_EPOCH", "V_4_EPOCH", "V_5_EPOCH", "V_6_EPOCH", "V_7_EPOCH", "V_8_EPOCH", "V_9_EPOCH", "V_10_EPOCH", "V_11_EPOCH", "V_12_EPOCH", "V_13_EPOCH", "V_14_EPOCH", "V_15_EPOCH", "V_16_EPOCH", "V_17_EPOCH", "V_18_EPOCH", "V_19_EPOCH", "V_20_EPOCH", "V_21_EPOCH", "V_22_EPOCH", "V_23_EPOCH", "V_24_EPOCH", "V_25_EPOCH", "V_26_EPOCH", "V_27_EPOCH", "V_28_EPOCH", "V_29_EPOCH", "V_30_EPOCH", "V_31_EPOCH", "V_32_EPOCH", "V_33_EPOCH", "V_34_EPOCH", "V_35_EPOCH", "V_36_EPOCH", "V_37_EPOCH", "V_38_EPOCH", "V_39_EPOCH", "V_40_EPOCH"];
A3EAI_vestTypes3 = ["V_1_EPOCH", "V_2_EPOCH", "V_3_EPOCH", "V_4_EPOCH", "V_5_EPOCH", "V_6_EPOCH", "V_7_EPOCH", "V_8_EPOCH", "V_9_EPOCH", "V_10_EPOCH", "V_11_EPOCH", "V_12_EPOCH", "V_13_EPOCH", "V_14_EPOCH", "V_15_EPOCH", "V_16_EPOCH", "V_17_EPOCH", "V_18_EPOCH", "V_19_EPOCH", "V_20_EPOCH", "V_21_EPOCH", "V_22_EPOCH", "V_23_EPOCH", "V_24_EPOCH", "V_25_EPOCH", "V_26_EPOCH", "V_27_EPOCH", "V_28_EPOCH", "V_29_EPOCH", "V_30_EPOCH", "V_31_EPOCH", "V_32_EPOCH", "V_33_EPOCH", "V_34_EPOCH", "V_35_EPOCH", "V_36_EPOCH", "V_37_EPOCH", "V_38_EPOCH", "V_39_EPOCH", "V_40_EPOCH"];


//AI head gear types. Note: A3EAI_headgearTypes0-3 will not be read if A3EAI_dynamicHeadgearList is enabled.
A3EAI_headgearTypes0 = ["H_1_EPOCH","H_2_EPOCH","H_3_EPOCH","H_4_EPOCH","H_5_EPOCH","H_6_EPOCH","H_7_EPOCH","H_8_EPOCH","H_9_EPOCH","H_10_EPOCH","H_11_EPOCH","H_12_EPOCH","H_13_EPOCH","H_14_EPOCH","H_15_EPOCH","H_16_EPOCH","H_17_EPOCH","H_18_EPOCH","H_19_EPOCH","H_20_EPOCH","H_21_EPOCH","H_22_EPOCH","H_23_EPOCH","H_24_EPOCH","H_25_EPOCH","H_26_EPOCH","H_27_EPOCH","H_28_EPOCH","H_29_EPOCH","H_30_EPOCH","H_31_EPOCH","H_32_EPOCH","H_33_EPOCH","H_34_EPOCH","H_35_EPOCH","H_36_EPOCH","H_37_EPOCH","H_38_EPOCH","H_39_EPOCH","H_40_EPOCH","H_41_EPOCH","H_42_EPOCH","H_43_EPOCH","H_44_EPOCH","H_45_EPOCH","H_46_EPOCH","H_47_EPOCH","H_48_EPOCH","H_49_EPOCH","H_50_EPOCH","H_51_EPOCH","H_52_EPOCH","H_53_EPOCH","H_54_EPOCH","H_55_EPOCH","H_56_EPOCH","H_57_EPOCH","H_58_EPOCH","H_59_EPOCH","H_60_EPOCH","H_61_EPOCH","H_62_EPOCH","H_63_EPOCH","H_64_EPOCH","H_65_EPOCH","H_66_EPOCH","H_67_EPOCH","H_68_EPOCH","H_69_EPOCH","H_70_EPOCH","H_71_EPOCH","H_72_EPOCH","H_73_EPOCH","H_74_EPOCH","H_75_EPOCH","H_76_EPOCH","H_77_EPOCH","H_78_EPOCH","H_79_EPOCH","H_80_EPOCH","H_81_EPOCH","H_82_EPOCH","H_83_EPOCH","H_84_EPOCH","H_85_EPOCH","H_86_EPOCH","H_87_EPOCH","H_88_EPOCH","H_89_EPOCH","H_90_EPOCH","H_91_EPOCH","H_92_EPOCH","H_93_EPOCH","H_94_EPOCH","H_95_EPOCH","H_96_EPOCH","H_97_EPOCH","H_98_EPOCH","H_99_EPOCH","H_100_EPOCH","H_101_EPOCH","H_102_EPOCH","H_103_EPOCH","H_104_EPOCH"];
A3EAI_headgearTypes1 = ["H_1_EPOCH","H_2_EPOCH","H_3_EPOCH","H_4_EPOCH","H_5_EPOCH","H_6_EPOCH","H_7_EPOCH","H_8_EPOCH","H_9_EPOCH","H_10_EPOCH","H_11_EPOCH","H_12_EPOCH","H_13_EPOCH","H_14_EPOCH","H_15_EPOCH","H_16_EPOCH","H_17_EPOCH","H_18_EPOCH","H_19_EPOCH","H_20_EPOCH","H_21_EPOCH","H_22_EPOCH","H_23_EPOCH","H_24_EPOCH","H_25_EPOCH","H_26_EPOCH","H_27_EPOCH","H_28_EPOCH","H_29_EPOCH","H_30_EPOCH","H_31_EPOCH","H_32_EPOCH","H_33_EPOCH","H_34_EPOCH","H_35_EPOCH","H_36_EPOCH","H_37_EPOCH","H_38_EPOCH","H_39_EPOCH","H_40_EPOCH","H_41_EPOCH","H_42_EPOCH","H_43_EPOCH","H_44_EPOCH","H_45_EPOCH","H_46_EPOCH","H_47_EPOCH","H_48_EPOCH","H_49_EPOCH","H_50_EPOCH","H_51_EPOCH","H_52_EPOCH","H_53_EPOCH","H_54_EPOCH","H_55_EPOCH","H_56_EPOCH","H_57_EPOCH","H_58_EPOCH","H_59_EPOCH","H_60_EPOCH","H_61_EPOCH","H_62_EPOCH","H_63_EPOCH","H_64_EPOCH","H_65_EPOCH","H_66_EPOCH","H_67_EPOCH","H_68_EPOCH","H_69_EPOCH","H_70_EPOCH","H_71_EPOCH","H_72_EPOCH","H_73_EPOCH","H_74_EPOCH","H_75_EPOCH","H_76_EPOCH","H_77_EPOCH","H_78_EPOCH","H_79_EPOCH","H_80_EPOCH","H_81_EPOCH","H_82_EPOCH","H_83_EPOCH","H_84_EPOCH","H_85_EPOCH","H_86_EPOCH","H_87_EPOCH","H_88_EPOCH","H_89_EPOCH","H_90_EPOCH","H_91_EPOCH","H_92_EPOCH","H_93_EPOCH","H_94_EPOCH","H_95_EPOCH","H_96_EPOCH","H_97_EPOCH","H_98_EPOCH","H_99_EPOCH","H_100_EPOCH","H_101_EPOCH","H_102_EPOCH","H_103_EPOCH","H_104_EPOCH"];
A3EAI_headgearTypes2 = ["H_1_EPOCH","H_2_EPOCH","H_3_EPOCH","H_4_EPOCH","H_5_EPOCH","H_6_EPOCH","H_7_EPOCH","H_8_EPOCH","H_9_EPOCH","H_10_EPOCH","H_11_EPOCH","H_12_EPOCH","H_13_EPOCH","H_14_EPOCH","H_15_EPOCH","H_16_EPOCH","H_17_EPOCH","H_18_EPOCH","H_19_EPOCH","H_20_EPOCH","H_21_EPOCH","H_22_EPOCH","H_23_EPOCH","H_24_EPOCH","H_25_EPOCH","H_26_EPOCH","H_27_EPOCH","H_28_EPOCH","H_29_EPOCH","H_30_EPOCH","H_31_EPOCH","H_32_EPOCH","H_33_EPOCH","H_34_EPOCH","H_35_EPOCH","H_36_EPOCH","H_37_EPOCH","H_38_EPOCH","H_39_EPOCH","H_40_EPOCH","H_41_EPOCH","H_42_EPOCH","H_43_EPOCH","H_44_EPOCH","H_45_EPOCH","H_46_EPOCH","H_47_EPOCH","H_48_EPOCH","H_49_EPOCH","H_50_EPOCH","H_51_EPOCH","H_52_EPOCH","H_53_EPOCH","H_54_EPOCH","H_55_EPOCH","H_56_EPOCH","H_57_EPOCH","H_58_EPOCH","H_59_EPOCH","H_60_EPOCH","H_61_EPOCH","H_62_EPOCH","H_63_EPOCH","H_64_EPOCH","H_65_EPOCH","H_66_EPOCH","H_67_EPOCH","H_68_EPOCH","H_69_EPOCH","H_70_EPOCH","H_71_EPOCH","H_72_EPOCH","H_73_EPOCH","H_74_EPOCH","H_75_EPOCH","H_76_EPOCH","H_77_EPOCH","H_78_EPOCH","H_79_EPOCH","H_80_EPOCH","H_81_EPOCH","H_82_EPOCH","H_83_EPOCH","H_84_EPOCH","H_85_EPOCH","H_86_EPOCH","H_87_EPOCH","H_88_EPOCH","H_89_EPOCH","H_90_EPOCH","H_91_EPOCH","H_92_EPOCH","H_93_EPOCH","H_94_EPOCH","H_95_EPOCH","H_96_EPOCH","H_97_EPOCH","H_98_EPOCH","H_99_EPOCH","H_100_EPOCH","H_101_EPOCH","H_102_EPOCH","H_103_EPOCH","H_104_EPOCH"];
A3EAI_headgearTypes3 = ["H_1_EPOCH","H_2_EPOCH","H_3_EPOCH","H_4_EPOCH","H_5_EPOCH","H_6_EPOCH","H_7_EPOCH","H_8_EPOCH","H_9_EPOCH","H_10_EPOCH","H_11_EPOCH","H_12_EPOCH","H_13_EPOCH","H_14_EPOCH","H_15_EPOCH","H_16_EPOCH","H_17_EPOCH","H_18_EPOCH","H_19_EPOCH","H_20_EPOCH","H_21_EPOCH","H_22_EPOCH","H_23_EPOCH","H_24_EPOCH","H_25_EPOCH","H_26_EPOCH","H_27_EPOCH","H_28_EPOCH","H_29_EPOCH","H_30_EPOCH","H_31_EPOCH","H_32_EPOCH","H_33_EPOCH","H_34_EPOCH","H_35_EPOCH","H_36_EPOCH","H_37_EPOCH","H_38_EPOCH","H_39_EPOCH","H_40_EPOCH","H_41_EPOCH","H_42_EPOCH","H_43_EPOCH","H_44_EPOCH","H_45_EPOCH","H_46_EPOCH","H_47_EPOCH","H_48_EPOCH","H_49_EPOCH","H_50_EPOCH","H_51_EPOCH","H_52_EPOCH","H_53_EPOCH","H_54_EPOCH","H_55_EPOCH","H_56_EPOCH","H_57_EPOCH","H_58_EPOCH","H_59_EPOCH","H_60_EPOCH","H_61_EPOCH","H_62_EPOCH","H_63_EPOCH","H_64_EPOCH","H_65_EPOCH","H_66_EPOCH","H_67_EPOCH","H_68_EPOCH","H_69_EPOCH","H_70_EPOCH","H_71_EPOCH","H_72_EPOCH","H_73_EPOCH","H_74_EPOCH","H_75_EPOCH","H_76_EPOCH","H_77_EPOCH","H_78_EPOCH","H_79_EPOCH","H_80_EPOCH","H_81_EPOCH","H_82_EPOCH","H_83_EPOCH","H_84_EPOCH","H_85_EPOCH","H_86_EPOCH","H_87_EPOCH","H_88_EPOCH","H_89_EPOCH","H_90_EPOCH","H_91_EPOCH","H_92_EPOCH","H_93_EPOCH","H_94_EPOCH","H_95_EPOCH","H_96_EPOCH","H_97_EPOCH","H_98_EPOCH","H_99_EPOCH","H_100_EPOCH","H_101_EPOCH","H_102_EPOCH","H_103_EPOCH","H_104_EPOCH"];


//AI Food/Loot item types. 
// Note: A3EAI_foodLoot will not be read if A3EAI_dynamicFoodList is enabled.
// Note: A3EAI_miscLoot1 will not be read if A3EAI_dynamicLootList is enabled.
// Note: A3EAI_miscLoot2 will not be read if A3EAI_dynamicLootLargeList is enabled.
//------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
A3EAI_foodLoot = ["FoodSnooter","FoodWalkNSons","FoodBioMeat","ItemSodaOrangeSherbet","ItemSodaPurple","ItemSodaMocha","ItemSodaBurst","ItemSodaRbull","honey_epoch","emptyjar_epoch","sardines_epoch","meatballs_epoch","scam_epoch","sweetcorn_epoch","WhiskeyNoodle","ItemCoolerE"];
A3EAI_miscLoot1 = ["PaintCanClear","PaintCanBlk","PaintCanBlu","PaintCanBrn","PaintCanGrn","PaintCanOra","PaintCanPur","PaintCanRed","PaintCanTeal","PaintCanYel","ItemDocument","ItemMixOil","emptyjar_epoch","emptyjar_epoch","FoodBioMeat","ItemSodaOrangeSherbet","ItemSodaPurple","ItemSodaMocha","ItemSodaBurst","ItemSodaRbull","sardines_epoch","meatballs_epoch","scam_epoch","sweetcorn_epoch","Towelette","Towelette","Towelette","Towelette","Towelette","HeatPack","HeatPack","HeatPack","ColdPack","ColdPack","VehicleRepair","CircuitParts","ItemCoolerE","ItemScraps","ItemScraps"];
A3EAI_miscLoot2 = ["MortarBucket","MortarBucket","ItemCorrugated","CinderBlocks","jerrycan_epoch","jerrycan_epoch","VehicleRepair","VehicleRepair","CircuitParts"];


//AI toolbelt item types. Toolbelt items are added to AI inventory upon death. Format: [item classname, item probability]
//------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

A3EAI_tools0 = [
	["ItemWatch",0.70],["ItemCompass",0.50],["ItemMap",0.50],["ItemGPS",0.05],["EpochRadio0",0.05]
];
A3EAI_tools1 = [
	["ItemWatch",0.80],["ItemCompass",0.60],["ItemMap",0.60],["ItemGPS",0.10],["EpochRadio0",0.10]
];
A3EAI_tools2 = [
	["ItemWatch",0.80],["ItemCompass",0.70],["ItemMap",0.70],["ItemGPS",0.15],["EpochRadio0",0.15]
];
A3EAI_tools3 = [
	["ItemWatch",0.80],["ItemCompass",0.80],["ItemMap",0.80],["ItemGPS",0.20],["EpochRadio0",0.20]
];


//AI-useable toolbelt item types. These items are added to AI inventory at unit creation and may be used by AI. Format: [item classname, item probability]
//------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

A3EAI_gadgets0 = [
	["binocular",0.40],["NVG_EPOCH",0.05]
];
A3EAI_gadgets1 = [
	["binocular",0.50],["NVG_EPOCH",0.10]
];
A3EAI_gadgets2 = [
	["binocular",0.60],["NVG_EPOCH",0.15]
];
A3EAI_gadgets3 = [
	["binocular",0.70],["NVG_EPOCH",0.20]
];

//NOTHING TO EDIT BEYOND THIS POINT
diag_log "[A3EAI] A3EAI configuration file loaded.";
