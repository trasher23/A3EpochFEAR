#define PLAYER_UNITS "Epoch_Male_F","Epoch_Female_F"
#define SPACE_FOR_OBJECT "Land_Coil_F"
private ["_totalAI","_spawnPos","_unitGroup","_trigger","_attempts","_baseDist","_dummy","_unitLevel","_checkPos"];

	
_totalAI = _this select 0;
_unitGroup = _this select 1;
_unitType = _this select 2;
_spawnPos = _this select 3;
_trigger = _this select 4;
_unitLevel = _this select 5;
_checkPos = if ((count _this) > 6) then {_this select 6} else {false};

if (_checkPos) then {	//If provided position requires checking...
	_pos = [];
	_attempts = 0;
	_baseDist = 15;

	while {(_pos isEqualTo []) && {(_attempts < 3)}} do {
		_pos = _spawnPos findEmptyPosition [0.5,_baseDist,SPACE_FOR_OBJECT];
		if !(_pos isEqualTo []) then {
			_pos = _pos isFlatEmpty [0,0,0.75,5,0,false,objNull];
		}; 
		
		_attempts = (_attempts + 1);
		if (_pos isEqualTo []) then {
			if (_attempts < 3) then {
				_baseDist = (_baseDist + 15);
			};
		} else {
			if (A3EAI_debugLevel > 1) then {diag_log format ["A3EAI Debug: Found spawn position at %1 meters away at position %2 after %3 attempts.",(_pos distance _spawnPos),_pos,_attempts]};
			_spawnPos = _pos;
		};
	};
};

_spawnPos set [2,0];

if (({if (isPlayer _x) exitWith {1}} count (_spawnPos nearEntities [[PLAYER_UNITS],100])) isEqualTo 1) exitWith {
	if (isNull _unitGroup) then {_unitGroup = [_unitType,true] call A3EAI_createGroup;};
	_unitGroup setVariable ["GroupSize",0];
	_unitGroup setVariable ["trigger",_trigger];
	0 = [0,_trigger,_unitGroup] call A3EAI_addRespawnQueue;
	if (A3EAI_debugLevel > 1) then {diag_log format ["A3EAI Debug: Spawn at %1 cancelled due to player(s) within 100m. Added group %2 to respawn queue.",_spawnPos,_unitGroup];};
	_unitGroup
};

if (isNull _unitGroup) then {
	_unitGroup = [_unitType] call A3EAI_createGroup;
};

for "_i" from 1 to (_totalAI max 1) do {
	private ["_unit"];
	_unit = [_unitGroup,_unitLevel,_spawnPos,true] call A3EAI_createUnit;
};

//Delete dummy if it exists, and clear group's "dummy" variable.
_dummy = _unitGroup getVariable "dummyUnit";
if (!isNil "_dummy") then {
	deleteVehicle _dummy;
	_unitGroup setVariable ["dummyUnit",nil];
	if (A3EAI_debugLevel > 1) then {diag_log format["A3EAI Debug: Deleted 1 dummy unit for group %1.",_unitGroup];};
};

_unitGroup selectLeader ((units _unitGroup) select 0);
_unitGroup setVariable ["trigger",_trigger];
_unitGroup setVariable ["GroupSize",_totalAI];
_unitGroup setVariable ["unitLevel",_unitLevel];
_unitGroup setFormDir (random 360);
_unitGroup setSpeedMode "FULL";
_unitGroup allowFleeing 0;

0 = [_unitGroup,_unitLevel] spawn A3EAI_addGroupManager;	//start group-level manager

if (_unitType in A3EAI_airReinforcementAllowedTypes) then {
	_unitGroup setVariable ["ReinforceAvailable",true];
};

_unitGroup
