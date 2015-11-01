if (!isDedicated) exitWith {};

// Load functions
call compileFinal preprocessFileLineNumbers format["%1\nuke\FEAR_nuke_serverFunctions.sqf",FEAR_directory];

// Start the missile launch countdown!
[] execVM format["%1\nuke\FEAR_nuke_timer.sqf",FEAR_directory];

// Let's get the Marker Re-setter running for JIPs (Join In Progress) to stay updated
[] execVM format["%1\nuke\FEAR_nuke_markerLoop.sqf",FEAR_directory];

diag_log "[FEAR] initiating nuke";