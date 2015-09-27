/*
  FEAR Configuration file
*/

diag_log "[FEAR] reading FEAR configuration file";

/* Assign map centre and radius to global for use in scripts
-------------------------------------------------------------
*/
MapCentre = getArray (configFile >> "CfgWorlds" >> worldName >> "centerPosition"); // [6206.94,5920.05,0]; //Center of esseker
MapRadius = 12000; // Esseker radius

/* Nuke settings
--------------------------------------------------
*/
// The minimum time in seconds before a cruise missile launch.
NukeTimerMin = 30; // minutes
// Maximum time in seconds before a cruise missile launch.
NukeTimerMax = 90;
// Blast radius in km
NukeRadius = 1000;
// Ground zero - total annihilation
GroundZero = (NukeRadius / 2);

/* Earthquake settings
--------------------------------------------------
*/
EqTimerMin = 5;
EqTimerMax = 30;

diag_log "[FEAR] configuration file loaded";
