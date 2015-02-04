// Load functions
nukeTarget = compileFinal preprocessFileLineNumbers format ["%1\nuke\FEAR_nuke_functions.sqf",FEAR_directory];

// Start the missile launch countdown!
[] execVM format ["%1\nuke\FEAR_nuke_timer.sqf",FEAR_directory];

// Let's get the Marker Re-setter running for JIPs (Join In Progress) to stay updated
[] execVM format ["%1\nuke\FEAR_nuke_markerLoop.sqf",FEAR_directory];

diag_log "[nuke]: Initiating nuke.";
