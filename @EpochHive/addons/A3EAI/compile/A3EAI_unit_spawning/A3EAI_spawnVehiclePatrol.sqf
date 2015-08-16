private ["_vehicleType", "_maxCargoUnits", "_maxGunnerUnits", "_unitLevel", "_isAirVehicle", "_vehiclePosition", "_spawnMode", "_keepLooking", "_error", "_unitType", "_unitGroup", "_driver", "_vehicle", "_direction", "_velocity", "_nearRoads", "_nextRoads", "_gunnersAdded", "_cargoSpots", "_cargo", "_waypoint", "_result", "_rearm","_combatMode","_behavior","_waypointCycle"];

_vehicleType = _this;

_maxCargoUnits = 0;
_maxGunnerUnits = 0;
_unitLevel = 0;
_isAirVehicle = (_vehicleType isKindOf "Air");
_vehiclePosition = [];
_spawnMode = "NONE";
_keepLooking = true;
_error = false;

call {
	if (_vehicleType isKindOf "Air") exitWith {
		//Note: no cargo units for air vehicles
		_maxGunnerUnits = A3EAI_heliGunnerUnits;
		_unitLevel = "airvehicle" call A3EAI_getUnitLevel;
		_vehiclePosition = [(getMarkerPos "A3EAI_centerMarker"),300 + (random((getMarkerSize "A3EAI_centerMarker") select 0)),random(360),1] call SHK_pos;
		_vehiclePosition set [2,200];
		_spawnMode = "FLY";
	};
	if (_vehicleType isKindOf "StaticWeapon") exitWith {_error = true};
	if (_vehicleType isKindOf "LandVehicle") exitWith {
		_maxGunnerUnits = A3EAI_vehGunnerUnits;
		_maxCargoUnits = A3EAI_vehCargoUnits;
		_unitLevel = "landvehicle" call A3EAI_getUnitLevel;
		while {_keepLooking} do {
			_vehiclePosition = [(getMarkerPos "A3EAI_centerMarker"),300 + random((getMarkerSize "A3EAI_centerMarker") select 0),random(360),0,[2,750],[25,_vehicleType]] call SHK_pos;
			if ((count _vehiclePosition) > 1) then {
				if ({isPlayer _x} count (_vehiclePosition nearEntities [["Epoch_Male_F","Epoch_Female_F","AllVehicles"], 300]) isEqualTo 0) then {
					_keepLooking = false;	//Found road position, stop searching
				};
			} else {
				if (A3EAI_debugLevel > 1) then {diag_log format ["A3EAI Debug: Unable to find road position to spawn AI %1. Retrying in 30 seconds.",_vehicleType]};
				uiSleep 30; //Couldnt find road, search again in 30 seconds.
			};
		};
	};
	_error = true;
};

if (_error) exitWith {diag_log format ["A3EAI Error: %1 attempted to spawn unsupported vehicle type %2.",__FILE__,_vehicleType]};

_unitType = if (_isAirVehicle) then {"air"} else {"land"};
_unitGroup = [_unitType] call A3EAI_createGroup;
_driver = [_unitGroup,_unitLevel,[0,0,0]] call A3EAI_createUnit;

_vehicle = createVehicle [_vehicleType, _vehiclePosition, [], 0, _spawnMode];
_driver moveInDriver _vehicle;

_vehicle call A3EAI_protectObject;
_vehicle call A3EAI_secureVehicle;
_vehicle call A3EAI_clearVehicleCargo;
_vehicle call A3EAI_randomizeVehicleColor;

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

//Setup group and crew
_nvg = _driver call A3EAI_addTempNVG;
_driver assignAsDriver _vehicle;
_driver setVariable ["isDriver",true];
_unitGroup selectLeader _driver;

_gunnersAdded = [_unitGroup,_unitLevel,_vehicle,_maxGunnerUnits] call A3EAI_addVehicleGunners;
if (A3EAI_debugLevel > 1) then {diag_log format ["A3EAI Debug: Spawned %1 gunner units for %2 vehicle %3.",_gunnersAdded,_unitGroup,_vehicleType];};

_cargoSpots = _vehicle emptyPositions "cargo";
for "_i" from 0 to ((_cargoSpots min _maxCargoUnits) - 1) do {
	_cargo = [_unitGroup,_unitLevel,[0,0,0]] call A3EAI_createUnit;
	_nvg = _cargo call A3EAI_addTempNVG;
	_cargo assignAsCargoIndex [_vehicle,_i];
	_cargo moveInCargo _vehicle;
};
if (A3EAI_debugLevel > 1) then {diag_log format ["A3EAI Debug: Spawned %1 cargo units for %2 vehicle %3.",(_cargoSpots min _maxCargoUnits),_unitGroup,_vehicleType]};

_unitGroup setBehaviour "AWARE";
_unitGroup setCombatMode "YELLOW";
_unitGroup allowFleeing 0;

