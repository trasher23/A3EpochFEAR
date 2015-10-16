#include "\A3EAI\globaldefines.hpp"

private ["_hitArray", "_hitName", "_hitPoint", "_lastRepaired","_result","_leader", "_assignedTarget"];

_unitGroup = _this select 0;
_vehicle = _this select 1;

if (A3EAI_detectOnlyUGVs) then {
	_lastAggro = _vehicle getVariable "AggroTime";
	if (isNil "AggroTime") then {
		_lastAggro = 0;
		_vehicle setVariable ["AggroTime",0];
		[_unitGroup,"IgnoreEnemies"] call A3EAI_forceBehavior;
	};

	if ((combatMode _unitGroup) isEqualTo "YELLOW") then {
		if ((_lastAggro > diag_tickTime) or {[_vehicle,NO_AGGRO_RANGE_UGV] call A3EAI_checkInNoAggroArea}) then {
			[_unitGroup,"IgnoreEnemies"] call A3EAI_forceBehavior;
			if (A3EAI_debugLevel > 1) then {diag_log format ["A3EAI Debug: Reset Group %1 %2 UGV to non-hostile mode.",_unitGroup,(typeOf _vehicle)]};
		};
	};
} else {
	_leader = (leader _unitGroup);
	_inArea = [_vehicle,NO_AGGRO_RANGE_UGV] call A3EAI_checkInNoAggroArea;
	
	if !(_inArea) then {
		_assignedTarget = (assignedTarget (vehicle _leader));
		if ((_assignedTarget distance _leader) < NO_AGGRO_RANGE_UGV) then {	//900: replace with engagement range
			_inArea = [_assignedTarget,300] call A3EAI_checkInNoAggroArea;
		};
	};
	
	_result = [_unitGroup,_inArea] call A3EAI_noAggroAreaToggle;
};

true
