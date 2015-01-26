/*
	File: initServer.sqf
*/

if (isServer) then {
		
	[] ExecVM "\VEMF\init.sqf";						// Vampire Epoch Missions
	[] ExecVM "\FEAR\nuke\FEAR_nuke_init.sqf";		// Nuke towns
	[] execVM "\ZombieMission\init.sqf"; 	// Zombies
};
