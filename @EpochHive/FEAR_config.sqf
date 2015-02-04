/*
  FEAR Configuration file
  Description: Contains all configurable settings of FEAR.
*/

diag_log "[FEAR] Reading FEAR configuration file.";

/* Nuke settings
----------------------------------------------------------------------------
*/

// The minimum time in seconds before a cruise missile launch.
// At least this much time will pass between launches.
nukeTimerMin = 5; // minutes

// Maximum time in seconds before a cruise missile launch.
// A cruise missile will always launch before this much time has passed.
nukeTimerMax = 5;

// Blast radius in km
nukeRadius = 1000;

// Ground zero - total annihilation
groundZero = nukeRadius / 2;

FEAR_Config_Loaded = true;
