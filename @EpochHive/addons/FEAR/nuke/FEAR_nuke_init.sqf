if (!isServer) exitWith {};

// The minimum time in seconds before a cruise missile launch.
// At least this much time will pass between launches.
nukeTimerMin = 30; // minutes

// Maximum time in seconds before a cruise missile launch.
// A cruise missile will always launch before this much time has passed.
nukeTimerMax = 120;

// Blast radius in km
nukeRadius = 1000;

// Ground zero - total annihilation
groundZero = nukeRadius / 2;

nukeDetonate = false;
publicVariable "nukeDetonate";

// Load functions
call compile preprocessFileLineNumbers "\FEAR\nuke\FEAR_nuke_functions.sqf";

// Start the missile launch countdown!
[] ExecVM "\FEAR\nuke\FEAR_nuke_timer.sqf";

// Let's get the Marker Re-setter running for JIPs (Join In Progress) to stay updated
[] ExecVM "\FEAR\nuke\FEAR_nuke_markerLoop.sqf";

diag_log "[nuke]: Initiating nuke.";
