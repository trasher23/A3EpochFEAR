#include "\A3EAI\globaldefines.hpp"

private ["_unitGroup", "_object", "_nearNoAggroAreas", "_inNoAggroArea", "_objectPos","_combatMode"];

_unitGroup = _this select 0;
_inNoAggroArea = _this select 1;

_combatMode = (combatMode _unitGroup);

if (_inNoAggroArea) then {
	if (_combatMode != "BLUE") then {
		[_unitGroup,"IgnoreEnemies"] call A3EAI_forceBehavior;
		[_unitGroup,true] call A3EAI_setNoAggroStatus;
		if (A3EAI_debugLevel > 1) then {diag_log format ["A3EAI Debug: Group %1 in no-aggro zone.",_unitGroup];};
	};
} else {
	if (_combatMode isEqualTo "BLUE") then {
		[_unitGroup,"Behavior_Reset"] call A3EAI_forceBehavior;
		[_unitGroup,false] call A3EAI_setNoAggroStatus;
		if (A3EAI_debugLevel > 1) then {diag_log format ["A3EAI Debug: Group %1 exited no-aggro zone.",_unitGroup];};
	};
};

true
