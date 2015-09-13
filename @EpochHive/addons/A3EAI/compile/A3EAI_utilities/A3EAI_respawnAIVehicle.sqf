private ["_vehicle", "_vehicleType", "_spawnParams"];

_vehicle = _this;
if (isNull _vehicle) exitWith {diag_log format ["Error: %1 attempted to respawn null vehicle",__FILE__];};
if (A3EAI_debugLevel > 1) then {diag_log format ["A3EAI Debug: Respawning AI vehicle %1.",_vehicle]};
if (isDedicated) then {
	
	_vehicleType = (typeOf _vehicle);
	_spawnParams = _vehicle getVariable ["spawnParams",[]];
	_vehicleClass = [configFile >> "CfgVehicles" >> _vehicleType,"vehicleClass",""] call BIS_fnc_returnConfigEntry;
	if !((toLower _vehicleClass) isEqualTo "autonomous") then {
		if (_spawnParams isEqualTo []) then {
			[2,_vehicleType] call A3EAI_addRespawnQueue;
		} else {
			if (_spawnParams select 4) then {
				[1,_spawnParams] call A3EAI_addRespawnQueue;
			};
		};
		if (_vehicleType isKindOf "Air") then {A3EAI_curHeliPatrols = A3EAI_curHeliPatrols - 1} else {A3EAI_curLandPatrols = A3EAI_curLandPatrols - 1};
	} else {
		[3,_vehicleType] call A3EAI_addRespawnQueue;
		if (_vehicleType isKindOf "Air") then {A3EAI_curUAVPatrols = A3EAI_curUAVPatrols - 1} else {A3EAI_curUGVPatrols = A3EAI_curUGVPatrols - 1};
	};
	_vehicle setVariable ["A3EAI_deathTime",diag_tickTime]; //mark vehicle for cleanup
} else {
	A3EAI_respawnVehicle_PVS = _vehicle;
	publicVariableServer "A3EAI_respawnVehicle_PVS";
};

{_vehicle removeAllEventHandlers _x} count ["HandleDamage","Killed","GetOut","Local","Hit"];

true