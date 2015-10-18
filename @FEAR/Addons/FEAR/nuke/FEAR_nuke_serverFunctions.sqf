/*
	Purpose: Returns a random city/town as target site for the nuke blast.
*/

if(!isDedicated)exitWith{};

FEAR_fnc_nukeTarget = {
	private ["_allPlayers","_selectedPlayer","_towns","_town"];
	// Get players
	_allPlayers = call FEARGetPlayers;
	// Select random player
	_selectedPlayer = _allPlayers select(floor(random(count _allPlayers)));
	// Get town locations nearest selected player
	_towns = nearestLocations[getPosATL _selectedPlayer,["NameVillage","nameCity","NameCityCapital"],NukeRadius];
	// If no town selected, default to random choice
	if (_towns isEqualTo[]) then {_towns = nearestLocations [MapCentre,["NameVillage","nameCity","NameCityCapital"],MapRadius]};
	// Select a random town from array
	_town = _towns select(floor(random(count _towns)));
	_town
};

FEAR_fnc_nukeServerDamage = {
	private["_coords","_isCar","_direction","_burnObj"];

	_coords = _this select 0;

	// Entity damage
	{
		// Kill everything within GroundZero (half of NukeRadius)
		_x setDamage 1;
		uiSleep 0.1;
	}forEach (_coords nearEntities [["All"],GroundZero]);

	// Object damage
	{	
		// Flip vehicles
		_isCar = _x isKindOf "Car";
		if (_isCar) then {
			// Select random direction for flip
			// 0 = no flip
			// 90 = side
			// 180 = roof
			_direction = [0,90,180] call BIS_fnc_selectRandom;
			[_x,0,_direction] call BIS_fnc_setPitchBank;
		};
		
		// 80% of objects that will be completely destroyed within NukeRadius
		if (80 > random 100) then {    
			_x setDamage 1;
		} else {
			// The rest are set on fire
			_burnObj = "test_EmptyObjectForFireBig" createVehicle (position _x);
			_burnObj attachto[_x,[0,0,-1]];  
		};
		
		uiSleep 0.1;
	}forEach (nearestObjects [_coords,["house","Building","LandVehicle","Air","Ship"],NukeRadius]);
};

FEAR_fnc_nukeAddMarker = {
	/* Adds a marker for nuke. Only runs once.
	FEAR_nuke_markerLoop.sqf keeps this marker updated. */

	// Public variable for markers
	nukeMarkerCoords = _this select 0;

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
};

FEAR_fnc_radAddMarker = {
	/* Adds a marker for Radiation Zone. Only runs once.
	NUKEMarkerLoop.sqf keeps this marker updated. */
	
	if (isNil "nukeMarkerCoords") exitWith {};
	
	_nul = createMarker ["radMarkerR",nukeMarkerCoords];
	"radMarkerR" setMarkerColor "ColorRed";
	"radMarkerR" setMarkerShape "ELLIPSE";
	"radMarkerR" setMarkerBrush "Solid";
	"radMarkerR" setMarkerSize [NukeRadius, NukeRadius];

	_nul = createMarker ["radMarkerY",nukeMarkerCoords];
	"radMarkerY" setMarkerShape "Icon";
	"radMarkerY" setMarkerType "mil_dot";
	"radMarkerY" setMarkerColor "ColorYellow";
	"radMarkerY" setMarkerText "  Radiation Zone";
};

FEAR_fnc_nukeRadDamage = {	
	private["_coords","_result"];
	
	_coords = _this select 0;
	NUKEGeiger = "Land_HelipadEmpty_F" createVehicle _coords;
	_result = false;
	
	// Endurance of Radiation in air = 15 minutes = (180 mins * uiSleep 5)
	for [{_x = 0},{_x < 180},{_x = _x + 1}] do {
		{	
			// Damage
			if (isPlayer _x) then {
				_result = [_x] call FEAR_fnc_hasGasMask; // Wearing gas mask?
				(owner (vehicle _x)) publicVariableClient "NUKEGeiger"; // Geiger counter sound within radius
			};
			
			if (_result) then {
				// No damage
				_result = false;
			} else {
				_x setDammage (getDammage _x + 0.01);
			};
			
		}forEach (_coords nearEntities [["All"],NukeRadius]);

		uisleep 5;
	};
};

FEAR_fnc_hasGasMask = {
	private["_ret"];
	_player = _this select 0;
	_ret = false;
	if (goggles _player == "Mask_M50" or goggles _player == "Mask_M40" or goggles _player == "Mask_M40_OD" or goggles _player == "G_mas_wpn_gasmask") then {
		_ret = true;
	};
	_ret
};