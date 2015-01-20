// -------------
//	NUKE Siren
// -------------

private["_nukeSirenLength"];
_nukeSirenLength = 23;

while {(!isDedicated) && (true)} do {
	nukeSiren = false;
    	sleep 1;
	 
    	waitUntil {nukeSiren};
	
	while {!nukeDetonate} do {
		if (player distance nukeCoords < 4000) then {nukeCoords say3D "nukesiren"};
		sleep  _nukeSirenLength;
	};
	
	nukeSiren = false;
	publicVariable "nukeSiren";
};
