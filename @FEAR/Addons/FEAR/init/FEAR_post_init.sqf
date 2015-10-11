/*
	FEAR Startup
	Description: Handles post-initialization tasks
*/

/* Spawn random events
---------------------------
*/
[] execVM format["%1\nuke\FEAR_nuke_init.sqf",FEAR_directory]; // Mini-nukes
[] execVM format["%1\scripts\FEAR_airCrashes.sqf",FEAR_directory]; // Air crashes
[] execVM format["%1\scripts\FEAR_earthquakeTimer.sqf",FEAR_directory]; // Earthquakes
[] execVM format["%1\scripts\FEAR_zombieTriggers.sqf",FEAR_directory]; // Zombie & Demon spawn triggers
[] execVM format["%1\scripts\FEAR_spawnWrecks.sqf",FEAR_directory]; // Wrecks
[] execVM format["%1\map\FEAR_mapAddons.sqf",FEAR_directory]; // Map addons