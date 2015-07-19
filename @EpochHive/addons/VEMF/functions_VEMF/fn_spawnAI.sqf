/*
	Author: original by Vampire, completely rewritten by IT07

	Description:
	spawns AI using given _pos and unit/group count.
*/

private ["_grpCount","_sldrClass","_unitsPerGrp","_grpArr","_grp","_newPos","_unit","_pos","_waypoints","_wp","_cyc","_unitArr","_return"];

_pos      = _this select 0;
_grpCount = _this select 1;
_unitsPerGrp = _this select 2;
_sldrClass = "I_Soldier_EPOCH";
_grpArr = [];
_aiSkill = (["aiSkill"] call VEMF_fnc_getSetting) select 0;
_groupCount = (["groupCount"] call VEMF_fnc_getSetting) select 0;

// Spawn Groups near Position
private ["_units","_unit"];
for "_g" from 1 to _grpCount do
{
	_grp = createGroup RESISTANCE;
	_grp setBehaviour "STEALTH";
	_grp setCombatMode "RED";

	for "_units" from 1 to _unitsPerGrp do
	{
		_newPos = [_pos,0,70,1,0,200,0] call BIS_fnc_findSafePos; // Find Nearby Position
		_unit = _grp createUnit [_sldrClass, _newPos, [], 0, "FORM"]; // Create Unit There
		[_unit,"Invasion"] call VEMF_fnc_loadInv; // Load the AI's inventory
		_unit setSkill ["general", _aiSkill];
		_unit setRank "Private";
		_unit enableAI "TARGET";
		_unit enableAI "AUTOTARGET";
		_unit enableAI "MOVE";
		_unit enableAI "ANIM";
		_unit enableAI "FSM";
		_unit enableAI "AIMINGERROR";
		_unit enableAI "SUPRESSION";
		_unit addEventHandler ["Killed",{ [(_this select 0), (_this select 1)] spawn VEMF_fnc_aiKilled; }];
		//_unit setVariable ["VEMFAI", true];
		//_unit setVariable ["LASTLOGOUT_EPOCH", (diag_tickTime + 14400)];
		uiSleep 0.05;
	};
	// Leader Assignment
	_unit setSkill ["general", _aiSkill];
	_grp selectLeader _unit;
	_grpArr = _grpArr + [_grp];
	_grp = grpNull;
	_grp = createGroup RESISTANCE;
	_grp setBehaviour "STEALTH";
	_grp setCombatMode "RED";
	uiSleep 1;
};

if (count _grpArr < _grpCount) exitWith
{
	diag_log format["[VEMF] !!ERROR!! fn_spawnAI: count(_grpArr) < than VEMF_groupCount (%1)! _grpArr is %2", _groupCount, _grpArr];
	_return = false;
	_return
};

// Waypoints
_waypoints = [
	[(_pos select 0), (_pos select 1)+50, 0],
	[(_pos select 0)+50, (_pos select 1), 0],
	[(_pos select 0), (_pos select 1)-50, 0],
	[(_pos select 0)-50, (_pos select 1), 0]
];

// Make them Patrol
{
	for "_z" from 0 to ((count _waypoints)-1) do
	{
		_wp = _x addWaypoint [(_waypoints select _z), 10];
		_wp setWaypointType "SAD";
		_wp setWaypointCompletionRadius 20;
	};

	_cyc = _x addWaypoint [_pos,10];
	_cyc setWaypointType "CYCLE";
	_cyc setWaypointCompletionRadius 20;
	_x setVariable
	uiSleep 0.05;
} forEach _grpArr;

_unitArr = [];
{
	_unitArr = _unitArr + (units _x);
	uiSleep 0.05;
} forEach _grpArr;

_return = [true, _grpArr, _unitArr];

_return
