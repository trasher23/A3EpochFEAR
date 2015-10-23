/*
	FEAR Startup
	Description: Handles post-initialization tasks
*/
[] execVM format["%1\map\FEAR_mapAddons.sqf",FEAR_directory]; // Map addons
[] execVM format["%1\nuke\FEAR_nuke_init.sqf",FEAR_directory]; // Mini-nukes
[] execVM format["%1\scripts\FEAR_airCrashes.sqf",FEAR_directory]; // Air crashes
[] execVM format["%1\scripts\FEAR_zombieTriggers.sqf",FEAR_directory]; // Zombie & Demon spawn triggers
[] execVM format["%1\scripts\FEAR_spawnWrecks.sqf",FEAR_directory]; // Wrecks
[] execVM format["%1\scripts\FEAR_serverLoop.sqf",FEAR_directory]; // Server loop, clean up code, etc