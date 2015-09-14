/*
	File: initServer.sqf
*/

if (isServer) then {
	[] execVM "\VEMF\init.sqf";			// Vampire Epoch Missions
	[] execVM "\SDROP\init.sqf";		// https://github.com/tdavison70/Helicopter-Supply-Drop
};
