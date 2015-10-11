/*
	FEAR Server Initialization File
	Description: Handles startup process for FEAR. Does not contain any values intended for modification.
*/
if (hasInterface || !isDedicated ||!isNil "FEAR_isActive") exitWith {};

_startTime = diag_tickTime;

FEAR_isActive = true;

private ["_startTime","_directoryAsArray"];

/*
// Assign FEAR path to global
_directoryAsArray = toArray __FILE__;
_directoryAsArray resize ((count _directoryAsArray) - 25);
FEAR_directory = toString _directoryAsArray;
*/
FEAR_directory = "FEAR"; //PREFIX

// Assign mission path to global
MISSION_directory = format["mpmissions\__cur_mp.%1\", worldName];
publicVariable "MISSION_directory";

//Report FEAR version to RPT log
diag_log format["[FEAR] initializing FEAR version %1 using base path %2",[configFile >> "CfgPatches" >> "FEAR","FEARVersion","error - unknown version"] call BIS_fnc_returnConfigEntry,FEAR_directory];

// Load FEAR functions
_functionsCheck = call compile preprocessFileLineNumbers format ["%1\init\FEAR_functions.sqf",FEAR_directory];
if (isNil "_functionsCheck") exitWith {diag_log "FEAR Critical Error: Functions not successfully loaded. Stopping startup procedure.";};

// Load FEAR configuration file
_configCheck = call compile preprocessFileLineNumbers format["%1\FEAR_config.sqf",FEAR_directory];
if (isNil "_configCheck") exitWith {diag_log "FEAR Critical Error: Configuration file not successfully loaded. Stopping startup procedure.";};

//Continue loading required FEAR script files
[] execVM format ['%1\init\FEAR_post_init.sqf',FEAR_directory];

diag_log format["[FEAR] FEAR loading completed in %1 seconds",(diag_tickTime - _startTime)];