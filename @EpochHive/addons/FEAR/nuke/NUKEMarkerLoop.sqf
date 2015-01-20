// -------------------------------------------------------------------------------
//	Reset markers
//	Checks if a cruise missile has been launched and resets the marker for JIPs
// -------------------------------------------------------------------------------

// Start the timer
while {true} do
{
	sleep 25;
	// If the marker exists (meaning the mission is active) delete and re-add
	if (!(getMarkerColor "NUKEMarkerO" == "")) then {
		
		deleteMarker "NUKEMarkerO";
		deleteMarker "NUKEMarkerR";
		deleteMarker "NUKEDot";
		
		// Orange Zone
		_nul = createMarker ["NUKEMarkerO",nukeMarkerCoords];
		"NUKEMarkerO" setMarkerColor "ColorOrange";
		"NUKEMarkerO" setMarkerShape "ELLIPSE";
		"NUKEMarkerO" setMarkerBrush "Solid";
		"NUKEMarkerO" setMarkerSize [nukeRadius,nukeRadius];
		
		// Red Zone
		_nul = createMarker ["NUKEMarkerR",nukeMarkerCoords];
		"NUKEMarkerR" setMarkerColor "ColorRed";
		"NUKEMarkerR" setMarkerShape "ELLIPSE";
		"NUKEMarkerR" setMarkerBrush "Solid";
		"NUKEMarkerR" setMarkerSize [groundZero,groundZero];
		
		// Dot and name tag
		_nul = createMarker ["NUKEDot",nukeMarkerCoords];
		"NUKEDot" setMarkerColor "ColorBlack";
		"NUKEDot" setMarkerType "mil_dot";
		"NUKEDot" setMarkerText " Nuclear Strike";
		
	};
	
	// Radiation zone
	if (!(getMarkerColor "RADMarkerR" == "")) then {
		
		deleteMarker "RADMarkerR";
		deleteMarker "RADMarkerY";
		
		// Radiation zone markers
		_nul = createMarker ["RADMarkerR",nukeMarkerCoords];
		"RADMarkerR" setMarkerColor "ColorRed";
		"RADMarkerR" setMarkerShape "ELLIPSE";
		"RADMarkerR" setMarkerBrush "Solid";
		"RADMarkerR" setMarkerSize [nukeRadius,nukeRadius];

		_nul = createMarker ["RADMarkerY",nukeMarkerCoords];
		"RADMarkerY" setMarkerShape "Icon";
		"RADMarkerY" setMarkerType "Dot";
		"RADMarkerY" setMarkerColor "ColorYellow";
		"RADMarkerY" setMarkerText "  Radiation Zone";
		
	};
};