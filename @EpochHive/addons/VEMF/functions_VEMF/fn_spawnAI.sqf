/*
	Author: original by Vampire, completely rewritten by IT07

	Description:
	spawns AI using given _pos and unit/group count.

	Params:
	_this select 0: POSITION - where to spawn the units around
	_this select 1: SCALAR - how many groups to spawn
	_this select 2: SCALAR - how many units to put in each group
*/

private // Make sure that the vars in this function do not interfere with vars in the calling script
[
	"_pos","_locName","_grpCount","_unitsPerGrp","_sldrClass","_groups","_settings","_hc","_skills","_newPos","_return","_waypoints","_wp","_cyc","_units",
	"_accuracy","_aimShake","_aimSpeed","_stamina","_spotDist","_spotTime","_courage","_reloadSpd","_commanding","_general","_loadInv"
];

_pos = _this select 0;
_locName = _this select 1;
_grpCount = _this select 2;
_unitsPerGrp = _this select 3;
_sldrClass = "I_Soldier_EPOCH";
_groups = [];
_hc = "allowHeadLessClient" call VEMF_fnc_getSetting;
_skills = [["VEMFconfig","aiSkill"],["accuracy","aimingShake","aimingSpeed","endurance","spotDistance","spotTime","courage","reloadSpeed","commanding","general"]] call VEMF_fnc_getSetting;
_accuracy = _skills select 0;
_aimShake = _skills select 1;
_aimSpeed = _skills select 2;
_stamina = _skills select 3;
_spotDist = _skills select 4;
_spotTime = _skills select 5;
_courage = _skills select 6;
_reloadSpd = _skills select 7;
_commanding = _skills select 8;
_general = _skills select 9;

_units = [];
// Spawn Groups near Position
for "_g" from 1 to _grpCount do
{
	private ["_grp","_unit"];
	_grp = createGroup RESISTANCE;
	_grp setBehaviour "AWARE";
	_grp setCombatMode "RED";
	_grp allowFleeing 0;

	for "_u" from 1 to _unitsPerGrp do
	{
		_newPos = [_pos,0,70,1,0,200,0] call BIS_fnc_findSafePos; // Find Nearby Position
		_unit = _grp createUnit [_sldrClass, _newPos, [], 0, "FORM"]; // Create Unit There
		_unit addMPEventHandler ["mpkilled","if (isDedicated) then { [_this select 0, _this select 1] spawn VEMF_fnc_aiKilled }"];
		_units pushBack _unit;
		// Set skills
		_unit setSkill ["aimingAccuracy", _accuracy];
		_unit setSkill ["aimingShake", _aimShake];
		_unit setSkill ["aimingSpeed", _aimSpeed];
		_unit setSkill ["endurance", _stamina];
		_unit setSkill ["spotDistance", _spotDist];
		_unit setSkill ["spotTime", _spotTime];
		_unit setSkill ["courage", _courage];
		_unit setSkill ["reloadSpeed", _reloadSpd];
		_unit setSkill ["commanding", _commanding];
		_unit setSkill ["general", _general];
		_unit setRank "Private"; // Set rank
	};
	_grp selectLeader _unit; // Leader Assignment
	_groups pushBack _grp; // Push it into the _groups array
};

_invLoaded = [_units,"Invasion"] call VEMF_fnc_loadInv; // Load the AI's inventory
if isNil"_invLoaded" then
{
	["fn_spawnAI", 0, "failed to load AI's inventory..."] call VEMF_fnc_log;
};

if (count _groups < _grpCount) exitWith
{
	["fn_spawnAI", 0, format["count(_groups) < then VEMF_groupCount (%1)! _groups is %2", _groupCount, _groups]] call VEMF_fnc_log;
	false
};

_waypoints = [
	[(_pos select 0), (_pos select 1)+50, 0],
	[(_pos select 0)+50, (_pos select 1), 0],
	[(_pos select 0), (_pos select 1)-50, 0],
	[(_pos select 0)-50, (_pos select 1), 0]
];

{ // Make them Patrol
	for "_z" from 1 to (count _waypoints) do
	{
		_wp = _x addWaypoint [(_waypoints select (_z-1)), 10];
		_wp setWaypointType "SAD";
		_wp setWaypointCompletionRadius 20;
	};

	_cyc = _x addWaypoint [_pos,10];
	_cyc setWaypointType "CYCLE";
	_cyc setWaypointCompletionRadius 20;
	[_x] spawn VEMF_fnc_signAI;
} forEach _groups;
_units
