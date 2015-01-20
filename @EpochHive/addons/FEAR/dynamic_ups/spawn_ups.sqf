// -------------------------------------------------------------------------------
//	Purpose	:	Function to create UPS patrols in random city and town locations
// -------------------------------------------------------------------------------

if (!isServer) exitWith {};

private["_pos","_markerIndex","_markerName","_patrolMarker","_side","_skill","_numberOfSoldiers","_grp"];

_pos = _this select 0;
_markerIndex = _this select 1;

// Create patrol marker
_markerName = format ["area%1", _markerIndex];
_patrolMarker = createMarker [_markerName, _pos];
_patrolMarker setMarkerShape "RECTANGLE";
_patrolMarker setMarkerSize [500, 500];

// Assign unit properties
_side = EAST;
_skill = [0.8, 1.0];
_numberOfSoldiers = 1 + (random 4);

/* Spawn units
	Parameter(s):
		_this select 0: the group's starting position (Array)
		_this select 1: the group's side (Side)
		_this select 2: can be three different types:
			- list of character types (Array)
			- amount of characters (Number)
			- CfgGroups entry (Config)
		_this select 3: (optional) list of relative positions (Array)
		_this select 4: (optional) list of ranks (Array)
		_this select 5: (optional) skill range (Array)
		_this select 6: (optional) ammunition count range (Array)
		_this select 7: (optional) randomization controls (Array)
			0: amount of mandatory units (Number)
			1: spawn chance for the remaining units (Number)
		_this select 8: (optional) azimuth (Number)
*/
_grp = [_pos, _side, _numberOfSoldiers, [], [], _skill] call BIS_fnc_spawnGroup;

// Need to add on kill event, using WAI function
// Removed until can understand Arma 3 Epoch!
//{_x addEventHandler ["Killed",{[_this select 0, _this select 1, ""] call on_kill;}];} forEach (units _grp);

sleep 0.5;

// Now have the spawned patrol use UPSMON script to patrol the _patrolMarker area.
[leader _grp,_patrolMarker,"random","nofollow","nowait","noslow"] execVM "\FEAR\dynamic_ups\ups.sqf";

If {UPS_TrackPatrol} then {
// Debug: track unit
[leader _grp,"WP","GROUP","SHOWSTATIC"] execVM "\FEAR\dynamic_ups\track_ups.sqf";
};

diag_log format ["[Dynamic UPS]: Urban patrol spawned at: %1", _pos];
