/* Adds a marker for Radiation Zone. Only runs once.
NUKEMarkerLoop.sqf keeps this marker updated. */

_nul = createMarker ["radMarkerR",nukeMarkerCoords];
"radMarkerR" setMarkerColor "ColorRed";
"radMarkerR" setMarkerShape "ELLIPSE";
"radMarkerR" setMarkerBrush "Solid";
"radMarkerR" setMarkerSize [nukeRadius, nukeRadius];

_nul = createMarker ["radMarkerY",nukeMarkerCoords];
"radMarkerY" setMarkerShape "Icon";
"radMarkerY" setMarkerType "mil_dot";
"radMarkerY" setMarkerColor "ColorYellow";
"radMarkerY" setMarkerText "  Radiation Zone";
