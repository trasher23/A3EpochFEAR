/*
	Spawn items around buildings
	Reused code from  Epoch/Sources/epoch_code/compile/setup/EPOCH_masterLoop.sqf
	Calls server side code via public variable
*/

urbanLootBubble = {
	private["_buildings","_pos","_others","_travelDir","_lootDist","_xPos","_yPos","_lootLoc","_playerPos","_distanceTraveled","_config","_return"];
	
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
		
		_travelDir = [FEAR_lastPlayerPos, _playerPos] call BIS_fnc_dirTo;
		_lootDist = 30 + _distanceTraveled;
		_xPos = (_playerPos select 0) + (_lootDist * sin(_travelDir));
		_yPos = (_playerPos select 1) + (_lootDist * cos(_travelDir));
		_lootLoc = [_xPos, _yPos, 0];
		
		_objects = nearestObjects[_lootLoc, _buildings, 30];
		if !(_objects isEqualTo[]) then {
			// Is jammer in range?
			_config = 'CfgEpochClient' call EPOCH_returnConfig;
			_buildingJammerRange = getNumber(_config >> "buildingJammerRange");
			if (_buildingJammerRange == 0) then { _buildingJammerRange = 75; };
			_jammer = nearestObjects [_lootLoc, ["PlotPole_EPOCH"], _buildingJammerRange];
			// If jammer not in range and building in list is near...
			if (_jammer isEqualTo[]) then {
				// Choose random building from list
				_building = _objects select(floor(random(count _objects)));				
				_pos = getPosATL _building;
				// No other players nearby
				_others = _building nearEntities[["Epoch_Male_F", "Epoch_Female_F"], 15];
				if (_others isEqualTo[]) then {
					
					// random position from original building _pos, this should place it outside
					[[player,_pos,5,10]] call FEARgetRandomPosition;
					if (isNil "RandomPosition") exitWith {};
					_pos = RandomPosition;
					
					// If not water...
					if !(surfaceIsWater _pos) then { 
						_return = _pos;
					};
				};
			};
		};
	};
	
	FEAR_lastPlayerPos = getPosATL vehicle player;
	_return
};

_FEAR_masterLoop = {
	private["_FEAR_30","_FEAR_60","_tickTime","_pos"];
	
	["masterloop initialised"] call FEARserverLog;
	
	_FEAR_30 = diag_tickTime;
	_FEAR_60 = _FEAR_30; // Get current time from already assigned var
	_pos = nil;
	
	FEAR_lastPlayerPos = getPosATL vehicle player;
	
	// Start loop
	while {alive player} do {
		_tickTime = diag_tickTime;
		
		// Every 30 seconds
		if ((_tickTime - _FEAR_30) > 30) then {

			_FEAR_30 = _tickTime;

			_pos = call urbanLootBubble;
			If !(isNil "_pos") then {
				// 33% chance of potential barrel spawn
				if (33 > random 100) then {
					// Spawn exploding barrel at position
					[_pos] spawn FEARspawnExplodingBarrel;
				};
				
				// Spawn zombie trigger
				//[_pos] spawn FEARspawnZombies;
			};
		};
		
		// Every 60 seconds
		if ((_tickTime - _FEAR_60) > 60) then {

			_FEAR_60 = _tickTime;
			
		};
		
		uiSleep 0.1;
	};
};

// Debug
//[[2661.84,4463.95,0]] spawn FEARspawnExplodingBarrel;

[] spawn _FEAR_masterLoop;