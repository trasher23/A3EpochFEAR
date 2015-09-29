/*
	Spawn exploding barrels around buildings
	Reused code from  Epoch/Sources/epoch_code/compile/setup/EPOCH_masterLoop.sqf
	A random chance will reposition barrels near the player every 30 seconds
*/

Barrel_BOOM = compileFinal '
	_ex = createVehicle [
		"R_TBG32V_F",
		_this modeltoworld [0,0,0],
		[],
		0,
		"CAN_COLLIDE"
	];
	_ex setVectorDirAndUp [[0,0,1],[0,-1,0]];
	_ex setVelocity [0,0,-1000];
	deleteVehicle _this;
';

explodingBarrel = {
	private["_pos","_b","_direction"];
	
	_pos = ATLToASL (_this select 0);
		
	_b = createVehicle [
		"Land_MetalBarrel_F",
		[0,0,0],
		[],
		0,
		"NONE"
	];
	_b setDir (random 360);
	_b setPosASL _pos;
	
	// Position barrel upright or on side
	_direction = [0,90] call BIS_fnc_selectRandom;
	[_b,0,_direction] call BIS_fnc_setPitchBank;
			
	//_b setDamage 0.99;
	//_b allowDamage false;
	_b addEventHandler ["Hit", {
		_b = _this select 0;
		if (alive _b) then {_b setDamage 0.99};
	}];
	
	sleep 0.1;
	
	_b setVariable ["#PosASL", getPosASL _b];
	_b addEventHandler ["EpeContact", {
		_b = _this select 0;
		if (
			(getPosASL _b) distance (_b getVariable "#PosASL") > 0.1
		) then {_b call Barrel_BOOM};
	}];
	_b addEventHandler ["Killed", {_this select 0 call Barrel_BOOM}];
	_b allowDamage true;
	
	[format["exploding barrel spawned at %1",_pos]] call FEARserverLog;
};

buildings = [
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

lootBubble = {
	private["_pos","_others","_travelDir","_lootDist","_xPos","_yPos","_lootLoc","_playerPos","_distanceTraveled","_config"];
	
	_playerPos = getPosATL vehicle player;
	_distanceTraveled = FEAR_lastPlayerPos distance _playerPos;

	if (_distanceTraveled > 10 && _distanceTraveled < 200) then {
		
		_travelDir = [FEAR_lastPlayerPos, _playerPos] call BIS_fnc_dirTo;
		_lootDist = 30 + _distanceTraveled;
		_xPos = (_playerPos select 0) + (_lootDist * sin(_travelDir));
		_yPos = (_playerPos select 1) + (_lootDist * cos(_travelDir));
		_lootLoc = [_xPos, _yPos, 0];
		
		_objects = nearestObjects[_lootLoc, buildings, 30];
		
		// Is jammer in range?
		_config = 'CfgEpochClient' call EPOCH_returnConfig;
		_buildingJammerRange = getNumber(_config >> "buildingJammerRange");
		if (_buildingJammerRange == 0) then { _buildingJammerRange = 75; };
		_jammer = nearestObjects [_lootLoc, ["PlotPole_EPOCH"], _buildingJammerRange];
		if ((_jammer isEqualTo[]) && !(_objects isEqualTo[])) then {
			
			_building = _objects select(floor(random(count _objects)));		
			[format["exploding barrel spawned at %1",_building]] call FEARserverLog;			
			_pos = getPosATL _building;
			
			_others = _building nearEntities[["Epoch_Male_F", "Epoch_Female_F"], 15];
			
			if (_others isEqualTo[]) then {
				// random position from building _pos, this should place it outside
				_pos = [_pos,[10,20],random 360] call SHK_pos;
				// If water, exit
				if (surfaceIsWater _pos) exitwith {};
				// Spawn barrel at position
				[_pos] spawn explodingBarrel;
			};
			
		};
	};
	FEAR_lastPlayerPos = getPosATL vehicle player;
};

_explodingBarrelLoop = {
	private["_EPOCH_30","_tickTime"];
	
	["exploding barrel loop initialised"] call FEARserverLog;
	
	_EPOCH_30 = diag_tickTime;
	FEAR_lastPlayerPos = getPosATL vehicle player;
	
	// Start loop
	while {alive player} do {
		_tickTime = diag_tickTime;
		
		// 30 seconds
		if ((_tickTime - _EPOCH_30) > 30) then {

			_EPOCH_30 = _tickTime;
			// 33% chance of potential barrel spawn
			if (33 > random 100) then {
				call lootBubble;
			};
		};
		
		uiSleep 0.1;
	};
};

// Debug
//[[2661.84,4463.95,0]] spawn explodingBarrel;

[] spawn _explodingBarrelLoop;