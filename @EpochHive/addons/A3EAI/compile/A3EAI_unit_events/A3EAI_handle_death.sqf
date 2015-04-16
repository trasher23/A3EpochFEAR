
private["_victim","_killer","_unitGroup","_unitType","_launchWeapon","_launchAmmo","_groupIsEmpty","_unitsAlive","_vehicle","_groupSize","_newGroupSize"];

_victim = _this select 0;
_killer = _this select 1;

if (_victim getVariable ["deathhandled",false]) exitWith {};
_victim setVariable ["deathhandled",true];

_vehicle = (vehicle _victim);
_unitGroup = (group _victim);

{_victim removeAllEventHandlers _x} count ["Killed","HandleDamage","Local"];
_victim setDamage 1;

//Check number of units alive, preserve group immediately if empty.
_unitsAlive = ({alive _x} count (units _unitGroup));
_groupIsEmpty = if (_unitsAlive isEqualTo 0) then {_unitGroup call A3EAI_protectGroup; true} else {false};

//Update group size counter
_groupSize = (_unitGroup getVariable ["GroupSize",0]);
if (_groupSize > 0) then {
	_newGroupSize = (_groupSize - 1);
	_unitGroup setVariable ["GroupSize",_newGroupSize];
	if !(isDedicated) then {
		A3EAI_updateGroupSize_PVS = [_unitGroup,_newGroupSize];
		publicVariableServer "A3EAI_updateGroupSize_PVS";
	};
};

//Retrieve group type
_unitType = _unitGroup getVariable ["unitType",""];

call {
	if (_unitType isEqualTo "static") exitWith {
		[_victim,_killer,_unitGroup,_groupIsEmpty] call A3EAI_handleStaticDeath;
		0 = [_victim,_killer,_unitGroup,_unitType,_unitsAlive] call A3EAI_handleDeath_generic;
	};
	if (_unitType isEqualTo "dynamic") exitWith {
		[_victim,_killer,_unitGroup,_groupIsEmpty] call A3EAI_handleDeath_dynamic;
		0 = [_victim,_killer,_unitGroup,_unitType,_unitsAlive] call A3EAI_handleDeath_generic;
	};
	if (_unitType isEqualTo "random") exitWith {
		[_victim,_killer,_unitGroup,_groupIsEmpty] call A3EAI_handleDeath_random;
		0 = [_victim,_killer,_unitGroup,_unitType,_unitsAlive] call A3EAI_handleDeath_generic;
	};
	if (_unitType in ["air","aircustom"]) exitWith {
		[_victim,_unitGroup] call A3EAI_handleAirDeath;
	};
	if (_unitType in ["land","landcustom"]) exitWith {
		0 = [_victim,_killer,_unitGroup,_unitType] call A3EAI_handleDeath_generic;
		[_victim,_unitGroup,_groupIsEmpty] call A3EAI_handleLandDeath;
	};
	if (_unitType isEqualTo "aircrashed") exitWith {};
	if (_groupIsEmpty) then {
		_unitGroup setVariable ["GroupSize",-1];
		if !(isDedicated) then {
			A3EAI_updateGroupSize_PVS = [_unitGroup,-1];
			publicVariableServer "A3EAI_updateGroupSize_PVS";
		};
	};
};

if !(isNull _victim) then {
	{
		if (_x in A3EAI_launcherTypes) exitWith {
			_victim removeWeapon _x;
		};
	} forEach ((_victim getVariable ["loadout",[[],[]]]) select 0);
	
	{
		if (_forEachIndex > 0) then {
			_victim removeMagazines _x;
		};
	} forEach ((_victim getVariable ["loadout",[[],[]]]) select 1);

	_victim removeItems "FirstAidKit";
	if (_victim getVariable ["Remove_NVG",true]) then {_victim removeWeapon "NVG_EPOCH"};
	if (_vehicle isEqualTo (_unitGroup getVariable ["assignedVehicle",objNull])) then {
		_victim setPosATL (getPosATL _victim);
	};
	if (A3EAI_deathMessages && {isPlayer _killer}) then {
		_nul = [_killer,_victim] spawn A3EAI_sendKillMessage;
	};
	if (isDedicated) then {
		_victim setVariable ["A3EAI_deathTime",diag_tickTime];
	} else {
		A3EAI_setDeathTime_PVS = _victim;
		publicVariableServer "A3EAI_setDeathTime_PVS";
	};
	
	if (A3EAI_debugLevel > 0) then {diag_log format["A3EAI Debug: %1 AI unit %2 killed by %3, %4 units left alive in group %5.",_unitType,_victim,_killer,_unitsAlive,_unitGroup];};
} else {
	if (A3EAI_debugLevel > 0) then {diag_log format ["A3EAI Debug: AI unit %1 killed by %2 is null.",_victim,_killer];};
};

_victim
