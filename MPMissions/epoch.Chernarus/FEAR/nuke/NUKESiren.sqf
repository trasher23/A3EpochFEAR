// -----------
// NUKE Siren
// -----------

if (isServer) then {exitWith};

while {true} do {
	nukeSiren = false;
	publicVariable "nukeSiren";
	
    	sleep 1;
	 
    	waitUntil {nukeSiren};
	
	while {!nukeDetonate} do {
		if (player distance nukeCoords < 4000) then {nukeCoords say3D "nukesiren"};
		sleep  23; // Length of siren sample to loop
	};
	
	nukeSiren = false;
	publicVariable "nukeSiren";
};
