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
diag_log format ["[FEAR] Initializing FEAR version %1 using base path %2.",[configFile >> "CfgPatches" >> "FEAR","FEARVersion","error - unknown version"] call BIS_fnc_returnConfigEntry,FEAR_directory];

//Load FEAR main configuration file
call compile preprocessFileLineNumbers "@EpochHive\FEAR_config.sqf";

//Continue loading required FEAR script files
//[] execVM format ["%1\nuke\FEAR_nuke_init.sqf",FEAR_directory];
[] execVM format ["%1\scripts\FEAR_earthquake_timer.sqf",FEAR_directory];

diag_log format ["[FEAR] FEAR loading completed in %1 seconds.",(diag_tickTime - _startTime)];
