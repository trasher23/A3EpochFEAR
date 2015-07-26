/*
	Author: VAMPIRE, rebooted by IT07

	Description:
	finds a town

	Returns:
	ARRAY - [name of town, town position]
*/

private ["_townArr","_sRandomTown","_townPos","_locName","_ret","_continue","_blackList"];

// Define settings
_blackList = (["locationBlackList"] call VEMF_fnc_getSetting) select 0;
_checkRange = (["distanceCheck"] call VEMF_fnc_getSetting) select 0;
_tooCloseRange = (["distanceTooClose"] call VEMF_fnc_getSetting) select 0;
_maxPrefered = (["distanceMaxPrefered"] call VEMF_fnc_getSetting) select 0;
_playerCheck = (["playerCheck"] call VEMF_fnc_getSetting) select 0;

// Get a list of locations close to _cntr (position of player)
_locs = nearestLocations [position (_this select 0), ["NameVillage","NameCity","NameCityCapital","NameLocal"], _checkRange];

// Filter out the locations that are too close
_tooClose = [];
{
	if ((position (_this select 0)) distance (locationPosition _x) < _tooCloseRange) then
	{
		_tooClose pushBack _x;
	};
} forEach _locs;

// Remove all locations that are too close
for "_l" from 1 to (count _tooClose) do
{
	_index = _locs find (_tooClose select _l-1);
	_locs deleteAt _index;
};

// Check what kind of distances we have
_far = []; // Further than _maxPrefered
_pref = []; // Closer then _maxPrefered
{
	_dist = (position (_this select 0)) distance (locationPosition _x);
	call
	{
		if (_dist > _maxPrefered) exitWith
		{
			_far pushBack _x;
		};
		if (_dist < _maxPrefered) exitWith
		{
			_pref pushBack _x;
		};
	};
} forEach _locs;

// Check if there are any preferred locations. If yes, randomly select one
if (count _pref > 0) then
{
	_loc = _pref select floor random count _pref;
	diag_log format["[VEMF] fn_findLoc: _pref count is %1", count _pref];
};

// Check if _far has any locations and if _pref is empty
if (count _far > 0 AND count _pref isEqualTo 0) then
{
	_loc = _far select floor random count _far;
	diag_log format["[VEMF] fn_findLoc: _far count is %1", count _far];
};

_remLocs = [];
{ // Check _locs for locations with players and if it is in blacklist
	_hasPlayers = [locationPosition _x, _playerCheck] call VEMF_fnc_findPlayers;
	if (_hasPlayers OR (text _x) in _blackList) then
 	{
		_remLocs pushBack _x;
	};
} forEach _locs;

{ // Remove all invalid locations from _locs
	_index = _locs find _x;
	_locs deleteAt _index;
} forEach _remLocs;

// Validate _locs just to prevent the .RPT from getting spammed
if (count _locs isEqualTo 0) exitWith
{
	diag_log "[VEMF] fn_findLoc FATAL ERROR: No valid locations found!";
};

// Return Name and POS
_townPos = [((locationPosition _loc) select 0), ((locationPosition _loc) select 1), 0];
_locName = (text _loc);

_ret = [_locName, _townPos];
_ret
