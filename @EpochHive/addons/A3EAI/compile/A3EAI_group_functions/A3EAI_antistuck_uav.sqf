private ["_unitGroup", "_vehicle", "_stuckCheckTime", "_checkPos", "_tooClose", "_wpSelect","_leader"];

_unitGroup = _this select 0;
_vehicle = _this select 1;
_stuckCheckTime = _this select 2;

if (isNull _vehicle) exitWith {};

_checkPos = (getWPPos [_unitGroup,(currentWaypoint _unitGroup)]);
_leader = (leader _unitGroup);
if (((_leader distance (_leader findNearestEnemy _vehicle)) > 750) && {_checkPos isEqualTo (_unitGroup getVariable ["antistuckPos",[0,0,0]])} && {canMove _vehicle}) then {
	_tooClose = true;
	_wpSelect = [];
	while {_tooClose} do {
		_wpSelect = (A3EAI_locationsAir call A3EAI_selectRandom) select 1;
		if (((waypointPosition [_unitGroup,0]) distance _wpSelect) < 300) then {
			_tooClose = false;
		} else {
			uiSleep 0.1;
		};
	};
	_wpSelect = [_wpSelect,50+(random 900),(random 360),1] call SHK_pos;
	[_unitGroup,0] setWPPos _wpSelect;
	[_unitGroup,1] setWPPos _wpSelect;
	[_unitGroup,"IgnoreEnemies"] call A3EAI_forceBehavior;
	_unitGroup setVariable ["antistuckPos",_wpSelect];
	if (A3EAI_debugLevel > 1) then {diag_log format ["A3EAI Debug: Antistuck triggered for UAV %1 (Group: %2). Forcing next waypoint.",(typeOf _vehicle),_unitGroup];};
	_unitGroup setVariable ["antistuckTime",diag_tickTime + (_stuckCheckTime/2)];
} else {
	_unitGroup setVariable ["antistuckPos",_checkPos];
	_unitGroup setVariable ["antistuckTime",diag_tickTime];
};

true