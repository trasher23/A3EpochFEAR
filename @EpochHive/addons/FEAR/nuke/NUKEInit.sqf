// ----------------------------------------------------------------------------
//	NUKE Initialise
//	These scripts are based around the EMS 3.0 mission scripts by Vampire
// ----------------------------------------------------------------------------

if (!isServer) exitWith {};

// The minimum time in seconds before a cruise missile launch.
// At least this much time will pass between launches.
NUKETimerMin = 240; // 30 minutes: 1800

// Maximum time in seconds before a cruise missile launch.
// A cruise missile will always launch before this much time has passed.
NUKETimerMax = 240; // 1.5 hours: 5400

// Blast radius in km
nukeRadius = 1000;

// Ground zero - total annihilation
groundZero = nukeRadius / 2;

nukeDetonate = false;
publicVariable "nukeDetonate";

// Load functions
call compile preprocessFileLineNumbers "\FEAR\NUKE\NUKEFunctions.sqf";

// Start the missile launch countdown!
execVM "\FEAR\NUKE\NUKETimer.sqf";

// Let's get the Marker Re-setter running for JIPs (Join In Progress) to stay updated
execVM "\FEAR\NUKE\NUKEMarkerLoop.sqf";

diag_log "[NUKE]: Initiating NUKE.";
