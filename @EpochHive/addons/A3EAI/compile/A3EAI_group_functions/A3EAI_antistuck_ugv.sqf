private ["_unitGroup", "_vehicle", "_stuckCheckTime", "_checkPos", "_tooClose", "_wpSelect"];

_unitGroup = _this select 0;
_vehicle = _this select 1;
_stuckCheckTime = _this select 2;

if (isNull _vehicle) exitWith {};

_checkPos = (getPosATL _vehicle);
_leader = (leader _unitGroup);
if (((_leader distance (_leader findNearestEnemy _vehicle)) > 500) && {((_unitGroup getVariable ["antistuckPos",[0,0,0]]) distance _checkPos) < 100}) then {
	if (canMove _vehicle) then {
		[_unitGroup] call A3EAI_fixStuckGroup;
		[_unitGroup,0] setWaypointPosition [_checkPos,0];
		[_unitGroup,1] setWaypointPosition [_checkPos,0];
		_unitGroup setCurrentWaypoint [_unitGroup,1];
		if (A3EAI_debugLevel > 1) then {diag_log format ["A3EAI Debug: Antistuck triggered for UGV %1 (Group: %2). Forcing next waypoint.",(typeOf _vehicle),_unitGroup];};
		_unitGroup setVariable ["antistuckPos",_checkPos];
		_unitGroup setVariable ["antistuckTime",diag_tickTime + (_stuckCheckTime/2)];
	} else {
		if (!(_vehicle getVariable ["vehicle_disabled",false])) then {
			[_vehicle] call A3EAI_UGV_destroyed;
			if (A3EAI_debugLevel > 1) then {diag_log format ["A3EAI Debug: UGV %1 (Group: %2) is immobilized. Respawning UGV group.",(typeOf _vehicle),_unitGroup];};
		};
	};
} else {
	_unitGroup setVariable ["antistuckPos",_checkPos];
	_unitGroup setVariable ["antistuckTime",diag_tickTime];
};

true