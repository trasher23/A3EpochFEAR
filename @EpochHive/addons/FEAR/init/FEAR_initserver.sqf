/*
	FEAR Server Initialization File
	
	Description: Handles startup process for FEAR. Does not contain any values intended for modification.
*/
if (hasInterface || !isNil "FEAR_isActive") exitWith {};
FEAR_isActive = true;

private ["_startTime","_directoryAsArray"];

_startTime = diag_tickTime;

// Assign FEAR path to global
_directoryAsArray = toArray __FILE__;
_directoryAsArray resize ((count _directoryAsArray) - 25);
FEAR_directory = toString _directoryAsArray;

// Assign mission path to global
MISSION_directory = format ["mpmissions\__cur_mp.%1\", worldName];
publicVariable "MISSION_directory";

//Report FEAR version to RPT log
diag_log format ["[FEAR] Initializing FEAR version %1 using base path %2",[configFile >> "CfgPatches" >> "FEAR","FEARVersion","error - unknown version"] call BIS_fnc_returnConfigEntry,FEAR_directory];

//Load FEAR main configuration file & functions
call compile preprocessFileLineNumbers "@EpochHive\FEAR_config.sqf";
call compile preprocessFileLineNumbers format ["%1\scripts\FEAR_functions.sqf",FEAR_directory];

/* Server event handlers - called from clients
-----------------------------------------------
*/
// Client to Server logging
FEARserverLog = compile preprocessFileLineNumbers format ["%1\scripts\FEAR_serverLog.sqf",FEAR_directory];
"ServerLog" addPublicVariableEventHandler {_id = (_this select 1) spawn FEARserverLog};

// Spawn wolfpack
FEARwolfpackSpawn = compile preprocessFileLineNumbers format ["%1\scripts\FEAR_wolfpackSpawn.sqf",FEAR_directory];
"WolfpackSpawn" addPublicVariableEventHandler {_id = (_this select 1) spawn FEARwolfpackSpawn};

// Spawn demon
FEARdemonSpawn = compile preprocessFileLineNumbers format ["%1\scripts\FEAR_demonSpawn.sqf",FEAR_directory];
"DemonSpawn" addPublicVariableEventHandler {_id = (_this select 1) spawn FEARdemonSpawn};

/* Future map addons...
call compile preprocessFileLineNumbers format ["%1\maps\11Outposts.sqf",FEAR_directory];
*/

// Spawn random events
[] execVM format ["%1\nuke\FEAR_nuke_init.sqf",FEAR_directory]; // Mini-nukes
[] execVM format ["%1\scripts\FEAR_airCrashes.sqf",FEAR_directory]; // Air crashes
[] execVM format ["%1\scripts\FEAR_earthquakeTimer.sqf",FEAR_directory]; // Earthquakes
[] execVM format ["%1\scripts\FEAR_zombieTriggers.sqf",FEAR_directory]; // Zombie & Demon spawn triggers
[] execVM format ["%1\scripts\FEAR_spawnWrecks.sqf",FEAR_directory]; // Wrecks

diag_log format ["[FEAR] FEAR loading completed in %1 seconds",(diag_tickTime - _startTime)];