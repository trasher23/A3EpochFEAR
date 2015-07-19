private ["_hitArray", "_hitName", "_hitPoint", "_lastRepaired"];

_unitGroup = _this select 0;
_vehicle = _this select 1;

_lastRepaired = _vehicle getVariable "LastRepaired";
if (isNil "_lastRepaired") then {
	_lastRepaired = diag_tickTime;
	_vehicle setVariable ["LastRepaired",0];
};

if ((diag_tickTime - _lastRepaired) < 600) exitWith {false};

_vehicleType = (typeOf _vehicle);
_hitArray = [configFile >> "CfgVehicles" >> _vehicleType,"HitPoints",[]] call BIS_fnc_returnConfigEntry;

{
	_hitName = configfile >> "CfgVehicles" >> _vehicleType >> "HitPoints" >> _x >> "name";
	_hitPoint = _vehicle getHit _hitName;
	if (_hitPoint < 0.8) then {
		_vehicle setHit [_hitName,_hitPoint + 0.2];
		if (A3EAI_debugLevel > 1) then {diag_log format ["A3EAI Debug: Repaired UGV %1 part %2",(typeOf _vehicle),_hitName]};
	};
} forEach _hitArray;

_vehicle setVariable ["LastRepaired",diag_tickTime];

true