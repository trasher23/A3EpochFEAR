#include "\A3EAI\globaldefines.hpp"

private ["_patrolDist","_trigger","_totalAI","_unitGroup","_targetPlayer","_playerPos","_playerDir","_spawnPos","_spawnPosASL","_startTime","_behavior","_triggerStatements","_spawnDist","_triggerLocation"];


_startTime = diag_tickTime;

_patrolDist = _this select 0;
_trigger = _this select 1;
_minAI = _this select 2;
_addAI = _this select 3;
_unitLevel = _this select 4;

_targetPlayer = _trigger getVariable ["targetplayer",objNull];
if (isNull _targetPlayer) exitWith {
	if (A3EAI_debugLevel > 1) then {diag_log format ["A3EAI Debug: Cancelling dynamic spawn for target player. Reason: Player does not exist (logged out?).",name _targetPlayer]};
	_nul = _trigger call A3EAI_cancelDynamicSpawn;
	
	false
};

_trigger setTriggerArea [TRIGGER_SIZE_EXPANDED,TRIGGER_SIZE_EXPANDED,0,false]; //Expand trigger area to prevent players from quickly leaving and start respawn process immediately
_playerPos = getPosATL _targetPlayer;
_playerDir = getDir _targetPlayer;
_spawnDist = (SPAWN_DISTANCE_BASE_DYNAMICRANDOM + random (SPAWN_DISTANCE_EXTRA_DYNAMICRANDOM));
_spawnPos = [_playerPos,_spawnDist,[(_playerDir-SPAWN_DIRECTION_VARIANCE_DYNAMIC),(_playerDir+SPAWN_DIRECTION_VARIANCE_DYNAMIC)],0] call A3EAI_SHK_pos;
_spawnPosASL = ATLToASL _spawnPos;
if ((count _spawnPos) isEqualTo 2) then {_spawnPos set [2,0];};
_triggerLocation = _trigger getVariable ["triggerLocation",locationNull];

if (
	(surfaceIsWater _spawnPos) or 
	{({if ((isPlayer _x) && {([eyePos _x,[(_spawnPos select 0),(_spawnPos select 1),(_spawnPosASL select 2) + 1.7],_x] call A3EAI_hasLOS) or ((_x distance _spawnPos) < PLAYER_DISTANCE_NO_LOS_DYNAMIC)}) exitWith {1}} count (_spawnPos nearEntities [[PLAYER_UNITS,"LandVehicle"],PLAYER_DISTANCE_WITH_LOS_DYNAMIC])) > 0} or 
	{({if (_spawnPos in _x) exitWith {1}} count ((nearestLocations [_spawnPos,[BLACKLIST_OBJECT_GENERAL,BLACKLIST_OBJECT_DYNAMIC],1500]) - [_triggerLocation])) > 0} or
	{!((_spawnPos nearObjects [PLOTPOLE_OBJECT,PLOTPOLE_RADIUS]) isEqualTo [])}
) exitWith {
	if (A3EAI_debugLevel > 1) then {
		diag_log format ["A3EAI Debug: Canceling dynamic spawn for target player %1. Possible reasons: Spawn position has water, player nearby, or is blacklisted.",name _targetPlayer];
		diag_log format ["DEBUG: Position is water: %1",(surfaceIsWater _spawnPos)];
		diag_log format ["DEBUG: Player nearby: %1",({isPlayer _x} count (_spawnPos nearEntities [[PLAYER_UNITS,"LandVehicle"],200])) > 0];
		diag_log format ["DEBUG: Location is blacklisted: %1",({_spawnPos in _x} count ((nearestLocations [_spawnPos,[BLACKLIST_OBJECT_GENERAL,BLACKLIST_OBJECT_DYNAMIC],1000]) - [_triggerLocation])) > 0];
		diag_log format ["DEBUG: No jammer nearby: %1.",((_spawnPos nearObjects [PLOTPOLE_OBJECT,PLOTPOLE_RADIUS]) isEqualTo [])];
	};
	_nul = _trigger call A3EAI_cancelDynamicSpawn;
	
	false

};

_totalAI = ((_minAI + floor (random (_addAI + 1))) max 1);
_unitGroup = [_totalAI,grpNull,"dynamic",_spawnPos,_trigger,_unitLevel,true] call A3EAI_spawnGroup;
//To do: Handle case where player suddenly within close proximity

//Set group variables
_unitGroup setBehaviour "AWARE";

//Begin hunting player or patrolling area
_behavior = if (A3EAI_huntingChance call A3EAI_chance) then {
	_unitGroup reveal [_targetPlayer,4];
	0 = [_unitGroup,_patrolDist,_targetPlayer,getPosATL _trigger] spawn A3EAI_startHunting;
	"HUNT PLAYER"
} else {
	if ((_spawnPos distance _playerPos) < DUMBFIRE_AI_DISTANCE) then {
		[_unitGroup,_playerPos] call A3EAI_setFirstWPPos;
	};
	0 = [_unitGroup,_playerPos,_patrolDist] spawn A3EAI_BIN_taskPatrol;
	"PATROL AREA"
};
if (A3EAI_debugLevel > 0) then {
	diag_log format["A3EAI Debug: Spawned 1 new AI groups of %1 units each in %2 seconds at %3 using behavior mode %4. Distance from target: %5 meters.",_totalAI,(diag_tickTime - _startTime),(mapGridPosition _trigger),_behavior,_spawnDist];
};

_triggerStatements = (triggerStatements _trigger);
if (!(_trigger getVariable ["initialized",false])) then {
	0 = [1,_trigger,[_unitGroup]] call A3EAI_initializeTrigger; //set dynamic trigger variables and create dynamic area blacklist
	_trigger setVariable ["triggerStatements",+_triggerStatements];
};
//_triggerStatements set [1,""];
_trigger setTriggerStatements _triggerStatements;
[_trigger,"A3EAI_dynTriggerArray"] call A3EAI_updateSpawnCount;

if (A3EAI_enableDebugMarkers) then {
	_nul = _trigger spawn {
		_marker = str(_this);
		_marker setMarkerColor "ColorOrange";
		_marker setMarkerAlpha 0.9;				//Dark orange: Activated trigger
	};
};

true
