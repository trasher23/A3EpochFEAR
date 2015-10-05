#include "\A3EAI\globaldefines.hpp"

private["_victim","_killer","_unitGroup","_unitType","_unitsAlive","_inNoAggroArea"];

_victim = _this select 0;
_killer = _this select 1;
_unitGroup = _this select 2;
_unitType = _this select 3;
_unitsAlive = _this select 4;

try {
	if (isPlayer _killer) then {
		if (_victim getVariable ["CollisionKilled",false]) then {
			throw format ["A3EAI Debug: %1 AI unit %2 was killed by collision damage caused by %3. Unit gear cleared.",_unitType,_victim,_killer];
		};
		_unitLevel = _unitGroup getVariable ["unitLevel",1];
		if (isDedicated) then {
			0 = [_victim,_unitLevel] spawn A3EAI_generateLootOnDeath;
		} else {
			A3EAI_generateLootOnDeath_PVS = [_victim,_unitLevel];
			publicVariableServer "A3EAI_generateLootOnDeath_PVS";
		};
	} else {
		if (_killer isEqualTo _victim) then {
			throw format ["A3EAI Debug: %1 AI unit %2 was killed by self. Unit gear cleared.",_unitType,_victim];
		};
	};
} catch {
	_victim call A3EAI_purgeUnitGear;
	if (A3EAI_debugLevel > 0) then {
		diag_log _exception;
	};
};

true