_unitGroup setVariable ["unitLevel",_unitLevel];
_unitGroup setVariable ["assignedVehicle",_vehicle];
(units _unitGroup) allowGetIn true;

if (_isAirVehicle) then {
	if (A3EAI_removeExplosiveAmmo) then {
		_result = _vehicle call A3EAI_removeExplosive; //Remove missile weaponry for air vehicles
	};
	
	if ((({_x call A3EAI_checkIsWeapon} count (weapons _vehicle)) isEqualTo 0) && {({_x call A3EAI_checkIsWeapon} count (_vehicle weaponsTurret [-1])) isEqualTo 0} && {_gunnersAdded isEqualTo 0}) then {
		_unitGroup setBehaviour "CARELESS";
		_unitGroup setCombatMode "BLUE";
		if (A3EAI_debugLevel > 1) then {diag_log format ["A3EAI Debug: AI group %1 air vehicle %2 set to Careless behavior mode",_unitGroup,_vehicleType];};
	};
	
	_combatMode = (combatMode _unitGroup);
	_behavior = (behaviour (leader _unitGroup));

	[_unitGroup,0] setWPPos _vehiclePosition;
	[_unitGroup,0] setWaypointType "MOVE";
	[_unitGroup,0] setWaypointTimeout [0.5,0.5,0.5];
	[_unitGroup,0] setWaypointCompletionRadius 200;
	[_unitGroup,0] setWaypointStatements ["true","if !(local this) exitWith {}; [(group this)] spawn A3EAI_heliDetection;"];
	[_unitGroup,0] setWaypointCombatMode _combatMode;
	[_unitGroup,0] setWaypointBehaviour _behavior;
	[_unitGroup,0] setWaypointSpeed "FULL";

	_waypoint = _unitGroup addWaypoint [_vehiclePosition,0];
	_waypoint setWaypointType "MOVE";
	_waypoint setWaypointTimeout [3,6,9];
	_waypoint setWaypointCompletionRadius 150;
	_waypoint setWaypointStatements ["true","if !(local this) exitWith {}; [(group this)] spawn A3EAI_heliStartPatrol;"];
	_waypoint setWaypointCombatMode _combatMode;
	_waypoint setWaypointBehaviour _behavior;
	_waypoint setWaypointSpeed "LIMITED";
	
	_waypointCycle = _unitGroup addWaypoint [_vehiclePosition, 0];
	_waypointCycle setWaypointType "CYCLE";
	_waypointCycle setWaypointCompletionRadius 150;

	_unitGroup setVariable ["HeliLastParaDrop",diag_tickTime - A3EAI_paraDropCooldown];
	_vehicle flyInHeight (125 + (random 25));
	
	if ((!isNull _vehicle) && {!isNull _unitGroup}) then {
		A3EAI_curHeliPatrols = A3EAI_curHeliPatrols + 1;
		if (A3EAI_debugLevel > 0) then {diag_log format ["A3EAI Debug: Created AI helicopter crew group %1 is now active and patrolling.",_unitGroup];};
	};
} else {
	//Set initial waypoint and begin patrol
	[_unitGroup,0] setWaypointType "MOVE";
	[_unitGroup,0] setWaypointTimeout [5,10,15];
	[_unitGroup,0] setWaypointCompletionRadius 150;
	[_unitGroup,0] setWaypointStatements ["true","if !(local this) exitWith {}; [(group this)] spawn A3EAI_vehStartPatrol;"];
	
	if ((!isNull _vehicle) && {!isNull _unitGroup}) then {
		A3EAI_curLandPatrols = A3EAI_curLandPatrols + 1;
		if (A3EAI_debugLevel > 0) then {diag_log format ["A3EAI Debug: AI land vehicle crew group %1 is now active and patrolling.",_unitGroup];};
	};
};

/*
if (_isAirVehicle) then {
	[_unitGroup] spawn A3EAI_heliStartPatrol;
} else {
	[_unitGroup] spawn A3EAI_vehStartPatrol;
};
*/

[_unitGroup,0] setWaypointPosition [_vehiclePosition,0];
_unitGroup setCurrentWaypoint [_unitGroup,0];

_rearm = [_unitGroup,_unitLevel] spawn A3EAI_addGroupManager;	//start group-level manager

if (A3EAI_enableHC && {_unitType in A3EAI_HCAllowedTypes}) then {
	_unitGroup setVariable ["HC_Ready",true];
};

if (_unitType in A3EAI_airReinforcementAllowedTypes) then {
	_unitGroup setVariable ["ReinforceAvailable",true];
};

if (A3EAI_debugLevel > 1) then {diag_log format ["A3EAI Debug: Created AI vehicle patrol at %1 with vehicle type %2 with %3 crew units.",_vehiclePosition,_vehicleType,(count (units _unitGroup))]};

true
