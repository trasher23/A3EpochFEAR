// ------------------------------------------------
//	Adds a marker for Radiation Zone. Only runs once.
//	NUKEMarkerLoop.sqf keeps this marker updated.
// ------------------------------------------------

_nul = createMarker ["RADMarkerR",nukeMarkerCoords];
"RADMarkerR" setMarkerColor "ColorRed";
"RADMarkerR" setMarkerShape "ELLIPSE";
"RADMarkerR" setMarkerBrush "Solid";
"RADMarkerR" setMarkerSize [nukeRadius, nukeRadius];

_nul = createMarker ["RADMarkerY",nukeMarkerCoords];
"RADMarkerY" setMarkerShape "Icon";
"RADMarkerY" setMarkerType "Dot";
"RADMarkerY" setMarkerColor "ColorYellow";
"RADMarkerY" setMarkerText "  Radiation Zone";