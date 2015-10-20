/*
	Spawn items around buildings
	Reused code from  Epoch/Sources/epoch_code/compile/setup/EPOCH_masterLoop.sqf
	Calls server side code via public variable
*/
InJammerRange = {
	private["_jammer","_pos","_ret"];
	_pos = _this select 0;
	_ret = false;
	_jammer = nearestObjects[_pos,["PlotPole_EPOCH"],500];
	if !(_jammer isEqualTo[]) then {_ret = true};
	_ret
};

InQuarantineRange = {
	private["_pos","_ret"];
	_pos = _this select 0;
	_ret = false;
	[format["FEARQuarantineLocs: %1",FEARQuarantineLocs]] call FEARserverLog;
	{
		if (_pos distance _x < 300) then {_ret = true};
	}forEach FEARQuarantineLocs;
	_ret
};

UrbanLootBubble = {
	private["_buildings","_pos","_others","_result","_travelDir","_lootDist","_xPos","_yPos","_lootLoc","_playerPos","_distanceTraveled","_ret"];
	
	_buildings = [
		"Land_A_GeneralStore_01",
		"Land_A_GeneralStore_01a",
		"Land_A_Hospital",
		"Land_A_Office01",
		"Land_A_Office02",
		"Land_Ind_Workshop01_01",
		"Land_Ind_Workshop01_02",
		"Land_Mil_ControlTower",
		"Land_Mil_Barracks_i",
		"Land_SS_hangar",
		"Land_a_stationhouse",
		"Land_stodola_old_open",
		"Land_stodola_open",
		"Land_Church_03",
		"Land_Church_03_dam",
		"housev_1i4",
		"Land_Panelak2",
		"Land_Farm_Cowshed_b",
		"Land_HouseV2_02_Interier",
		"Land_HouseV2_04_interier",
		"Land_A_Pub_01",
		"Land_HouseV_1I4",
		"Land_i_House_Small_01_V3_dam_F",
		"Land_Barn_Metal",
		"Land_Barn_W_01",
		"Land_Barn_W_02",
		"Land_Farm_Cowshed_b",
		"Land_Shed_Ind02",
		"Land_Tovarna2",
		"Land_Hangar_2",
		"Land_A_Stationhouse_ep1",
		"Land_Hangar_F"
	];
	
	_playerPos = getPosATL vehicle player;
	_distanceTraveled = FEAR_lastPlayerPos distance _playerPos;
	_return = nil; // Default return is nil position
	
	if (_distanceTraveled > 10 && _distanceTraveled < 200) then {
		
		_travelDir = [FEAR_lastPlayerPos,_playerPos] call BIS_fnc_dirTo;
		_lootDist = 30 + _distanceTraveled;
		_xPos = (_playerPos select 0) + (_lootDist * sin(_travelDir));
		_yPos = (_playerPos select 1) + (_lootDist * cos(_travelDir));
		_lootLoc = [_xPos,_yPos,0];
		
		// Is listed building nearby?
		_objects = nearestObjects[_lootLoc,_buildings,30];
		if !(_objects isEqualTo[]) then {
			// If jammer not in range and building in list nearby...
			_result = [_lootLoc] call InJammerRange;
			if !(_result) then {
				// Choose random building from list
				_building = _objects select(floor(random(count _objects)));				
				_pos = getPosATL _building;
				// Check no other players nearby
				_others = _building nearEntities[["Epoch_Male_F","Epoch_Female_F"], 15];
				if (_others isEqualTo[]) then {
					// random position from original building _pos, this should place it outside
					_pos = [_pos,[10,20],random 360] call SHK_pos;
					// If not water...
					if !(surfaceIsWater _pos) then { 
						_ret = _pos;
					};
				};
			};
		};
	};
	
	FEAR_lastPlayerPos = getPosATL vehicle player;
	_ret
};

_FEAR_clientLoop = {
	private["_FEAR_05","_FEAR_30","_FEAR_60","_tickTime","_pos","_posPlayer","_zombieCount","_result","_rspawnw","_spawnChance"];
	
	_FEAR_05 = diag_tickTime;
	_FEAR_30 = diag_tickTime;
	_FEAR_60 = diag_tickTime;
	_pos = nil;
	
	FEAR_lastPlayerPos = getPosATL vehicle player;
	_rspawnw = getMarkerPos "respawn_west";
		
	while {alive player} do {
		_tickTime = diag_tickTime;
		
		// Every 5 seconds
		if ((_tickTime - _FEAR_05) > 5) then {
			
			_FEAR_05 = _tickTime;
			
			// Gasmask breath sound
			_result = call FEAR_fnc_hasGasMask;
			if (_result) then {playsound3d ["A3\sounds_f\characters\human-sfx\other\diver-breath-2.wss",player,false,getposASL player,0.4,0.5,15]};
		};
		
		// Every 30 seconds
		if ((_tickTime - _FEAR_30) > 30) then {
			
			_FEAR_30 = _tickTime;
			
			_pos = call UrbanLootBubble;
			// If pos exists, player not in vehicle and not near respawn box
			If ((!isNil "_pos") && (vehicle player == player) && (player distance _rspawnw > 500)) then {
				// 40% chance
				if (40 > random 100) then {
					// Spawn exploding barrel at position
					[_pos] spawn FEARspawnExplodingBarrel;
					_pos = nil;
				};
			};
		};
		
		// Every 60 seconds
		if ((_tickTime - _FEAR_60) > 60) then {
			
			_FEAR_60 = _tickTime;
			_posPlayer = getPos Player;
			
			// Increase zombie spawn chance if in VEMF quarantine zone
			_result = [_posPlayer] call InQuarantineRange;
			if !(_result) then {
				_spawnChance = 20;
			} else {
				_spawnChance = 40; // Zombie infection!
			};
			
			//[format["spawn chance: %1",_spawnChance]] call FEARserverLog;
			
			// If Jammer not in range, player not in vehicle and not near respawn box
			_result = [_posPlayer] call InJammerRange;			
			If (!(_result) && (vehicle player == player) && (player distance _rspawnw > 500)) then {
				_pos = [_posPlayer,[40,100],random 360] call SHK_pos; // spawn within a 40-100m range from any direction
				// If pos 
				If (!isNil "_pos") then {
					if (_spawnChance > random 100) then {
						// Spawn zombies!
						_zombieCount = round(1 + random 4);
						[[_pos,_zombieCount]] spawn FEARspawnZombies;
						_pos = nil;
					};
				};
			};
		};
		uiSleep 0.1;
	};
};

// Debug
//[[2661.84,4463.95,0]] spawn FEARspawnExplodingBarrel;
[] spawn _FEAR_clientLoop;
["clientLoop initialised"] call FEARserverLog;