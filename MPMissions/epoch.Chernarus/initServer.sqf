/*
	File: initServer.sqf
*/

if (isServer) then {
	// Loot Spawner http://forums.bistudio.com/showthread.php?165234-Lootspawner-configurable-building-loot-system
	fn_getBuildingstospawnLoot = compile preProcessFileLineNumbers "\FEAR\LSpawner\fn_LSgetBuildingstospawnLoot.sqf"; 
	LSdeleter = compile preProcessFileLineNumbers "\FEAR\LSpawner\LSdeleter.sqf";
	[] ExecVM "\FEAR\LSpawner\Lootspawner.sqf";
		
	[] ExecVM "\VEMF\init.sqf";			// Vampire missions
	[] ExecVM "\FEAR\dynamic_ups\init_ups.sqf";	// Urban Patrol http://kronzky.info/ups/
	[] ExecVM "\FEAR\nuke\NUKEInit.sqf"; 		// Nuke towns and cities
};
