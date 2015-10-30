/*
  FEAR Configuration file
*/

if (!isDedicated) exitWith {};

diag_log "[FEAR] reading FEAR configuration file";

/* Assign map centre and radius to global for use in scripts
-------------------------------------------------------------
*/
MapCentre = getArray (configFile >> "CfgWorlds" >> worldName >> "centerPosition");
MapRadius = 5700;

/* Nuke settings
--------------------------------------------------
*/
// The minimum time in seconds before a cruise missile launch.
NukeTimerMin = 3; // minutes
// Maximum time in seconds before a cruise missile launch.
NukeTimerMax = 3;
// Blast radius in km
NukeRadius = 500;
// Ground zero - total annihilation
GroundZero = (NukeRadius / 2);

/* Earthquake settings
--------------------------------------------------
*/
EqTimerMin = 5;
EqTimerMax = 30;

/*
VEMF mission radius gets sent to clients for increased zombie spawn
Needs array to store position for more than one mission
*/
FEARQuarantineLocs = [];
publicVariable "FEARQuarantineLocs"; // global used in clientLoop

/*
List of objects, used to delete if not near players
*/
FEARCleanup = [];

diag_log "[FEAR] configuration file loaded";

true // Config file run, return true