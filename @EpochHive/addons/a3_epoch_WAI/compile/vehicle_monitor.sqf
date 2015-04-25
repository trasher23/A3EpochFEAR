if (isServer) then {

	private ["_veh","_mission","_player_present"];
	
	_veh = _this select 0;

	if (count _this == 2) then {
		_mission = _this select 1;
	} else {
		_mission = nil;
	};
	
	waitUntil { count crew _veh > 0};
	
	while {(alive _veh) && ({alive _x} count crew _veh > 0)} do {
		_veh setVehicleAmmo 1;
		_veh setFuel 1;
		if ({alive _x} count crew _veh == 0) then {
			_veh setDamage 1;
			_veh setVariable ["killedat", time];
		};
		sleep 1;
	};
	
	_veh setDamage 1;
	_veh setVariable ["killedat", time];

	waitUntil
	{
		sleep 1;
		// vehicle god mod when there is no players, AI is stupid drivers
		_veh allowdamage false;
		_player_present = false;
		{
			if((isPlayer _x) && (_x distance _veh <= 750)) exitWith { _player_present = true;_veh allowdamage true; };
			
		} count playableUnits;
		(!_player_present)
	};

	{
		deleteVehicle _x;
		if(debug_mode) then { diag_log("WAI: DELETE " + str(_x)); };
	} count (crew _veh) + [_veh];

};