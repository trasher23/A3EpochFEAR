while {!isNil "nukeSiren"} do {
	if (player distance nukeCoords < 4000) then {nukeCoords say3D "nukesiren"};
	sleep  23; // Length of siren sample to loop
};
