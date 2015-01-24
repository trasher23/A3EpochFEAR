/*
	File: initServer.sqf
*/

if (isServer) then {
	
	// Loot Spawner http://forums.bistudio.com/showthread.php?165234-Lootspawner-configurable-building-loot-system
	fn_getBuildingstospawnLoot = compile preProcessFileLineNumbers "\LSpawner\fn_LSgetBuildingstospawnLoot.sqf"; 
	LSdeleter = compile preProcessFileLineNumbers "\LSpawner\LSdeleter.sqf";
	[] ExecVM "\LSpawner\Lootspawner.sqf";
		
	[] ExecVM "\VEMF\init.sqf";			// Vampire missions
	[] ExecVM "\FEAR\nuke\FEAR_nuke_init.sqf"; 	// Nuke towns and cities
	[] ExecVM "\FEAR\scripts\FEAR_init_DAC.sqf"; // Spawn dynamic DAC Triggers on map
	
};
