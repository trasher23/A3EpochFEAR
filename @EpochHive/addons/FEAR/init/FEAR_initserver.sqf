/*
	FEAR Server Initialization File
	
	Description: Handles startup process for FEAR. Does not contain any values intended for modification.
*/
private ["_startTime","_directoryAsArray"];

if (hasInterface || !isNil "FEAR_isActive") exitWith {};
FEAR_isActive = true;

_startTime = diag_tickTime;

// Assign FEAR path to global
_directoryAsArray = toArray __FILE__;
_directoryAsArray resize ((count _directoryAsArray) - 25);
FEAR_directory = toString _directoryAsArray;

// Assign mission path to global
MISSION_directory = format["mpmissions\__cur_mp.%1\", worldName];
publicVariable "MISSION_directory";

//Report FEAR version to RPT log
diag_log format["[FEAR] initializing FEAR version %1 using base path %2",[configFile >> "CfgPatches" >> "FEAR","FEARVersion","error - unknown version"] call BIS_fnc_returnConfigEntry,FEAR_directory];

// Load FEAR configuration file
call compileFinal preprocessFileLineNumbers format["%1\FEAR_config.sqf",FEAR_directory];

// Server Functions
FEARGetPlayers = compileFinal preprocessFileLineNumbers format["%1\scripts\FEAR_getPlayers.sqf",FEAR_directory];
FEARBroadcast = compileFinal preprocessFileLineNumbers format["%1\scripts\FEAR_broadcast.sqf",FEAR_directory];
FEARZombieKilled = compileFinal preprocessFileLineNumbers format["%1\scripts\FEAR_zombieKilled.sqf",FEAR_directory];

/* Client to Server event handlers
-----------------------------------------------
*/
// Client to Server logging
FEARserverLog = compileFinal preprocessFileLineNumbers format["%1\scripts\FEAR_serverLog.sqf",FEAR_directory];
"ServerLog" addPublicVariableEventHandler {_id = (_this select 1) spawn FEARserverLog};

// Spawn wolfpack
FEARspawnWolfpack = compileFinal preprocessFileLineNumbers format["%1\scripts\FEAR_spawnWolfpack.sqf",FEAR_directory];
"SpawnWolfpack" addPublicVariableEventHandler {_id = (_this select 1) spawn FEARspawnWolfpack};

// Spawn exploding barrel
FEARspawnExplodingBarrel = compileFinal preprocessFileLineNumbers format["%1\scripts\FEAR_spawnExplodingBarrel.sqf",FEAR_directory];
"SpawnExplodingBarrel" addPublicVariableEventHandler {_id = (_this select 1) spawn FEARspawnExplodingBarrel};

// Spawn zombies
FEARspawnZombies = compileFinal preprocessFileLineNumbers format["%1\scripts\FEAR_spawnZombies.sqf",FEAR_directory];
"SpawnZombies" addPublicVariableEventHandler {_id = (_this select 1) spawn FEARspawnZombies};

/* Map addons
--------------------
*/
//call compile preprocessFileLineNumbers format["%1\map\FEAR_mapAddons.sqf",FEAR_directory];

/* Spawn random events
---------------------------
*/
[] execVM format["%1\nuke\FEAR_nuke_init.sqf",FEAR_directory]; // Mini-nukes
[] execVM format["%1\scripts\FEAR_airCrashes.sqf",FEAR_directory]; // Air crashes
[] execVM format["%1\scripts\FEAR_earthquakeTimer.sqf",FEAR_directory]; // Earthquakes
[] execVM format["%1\scripts\FEAR_zombieTriggers.sqf",FEAR_directory]; // Zombie & Demon spawn triggers
[] execVM format["%1\scripts\FEAR_spawnWrecks.sqf",FEAR_directory]; // Wrecks

diag_log format["[FEAR] FEAR loading completed in %1 seconds",(diag_tickTime - _startTime)];