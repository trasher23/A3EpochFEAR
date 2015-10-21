private ["_nukeSiren","_nukePos"];
	
// Log to RPT
["sounding nuke siren"] call FEARserverLog;

_nukeSiren = MISSION_directory + "FEAR\fx\" + "nukesiren.ogg";
_nukePos = _this select 0;

// 8 iterations is roughly 3 minutes
for "_x" from 1 to 8 do {
	playSound3D [_nukeSiren, player, false, _nukePos, 2];
	uisleep 23; // Length of siren sample to loop
};

NUKESiren = nil;