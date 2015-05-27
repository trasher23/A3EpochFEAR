private ["_marker","_vehicleType","_unitLevel","_unitGroup","_driver","_vehicle","_gunnerSpots","_spawnPos","_patrolDist","_isAirVehicle","_unitType","_vehiclePosition","_maxUnits","_maxCargoUnits","_maxGunnerUnits","_keepLooking","_gunnersAdded","_velocity","_direction"];

_spawnName = _this select 0;
_spawnPos = _this select 1;
_vehicleType = _this select 2;
_patrolDist = _this select 3;
_maxUnits = _this select 4;
_unitLevel = _this select 5;

_maxCargoUnits = _maxUnits select 0;
_maxGunnerUnits = _maxUnits select 1;
_isAirVehicle = (_vehicleType isKindOf "Air");
_vehiclePosition = [];
_roadSearching = 1; 	//SHK_pos will search for roads, and return random position if none found.
_waterPosAllowed = 0; 	//do not allow water position for land vehicles.
_spawnMode = "NONE";

if (_isAirVehicle) then {
	_roadSearching = 0;				//No need to search for road positions for air vehicles
	_waterPosAllowed = 1; 			//Allow water position for air vehicles
	_spawnMode = "FLY"; 			//set flying mode for air vehicles
	_vehiclePosition set [2,200]; 	//spawn air vehicles in air
	_spawnPos set [2,200]; 			//set marker height in air
	if !(_maxCargoUnits isEqualTo 0) then {_maxCargoUnits = 0}; //disable cargo units for air vehicles
};

_keepLooking = true;
_waitTime = 10;
while {_keepLooking} do {
	_vehiclePosition = [_spawnPos,random _patrolDist,random(360),_waterPosAllowed,[_roadSearching,200]] call SHK_pos;
	if (({if (isPlayer _x) exitWith {1}} count (_vehiclePosition nearEntities [["Epoch_Male_F","Epoch_Female_F","AllVehicles"],100])) isEqualTo 0) then {
		_keepLooking = false; //safe area found, continue to spawn the vehicle and crew
	} else {
		if (A3EAI_debugLevel > 0) then {diag_log format ["A3EAI Debug: Waiting %1 seconds for area at %2 to have no players nearby to spawn custom AI vehicle %3.",_waitTime,_marker,_vehicleType]};
		uiSleep _waitTime; //wait a while before checking spawn area again. Scaling wait time from 10-30 seconds.
		_waitTime = ((_waitTime + 5) min 60);
	};
};

_unitType = if (_isAirVehicle) then {"aircustom"} else {"landcustom"};
_unitGroup = [_unitType] call A3EAI_createGroup;
_driver = [_unitGroup,_unitLevel,[0,0,0]] call A3EAI_createUnit;

_vehicle = createVehicle [_vehicleType, _vehiclePosition, [], 0, _spawnMode];
_driver moveInDriver _vehicle;

_vehicle call A3EAI_protectObject;
_vehicle call A3EAI_secureVehicle;
_vehicle call A3EAI_clearVehicleCargo;

call {
	if (_vehicle isKindOf "Plane") exitWith {
		_direction = (random 360);
		_velocity = velocity _vehicle;
		_vehicle setDir _direction;
		_vehicle setVelocity [(_velocity select 1)*sin _direction - (_velocity select 0)*cos _direction, (_velocity select 0)*sin _direction + (_velocity select 1)*cos _direction, _velocity select 2];
	};
	if (_vehicle isKindOf "Helicopter") exitWith {
		_vehicle setDir (random 360);
	};
	if (_vehicle isKindOf "LandVehicle") exitWith {
		_nearRoads = _vehiclePosition nearRoads 100;
		if !(_nearRoads isEqualTo []) then {
			_nextRoads = roadsConnectedTo (_nearRoads select 0);
			if !(_nextRoads isEqualTo []) then {
				_direction = [_vehicle,(_nextRoads select 0)] call BIS_fnc_relativeDirTo;
				_vehicle setDir _direction;
				//diag_log format ["Debug: Reoriented vehicle %1 to direction %2.",_vehicle,_direction];
			};
		} else {
			_vehicle setDir (random 360);
		};
	};
};

//Set variables
_vehicle setVariable ["unitGroup",_unitGroup];

