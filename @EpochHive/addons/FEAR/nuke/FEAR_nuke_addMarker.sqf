/* Adds a marker for nuke. Only runs once.
FEAR_nuke_markerLoop.sqf keeps this marker updated. */

// Public variable for markers
nukeMarkerCoords = _this select 0;

// Orange Zone
_nul = createMarker ["nukeMarkerO",nukeMarkerCoords];
"nukeMarkerO" setMarkerColor "ColorOrange";
"nukeMarkerO" setMarkerShape "ELLIPSE";
"nukeMarkerO" setMarkerBrush "Solid";
"nukeMarkerO" setMarkerSize [nukeRadius,nukeRadius];

// Red Zone
_nul = createMarker ["nukeMarkerR",nukeMarkerCoords];
"nukeMarkerR" setMarkerColor "ColorRed";
"nukeMarkerR" setMarkerShape "ELLIPSE";
"nukeMarkerR" setMarkerBrush "Solid";
"nukeMarkerR" setMarkerSize [groundZero,groundZero];

// Dot and name tag
_nul = createMarker ["nukeDot",nukeMarkerCoords];
"nukeDot" setMarkerColor "ColorBlack";
"nukeDot" setMarkerType "mil_dot";
"nukeDot" setMarkerText " Nuclear Strike";
