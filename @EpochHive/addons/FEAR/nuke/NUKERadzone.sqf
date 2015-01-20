// ----------------
//	Radiation Zone
// ----------------

if (isServer) then {
	Private ["_coords"];
	
	_coords = _this select 0;
	
	waitUntil {nukeRadZone};
	
	// Endurance of Radiation in air = 15 minutes = (180 mins * sleep 5)
	for [{_x = 0},{_x < 180},{_x = _x + 1}] do {
		{
			_x setDammage (getDammage _x + 0.01); // original value: 0.03
		} forEach (_coords nearEntities [["All"], nukeRadius]);
		sleep 5;
	};
	
	// Remove map markers
	deleteMarker "RADMarkerR";
	deleteMarker "RADMarkerY";
	
	nukeRadZone = False;
	publicVariable "nukeRadZone";
};
