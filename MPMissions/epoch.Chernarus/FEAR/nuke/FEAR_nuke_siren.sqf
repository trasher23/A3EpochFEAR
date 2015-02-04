private ["_nukeSiren"];

_nukeSiren = MISSION_directory + "FEAR\fx\" + "nukesiren.ogg";

while {true} do {
	nukeSiren = false;
	publicVariable "nukeSiren";
	
	sleep 1;
 
	waitUntil {nukeSiren};
	
	for [{_i=0}, {_i<8}, {_i=_i+1}] do {
		if (player distance nukeCoords < 4000) then { playSound3D [_nukeSiren, player, false, nukeCoords]; };
		sleep  23; // Length of siren sample to loop
	};
	
	nukeSiren = false;
	publicVariable "nukeSiren";
};
