diag_log "TEST MESSAGE";
private ["_startTime", "_totalAI", "_patrolDist", "_trigger", "_unitLevel", "_grpArray", "_triggerPos", "_maxUnits", "_totalAINew", "_attempts", "_continue", "_spawnPos", "_spawnPosSelected", "_unitGroup", "_triggerStatements"];

_startTime = diag_tickTime;

_totalAI = _this select 0;									
//_this select 1;
_patrolDist = _this select 2;								
_trigger = _this select 3;									
_unitLevel = _this select 4;

_grpArray = _trigger getVariable ["GroupArray",[]];	
if !(_grpArray isEqualTo []) exitWith {if (A3EAI_debugLevel > 0) then {diag_log format ["A3EAI Debug: Active groups found at custom spawn %1. Exiting spawn script.",(triggerText _trigger)];};};						

_trigger setTriggerArea [750,750,0,false];
_triggerPos = getPosASL _trigger;

_startTime = diag_tickTime;

if !(_trigger getVariable ["respawn",true]) then {
	_maxUnits = _trigger getVariable ["maxUnits",[0,0]];
	_totalAINew = (_maxUnits select 0);
	if (_totalAINew > 0) then {_totalAI = _totalAINew};	//Retrieve AI amount if it was updated from initial value (for non-respawning custom spawns only)
};

_attempts = 0;
_continue = true;
_spawnPos = [];
while {_continue && {(_attempts < 3)}} do {
	_spawnPosSelected = [_triggerPos,random (200),random(360),0] call SHK_pos;
	if ((count _spawnPosSelected) isEqualTo 2) then {_spawnPosSelected set [2,0];};
	if (
		(_spawnPosSelected call A3EAI_posNotInBuilding) && 
		{({if ((isPlayer _x) && {([eyePos _x,[(_spawnPosSelected select 0),(_spawnPosSelected select 1),(_spawnPosSelected select 2) + 1.7],_x] call A3EAI_hasLOS) or ((_x distance _spawnPosSelected) < 75)}) exitWith {1}} count (_spawnPosSelected nearEntities [["Epoch_Male_F","Epoch_Female_F","Car"],200])) isEqualTo 0}
	) then {
		_spawnPos = _spawnPosSelected;
		_continue = false;
	} else {
		_attempts = _attempts + 1;
		if (A3EAI_debugLevel > 0) then {diag_log format ["A3EAI Debug: Unable to find suitable spawn position. (attempt %1/3).",_attempts];};
	};
};

_unitGroup = grpNull;
if !(_spawnPos isEqualTo []) then {
	_unitGroup = [_totalAI,_unitGroup,_spawnPos,_trigger,_unitLevel,true] call A3EAI_spawnGroup;
	if (_patrolDist > 1) then {
		0 = [_unitGroup,_triggerPos,_patrolDist] spawn A3EAI_BIN_taskPatrol;
	} else {
		[_unitGroup, 0] setWaypointType "HOLD";
	};

	if (A3EAI_debugLevel > 0) then {diag_log format["A3EAI Debug: Spawned a group of %1 units in %2 seconds at custom spawn %3.",_totalAI,(diag_tickTime - _startTime),(triggerText _trigger)];};
} else {
	_unitGroup = ["protect"] call A3EAI_createGroup;
	[0,_trigger,_unitGroup] call A3EAI_addRespawnQueue;
	if (A3EAI_debugLevel > 0) then {diag_log format["A3EAI Debug: Unable to find suitable spawn position at custom spawn %1.",(triggerText _trigger)];};
};

_unitGroup setVariable ["unitType","static"];
_grpArray pushBack _unitGroup;

_triggerStatements = (triggerStatements _trigger);
if (!(_trigger getVariable ["initialized",false])) then {
	0 = [0,_trigger,_grpArray,_patrolDist,_unitLevel,[],[_totalAI,0]] call A3EAI_initializeTrigger;
	_trigger setVariable ["triggerStatements",+_triggerStatements];
} else {
	_trigger setVariable ["isCleaning",false];
	_trigger setVariable ["maxUnits",[_totalAI,0]];
	if (A3EAI_debugLevel > 1) then {diag_log format ["A3EAI Extended Debug: Trigger group array updated to: %1.",_grpArray]};
};
	
_unitGroup
