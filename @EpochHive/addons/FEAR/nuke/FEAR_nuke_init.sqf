nukeDetonate = false;
publicVariable "nukeDetonate";

// Load functions
call compile preprocessFile format ["%1\nuke\FEAR_nuke_functions.sqf",FEAR_Directory];

// Start the missile launch countdown!
[] execVM format ["%1\nuke\FEAR_nuke_timer.sqf",FEAR_Directory];

// Let's get the Marker Re-setter running for JIPs (Join In Progress) to stay updated
[] execVM format ["%1\nuke\FEAR_nuke_markerLoop.sqf",FEAR_Directory];

diag_log "[nuke]: Initiating nuke.";
