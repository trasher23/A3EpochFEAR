/*
	FEAR Server Initialisation file
	Copied from A3EAI, coz that code rocks!
*/

if (hasInterface || !isNil "FEAR_isActive") exitWith {};
FEAR_isActive = true;

private ["_startTime","_directoryAsArray"];

_startTime = diag_tickTime;

_directoryAsArray = toArray __FILE__;
_directoryAsArray resize ((count _directoryAsArray) - 25);
FEAR_directory = toString _directoryAsArray;

// Assign mission path to global
MISSION_ROOT = format ["mpmissions\__cur_mp.%1\", worldName];

//Report FEAR version to RPT log
diag_log format ["[FEAR] Initializing FEAR version %1 using base path %2.",[configFile >> "CfgPatches" >> "FEAR","FEARVersion","error - unknown version"] call BIS_fnc_returnConfigEntry,FEAR_directory];

//Load FEAR main configuration file
call compile preprocessFileLineNumbers "@EpochHive\FEAR_config.sqf";

diag_log "check 1";
[] execVM format ['%1\nuke\FEAR_nuke_init.sqf',FEAR_directory]; // Nuke towns
diag_log "check 2";
