// ------------------------------------------------
//	Adds a marker for NUKE. Only runs once.
//	NUKEMarkerLoop.sqf keeps this marker updated.
// ------------------------------------------------

nukeMarkerCoords = _this select 0;

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