//Determine vehicle type and add needed eventhandlers
if (_isAirVehicle) then {
	_vehicle call A3EAI_addVehAirEH;
} else {
	_vehicle call A3EAI_addLandVehEH;
};
_vehicle allowCrewInImmobile (!_isAirVehicle);
_vehicle setUnloadInCombat [!_isAirVehicle,false];

_nvg = _driver call A3EAI_addTempNVG;
_driver assignAsDriver _vehicle;
_driver setVariable ["isDriver",true];
_unitGroup selectLeader _driver;

if (_isAirVehicle) then {_vehicle flyInHeight 115};

_gunnersAdded = [_unitGroup,_unitLevel,_vehicle,_maxGunnerUnits] call A3EAI_addVehicleGunners;
if (A3EAI_debugLevel > 1) then {diag_log format ["A3EAI Extended Debug: Spawned %1 gunner units for %2 vehicle %3.",_gunnersAdded,_unitGroup,_vehicleType];};

_cargoSpots = _vehicle emptyPositions "cargo";
for "_i" from 0 to ((_cargoSpots min _maxCargoUnits) - 1) do {
	_cargo = [_unitGroup,_unitLevel,[0,0,0]] call A3EAI_createUnit;
	_nvg = _cargo call A3EAI_addTempNVG;
	_cargo assignAsCargo _vehicle;
	_cargo moveInCargo [_vehicle,_i];
};
if (A3EAI_debugLevel > 1) then {diag_log format ["A3EAI Extended Debug: Spawned %1 cargo units for %2 vehicle %3.",(_cargoSpots min _maxCargoUnits),_unitGroup,_vehicleType]};
	
_unitGroup setBehaviour "AWARE";
_unitGroup setSpeedMode "NORMAL";
_unitGroup setCombatMode "YELLOW";
_unitGroup allowFleeing 0;

_unitGroup setVariable ["unitLevel",_unitLevel];
_unitGroup setVariable ["assignedVehicle",_vehicle];
_unitGroup setVariable ["spawnParams",_this];
[_unitGroup,0] setWaypointPosition [_spawnPos,0];		//Move group's initial waypoint position away from [0,0,0] (initial spawn position).
(units _unitGroup) allowGetIn true;

if (_isAirVehicle) then {
	if (A3EAI_removeMissileWeapons) then {
		_result = _vehicle call A3EAI_clearMissileWeapons; //Remove missile weaponry for air vehicles
	};
	
	if ((({_x call A3EAI_checkIsWeapon} count (weapons _vehicle)) isEqualTo 0) && {_gunnersAdded isEqualTo 0}) then {
		_unitGroup setBehaviour "CARELESS";
		_unitGroup setCombatMode "BLUE";
		if (A3EAI_debugLevel > 1) then {diag_log format ["A3EAI Extended Debug: AI group %1 air vehicle %2 set to Careless behavior mode",_unitGroup,_vehicleType];};
	};
	
	if ((!isNull _vehicle) && {!isNull _unitGroup}) then {
		A3EAI_curHeliPatrols = A3EAI_curHeliPatrols + 1;
		if (A3EAI_debugLevel > 1) then {diag_log format ["A3EAI Extended Debug: Custom AI helicopter crew group %1 is now active and patrolling.",_unitGroup];};
	};
} else {
	if ((!isNull _vehicle) && {!isNull _unitGroup}) then {
		A3EAI_curLandPatrols = A3EAI_curLandPatrols + 1;
		if (A3EAI_debugLevel > 1) then {diag_log format ["A3EAI Extended Debug: Custom AI land vehicle crew group %1 is now active and patrolling.",_unitGroup];};
	};
};

0 = [_unitGroup,_spawnPos,_patrolDist,false] spawn A3EAI_BIN_taskPatrol;
0 = [_unitGroup,_unitLevel] spawn A3EAI_addGroupManager;

if (A3EAI_enableHC && {_unitType in A3EAI_HCAllowedTypes}) then {
	_unitGroup setVariable ["HC_Ready",true];
};

if (_unitType in A3EAI_airReinforcementAllowedTypes) then {
	_unitGroup setVariable ["ReinforceAvailable",true];
};

if (A3EAI_debugLevel > 0) then {diag_log format ["A3EAI Debug: Created custom vehicle spawn at %1 with vehicle type %2 with %3 crew units.",_spawnName,_vehicleType,(count (units _unitGroup))]};

true
