private ["_vehicleType", "_maxGunnerUnits", "_unitLevel", "_isAirVehicle", "_vehiclePosition", "_spawnMode", "_keepLooking", "_error", "_playerNear", "_unitType", "_unitGroup", "_driver", "_vehicle", "_direction", "_velocity", "_nearRoads", "_nextRoads", "_detectionStatement", "_patrolStatement", "_gunnersAdded", "_waypoint", "_rearm","_combatMode","_behavior"];

_vehicleType = _this;

_maxGunnerUnits = 5;
_unitLevel = 0;
_isAirVehicle = (_vehicleType isKindOf "Air");
_vehiclePosition = [];
_spawnMode = "NONE";
_keepLooking = true;
_error = false;

call {
	if (([configFile >> "CfgVehicles" >> _vehicleType,"vehicleClass",""] call BIS_fnc_returnConfigEntry) != "Autonomous") exitWith {_error = true};
	if (_vehicleType isKindOf "Air") exitWith {
		//Note: no cargo units for air vehicles
		_unitLevel = "uav" call A3EAI_getUnitLevel;
		_vehiclePosition = [(getMarkerPos "A3EAI_centerMarker"),300 + (random((getMarkerSize "A3EAI_centerMarker") select 0)),random(360),1] call SHK_pos;
		_vehiclePosition set [2,200];
		_spawnMode = "FLY";
	};
	if (_vehicleType isKindOf "StaticWeapon") exitWith {_error = true};
	if (_vehicleType isKindOf "LandVehicle") exitWith {
		_unitLevel = "ugv" call A3EAI_getUnitLevel;
		while {_keepLooking} do {
			_vehiclePosition = [(getMarkerPos "A3EAI_centerMarker"),300 + random((getMarkerSize "A3EAI_centerMarker") select 0),random(360),0,[2,750],[25,_vehicleType]] call SHK_pos;
			if ((count _vehiclePosition) > 1) then {
				_playerNear = ({isPlayer _x} count (_vehiclePosition nearEntities [["Epoch_Male_F","Epoch_Female_F","AllVehicles"], 300]) > 0);
				if(!_playerNear) then {
					_keepLooking = false;	//Found road position, stop searching
				};
			} else {
				if (A3EAI_debugLevel > 0) then {diag_log format ["A3EAI Debug: Unable to find road position to spawn AI %1. Retrying in 30 seconds.",_vehicleType]};
				uiSleep 30; //Couldnt find road, search again in 30 seconds.
			};
		};
	};
	_error = true;
};

if (_error) exitWith {diag_log format ["A3EAI Error: %1 attempted to spawn unsupported vehicle type %2.",__FILE__,_vehicleType]};

_unitType = if (_isAirVehicle) then {"uav"} else {"ugv"};

_vehicle = createVehicle [_vehicleType, _vehiclePosition, [], 0, _spawnMode];
createVehicleCrew _vehicle;
_vehicle setAutonomous true;
_unitGroup = [(group ((crew _vehicle) select 0)),_unitType] call A3EAI_initUVGroup;

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
	_vehicle call A3EAI_addUAVEH;
} else {
	_vehicle call A3EAI_addUGVEH;
};

_unitGroup setBehaviour "AWARE";
_unitGroup setCombatMode "YELLOW";
_unitGroup setSpeedMode "NORMAL";
_unitGroup allowFleeing 0;

_unitGroup setVariable ["unitLevel",_unitLevel];
_unitGroup setVariable ["assignedVehicle",_vehicle];
(units _unitGroup) allowGetIn true;

if (_isAirVehicle) then {
	_detectionStatement = "if (local this) then {[(group this)] spawn A3EAI_UAVDetection;};";
	_patrolStatement = "if (local this) then {[(group this)] spawn A3EAI_UAVStartPatrol;};";
	_vehicle flyInHeight 125;
	
	if ((!isNull _vehicle) && {!isNull _unitGroup}) then {
		A3EAI_curUAVPatrols = A3EAI_curUAVPatrols + 1;
		if (A3EAI_debugLevel > 1) then {diag_log format ["A3EAI Debug: UAV group %1 is now active and patrolling.",_unitGroup];};
	};
} else {
	_detectionStatement = "if (local this) then {[(group this)] spawn A3EAI_UGVDetection;};";
	_patrolStatement = "if (local this) then {[(group this)] spawn A3EAI_UGVStartPatrol;};";

	if ((!isNull _vehicle) && {!isNull _unitGroup}) then {
		A3EAI_curUGVPatrols = A3EAI_curUGVPatrols + 1;
		if (A3EAI_debugLevel > 1) then {diag_log format ["A3EAI Debug: UGV group %1 is now active and patrolling.",_unitGroup];};
	};
};

if ((({_x call A3EAI_checkIsWeapon} count (weapons _vehicle)) isEqualTo 0) && {({_x call A3EAI_checkIsWeapon} count (_vehicle weaponsTurret [-1])) isEqualTo 0} && {_gunnersAdded isEqualTo 0}) then {
	_unitGroup setBehaviour "CARELESS";
	_unitGroup setCombatMode "BLUE";
	if (A3EAI_debugLevel > 1) then {diag_log format ["A3EAI Debug: AI group %1 UAV/UGV vehicle %2 set to Careless behavior mode",_unitGroup,_vehicleType];};
};

_combatMode = (combatMode _unitGroup);
_behavior = (behaviour (leader _unitGroup));

[_unitGroup,0] setWPPos _vehiclePosition;
[_unitGroup,0] setWaypointType "MOVE";
[_unitGroup,0] setWaypointTimeout [0.5,0.5,0.5];
[_unitGroup,0] setWaypointCompletionRadius 200;
[_unitGroup,0] setWaypointStatements ["true",_detectionStatement];
[_unitGroup,0] setWaypointCombatMode _combatMode;
[_unitGroup,0] setWaypointBehaviour _behavior;

_waypoint = _unitGroup addWaypoint [_vehiclePosition,0];
_waypoint setWaypointType "MOVE";
_waypoint setWaypointTimeout [3,6,9];
_waypoint setWaypointCompletionRadius 150;
_waypoint setWaypointStatements ["true",_patrolStatement];
_waypoint setWaypointCombatMode _combatMode;
_waypoint setWaypointBehaviour _behavior;
	
if (_isAirVehicle) then {
	[_unitGroup,0] setWaypointSpeed "FULL";
	[_unitGroup,1] setWaypointSpeed "LIMITED";
	[_unitGroup] spawn A3EAI_UAVStartPatrol;
} else {
	[_unitGroup] spawn A3EAI_UGVStartPatrol;
};

_rearm = [_unitGroup,_unitLevel] spawn A3EAI_addGroupManager;	//start group-level manager

if (A3EAI_enableHC && {_unitType in A3EAI_HCAllowedTypes}) then {
	_unitGroup setVariable ["HC_Ready",true];
};

if (A3EAI_debugLevel > 0) then {diag_log format ["A3EAI Debug: Created AI vehicle patrol at %1 with vehicle type %2 with %3 crew units.",_vehiclePosition,_vehicleType,(count (units _unitGroup))]};

true
