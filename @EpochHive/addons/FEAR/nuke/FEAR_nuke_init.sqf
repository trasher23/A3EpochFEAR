// Load functions
nukeTarget = compileFinal preprocessFileLineNumbers format ["%1\nuke\FEAR_nuke_functions.sqf",FEAR_directory];

// Start the missile launch countdown!
[] ExecVM "\FEAR\nuke\FEAR_nuke_timer.sqf";

// Let's get the Marker Re-setter running for JIPs (Join In Progress) to stay updated
[] ExecVM "\FEAR\nuke\FEAR_nuke_markerLoop.sqf";

diag_log "[nuke]: Initiating nuke.";
