/* 
	Reset markers
	Checks if a cruise missile has been launched and resets the marker for JIPs 
*/

if (!isDedicated) exitWith {};

// Start the timer
while {true} do
{	
	waitUntil {!isNil "nukeMarkerCoords"};
	
	// If the marker exists (meaning the mission is active) delete and re-add
	if (!(getMarkerColor "nukeMarkerO" == "")) then {
		deleteMarker "nukeMarkerO";
		deleteMarker "nukeMarkerR";
		deleteMarker "nukeDot";
		
		// Orange Zone
		_nul = createMarker ["nukeMarkerO",nukeMarkerCoords];
		"nukeMarkerO" setMarkerColor "ColorOrange";
		"nukeMarkerO" setMarkerShape "ELLIPSE";
		"nukeMarkerO" setMarkerBrush "Solid";
		"nukeMarkerO" setMarkerSize [NukeRadius,NukeRadius];
		
		// Red Zone
		_nul = createMarker ["nukeMarkerR",nukeMarkerCoords];
		"nukeMarkerR" setMarkerColor "ColorRed";
		"nukeMarkerR" setMarkerShape "ELLIPSE";
		"nukeMarkerR" setMarkerBrush "Solid";
		"nukeMarkerR" setMarkerSize [GroundZero,GroundZero];
		
		// Dot and name tag
		_nul = createMarker ["nukeDot",nukeMarkerCoords];
		"nukeDot" setMarkerColor "ColorBlack";
		"nukeDot" setMarkerType "mil_dot";
		"nukeDot" setMarkerText " Nuclear Strike";
		
		// Start siren
		_allPlayers = call FEARGetPlayers;
		{
			(owner (vehicle _x)) publicVariableClient "NUKESiren";
		}forEach _allPlayers;
	};
	
	// Radiation zone
	if (!(getMarkerColor "radMarkerR" == "")) then {
		deleteMarker "radMarkerR";
		deleteMarker "radMarkerY";
		
		// Radiation zone markers
		_nul = createMarker ["radMarkerR",nukeMarkerCoords];
		"radMarkerR" setMarkerColor "ColorRed";
		"radMarkerR" setMarkerShape "ELLIPSE";
		"radMarkerR" setMarkerBrush "Solid";
		"radMarkerR" setMarkerSize [NukeRadius,NukeRadius];

		_nul = createMarker ["radMarkerY",nukeMarkerCoords];
		"radMarkerY" setMarkerShape "Icon";
		"radMarkerY" setMarkerType "mil_dot";
		"radMarkerY" setMarkerColor "ColorYellow";
		"radMarkerY" setMarkerText "  Radiation Zone";
	};
	
	uisleep 23; // Duration of nuke siren
};
