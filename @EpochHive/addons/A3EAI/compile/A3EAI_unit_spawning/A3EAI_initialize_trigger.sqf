private["_trigger","_mode"];

_mode = _this select 0;
_trigger = _this select 1;

_trigger setVariable ["isCleaning",false];
_trigger setVariable ["GroupArray",(_this select 2)];

call {
	if (_mode isEqualTo 0) exitWith {
		//Static spawns
		_trigger setVariable ["patrolDist",(_this select 3),A3EAI_enableHC];
		_trigger setVariable ["unitLevel",(_this select 4),A3EAI_enableHC];
		_trigger setVariable ["unitLevelEffective",(_this select 4)];
		_trigger setVariable ["locationArray",(_this select 5)];
		_trigger setVariable ["maxUnits",(_this select 6)];
		_trigger setVariable ["spawnChance",missionNamespace getVariable [format ["A3EAI_spawnChance%1",(_this select 4)],1]];
		_trigger setVariable ["spawnType","static"];
		if (A3EAI_debugLevel > 1) then {diag_log format["A3EAI Extended Debug: Initialized static spawn at %1 (%2). GroupArray: %3, PatrolDist: %4. unitLevel: %5. %LocationArray %6 positions, MaxUnits %7.",(triggerText _trigger),(getPosATL _trigger),(_this select 2),(_this select 3),(_this select 4),count (_this select 5),(_this select 6)];};
	};
	if (_mode isEqualTo 1) exitWith {
		//Dynamic spawns
		_trigger setVariable ["spawnType","dynamic"];
		if (A3EAI_debugLevel > 1) then {diag_log format["A3EAI Extended Debug: Initialized dynamic spawn at %1. GroupArray: %2.",triggerText _trigger,(_this select 2)];};
	};
	if (_mode isEqualTo 2) exitWith {
		//Random spawns
		_trigger setVariable ["spawnType","random"];
		if (A3EAI_debugLevel > 1) then {diag_log format["A3EAI Extended Debug: Initialized random spawn at %1. GroupArray: %2.",triggerText _trigger,(_this select 2)];};
	};
	if (_mode isEqualTo 3) exitWith {
		//Static spawns (custom)
		_trigger setVariable ["patrolDist",(_this select 3),A3EAI_enableHC];
		_trigger setVariable ["unitLevel",(_this select 4),A3EAI_enableHC];
		_trigger setVariable ["unitLevelEffective",(_this select 4)];
		_trigger setVariable ["locationArray",(_this select 5)];
		_trigger setVariable ["maxUnits",(_this select 6)];
		_trigger setVariable ["spawnChance",1];
		_trigger setVariable ["spawnType","custom"];
		if (A3EAI_debugLevel > 1) then {diag_log format["A3EAI Extended Debug: Initialized custom spawn at %1. GroupArray: %2, PatrolDist: %3. unitLevel: %4. %LocationArray %5 positions, MaxUnits %6.",triggerText _trigger,(_this select 2),(_this select 3),(_this select 4),count (_this select 5),(_this select 6)];};
	};
};

_trigger setVariable ["triggerStatements",+(triggerStatements _trigger)];
_trigger setVariable ["initialized",true];

true
