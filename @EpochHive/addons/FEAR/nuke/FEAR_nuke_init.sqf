// Load functions
nukeTarget = compileFinal preprocessFileLineNumbers format ["%1\nuke\FEAR_nuke_functions.sqf",FEAR_directory];

// Start the missile launch countdown!
_nukeTimer = [] execVM format ["%1\nuke\FEAR_nuke_timer.sqf",FEAR_directory];
waitUntil {uiSleep 0.05; scriptDone _nukeTimer};

// Let's get the Marker Re-setter running for JIPs (Join In Progress) to stay updated
_markerLoop = [] execVM format ["%1\nuke\FEAR_nuke_markerLoop.sqf",FEAR_directory];
waitUntil {uiSleep 0.05; scriptDone _markerLoop};

diag_log "[nuke]: Initiating nuke.";
