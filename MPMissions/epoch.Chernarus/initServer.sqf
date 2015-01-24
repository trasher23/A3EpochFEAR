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
	[] ExecVM "\FEAR_init_DAC.sqf"; // Spawn dynamic DAC Triggers on map
	DAC_Basic_Value = 0;[] ExecVM "\DAC\DAC_Config_Creator.sqf";	// DAC AI Generator http://forums.bistudio.com/showthread.php?176926-DAC-V3-1-%28Dynamic-AI-Creator%29-released/page18
	[] ExecVM "\FEAR\scripts\FEAR_init_DAC.sqf"; // Spawn dynamic DAC Triggers on map
	
};
