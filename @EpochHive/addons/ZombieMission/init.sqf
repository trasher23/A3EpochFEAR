[] spawn {
	spawnedZombies = [];
	{
		[_x] spawn {
			private ["_pos","_numPlayers","_marker","_numCaManBase","_trigger","_null","_aiGroup","_playerCount","_deactivation","_coords","_num","_ai","_skins","_selectedSkin"];
			_marker = _this select 0;
			_pos = getpos _marker;
			_aiGroup = ObjNull;
			_aiGroup = createGroup RESISTANCE;	
			while {true} do {
				_numCaManBase = _pos nearEntities ["Man",300];
				_playerCount = {isPlayer _x} count _numCaManBase;
				if ( (_playerCount > 0) && !(_pos in spawnedZombies)) then {
					//[_aiGroup, _pos] call activateZone;
					spawnedZombies = spawnedZombies + [_pos];
					diag_log format["Added %1 - Spawned Zombies: %2",_pos,spawnedZombies];
					_num = 0;
					while {_num < 5} do {
						_coords = [_pos,5,150,5,0,50,0] call BIS_fnc_findSafePos;
						_num = _num + 1;
						//_ai = ObjNull;
						_skins = ["C_man_1","C_man_1_1_F","C_man_1_2_F","C_man_1_3_F","C_man_polo_1_F_afro","C_man_polo_1_F_euro","C_man_polo_1_F_asia","C_man_polo_2_F","C_man_polo_2_F_afro","C_man_polo_4_F","C_man_polo_6_F_afro","C_man_p_fugitive_F","C_man_w_worker_F","C_scientist_F","C_man_hunter_1_F","C_journalist_F","C_Orestes","C_Nikos","C_Nikos_aged","C_Marshal_F"];
						_selectedSkin = _skins call BIS_fnc_selectRandom;
						//"Epoch_Sapper_F" createUnit [_coords, _aiGroup, "_ai = this", .1, "PRIVATE"];
						"b_g_survivor_F" createUnit [_coords, _aiGroup, '[this] execVM "zombie\shaun.sqf"', .1, "PRIVATE"];
						//diag_log format["Spawned Zombie %1: %3 @ %2",_num,_pos,_ai];
					};
				} else {
					sleep 1;
					if ( (_playerCount < 1) && (_pos in spawnedZombies) ) then {
						spawnedZombies = spawnedZombies - [_pos];
						//diag_log format["Removed %1 - Spawned Zombies: %2",_pos,spawnedZombies];
						{ 
							deleteVehicle _x;
							//diag_log format["Deleted Zombie %1 @ %2",_ai,_pos];
						} forEach units _aiGroup;
						_aiGroup = createGroup RESISTANCE;
					};
				};
				sleep 1;
			};
		};
		sleep .01;
	} foreach (nearestLocations [getArray (configFile >> "CfgWorlds" >> worldName >> "centerPosition"), ["NameCityCapital","NameCity","NameVillage","CityCenter"], 30000]);
};