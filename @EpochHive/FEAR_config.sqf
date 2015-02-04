/*
  FEAR Configuration file
*/

diag_log "[FEAR] Reading FEAR configuration file.";

/* Nuke Settings
--------------------------------------------------
*/

// The minimum time in seconds before a cruise missile launch.
nukeTimerMin = 5; // minutes

// Maximum time in seconds before a cruise missile launch.
nukeTimerMax = 5;

// Blast radius in km
nukeRadius = 1000;

// Ground zero - total annihilation
groundZero = (nukeRadius / 2);

//NOTHING TO EDIT BEYOND THIS POINT
diag_log "[FEAR] FEAR configuration file loaded.";