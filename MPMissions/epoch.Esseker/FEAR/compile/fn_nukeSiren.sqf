private "_nukeSiren";

_nukeSiren = MISSION_directory + "FEAR\fx\" + "nukesiren.ogg";

// Log to RPT
["sounding nuke siren"] call FEARserverLog;

while {!isNil "NUKESiren"} do {
	playSound3D [_nukeSiren,player,false,(_this select 0),2];
	uisleep 23; // Length of siren sample to loop
};