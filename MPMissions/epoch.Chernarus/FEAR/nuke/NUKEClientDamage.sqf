// -----------------------------
//	Nuke blast damage - Client
// -----------------------------

if (!isDedicated) then {
	private["_isinbuilding","_building"];
	
	_isinbuilding = false;
	_building = nearestObject [player, "Building"];
	
	if([player,_building] call fnc_isInsideBuilding) then {_isinbuilding = true};

	// If player is within nukeRadius and not in a building, then instant death
	if ((player distance nukeCoords < nukeRadius) && (!_isinbuilding)) then {
		player setDamage 1;
	};

	// If player is within nukeRadius and in a building, then incur heavy damage
	if ((player distance nukeCoords < nukeRadius) && (_isinbuilding)) then {
		r_player_timeout = 15;
		r_player_unconscious = true;
		r_player_injured = true;
		r_player_blood = 6000;
		player setVariable ["medForceUpdate",true,true];
		player setVariable ["unconsciousTime", r_player_timeout, true];
	};
};