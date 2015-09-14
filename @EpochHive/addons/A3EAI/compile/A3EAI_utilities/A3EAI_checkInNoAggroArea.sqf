private ["_unitGroup", "_object", "_nearNoAggroAreas", "_inNoAggroArea", "_objectPos"];

_unitGroup = _this select 0;
_object = _this select 1;

_nearNoAggroAreas = nearestLocations [_object,["A3EAI_NoAggroArea"],1500];
_inNoAggroArea = false;
_objectPos = getPosATL _object;
{
	if (_objectPos in _x) exitWith {
		_inNoAggroArea = true;
	};
} forEach _nearNoAggroAreas;

if (_inNoAggroArea) then {
	if (((combatMode _unitGroup) isEqualTo "YELLOW") && {(diag_tickTime - (_unitGroup getVariable ["TimeLastUnitKilled",-180])) > 180}) then {
		[_unitGroup,"IgnoreEnemies"] call A3EAI_forceBehavior;
		if (A3EAI_debugLevel > 1) then {diag_log format ["A3EAI Debug: Group %1 in no-aggro zone.",_unitGroup];};
	};
} else {
	if ((combatMode _unitGroup) isEqualTo "BLUE") then {
		[_unitGroup,"Behavior_Reset"] call A3EAI_forceBehavior;
		if (A3EAI_debugLevel > 1) then {diag_log format ["A3EAI Debug: Group %1 exited no-aggro zone.",_unitGroup];};
	};
};

true
