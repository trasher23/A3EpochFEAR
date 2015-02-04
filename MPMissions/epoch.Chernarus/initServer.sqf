/*
	File: initServer.sqf
*/

if (isServer) then {

	[] execVM "\VEMF\init.sqf";			// Vampire Epoch Missions
	[] execVM "\FEAR\nuke\FEAR_nuke_init.sqf";	// Nuke
};
