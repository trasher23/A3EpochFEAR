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

// Load functions
nukeTarget = compileFinal preprocessFileLineNumbers format ["%1\nuke\FEAR_nuke_functions.sqf",FEAR_Directory];

// Start the missile launch countdown!
[] execVM format ["%1\nuke\FEAR_nuke_timer.sqf",FEAR_Directory];

// Let's get the Marker Re-setter running for JIPs (Join In Progress) to stay updated
[] execVM format ["%1\nuke\FEAR_nuke_markerLoop.sqf",FEAR_Directory];

diag_log "[nuke]: Initiating nuke.";
