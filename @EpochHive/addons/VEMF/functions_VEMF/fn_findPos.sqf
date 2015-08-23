/*
	Author: VAMPIRE, rewritten by IT07

	Description:
	can find a location or pos randomly on the map where there are no players

	Params:
	_this select 0: STRING - Mode to use. Options: "loc" or "pos"
	_this select 1: BOOLEAN - True if _pos needs to be a road
	_this select 2: OBJECT - Center for nearestLocations check
	_this select 3: SCALAR - Max distance in meters from center to search for _pos
	_this select 4: SCALAR - Distance in meters. Locations closer than that will be excluded
	_this select 5: SCALAR - Max prefered distance in meters from center. If not achievable, further dest will be selected
	_this select 6: SCALAR - Distance in meters to check from _cntr for players

	Returns:
	ARRAY - [name of town, town position]
*/

private ["_settings","_locPos","_loc","_locName","_ret","_continue","_settings","_blackList","_usedLocs","_checkRange","_tooCloseRange","_maxPrefered","_playerCheck","_allowSmall","_mode","_pos","_hasPlayers"];

// Define settings
_settings = [["locationBlackList","allowSmall"]] call VEMF_fnc_getSetting;
_blackList = _settings select 0;
_allowSmall = _settings select 1;
_mode = _this select 0;
_onRoad = _this select 1;
	_roadRange = 5000;
_cntr = _this select 2;
_rad = _this select 3;
_tooCloseRange = _this select 4;
_maxPrefered = _this select 5;
_playerCheck = _this select 6;

switch _mode do
{
	case "loc":
	{
		// Get a list of locations close to _cntr (position of player)
		_locs = nearestLocations [_cntr, ["NameVillage","NameCity","NameCityCapital",if(_allowSmall isEqualTo 1)then{"nameLocal"}], _rad];
		_usedLocs = uiNamespace getVariable "vemfUsedLocs";
		_remLocs = [];
		{ // Check _locs for invalid locations (too close, hasPlayers or inBlacklist)
			_hasPlayers = [locationPosition _x, _playerCheck] call VEMF_fnc_checkPlayerPresence;
			if (_hasPlayers OR (text _x) in _blackList OR _cntr distance (locationPosition _x) < _tooCloseRange OR [text _x, locationPosition _x] in _usedLocs) then
		 	{
				_remLocs pushBack _x;
			};
		} forEach _locs;

		{ // Remove all invalid locations from _locs
			_index = _locs find _x;
			_locs deleteAt _index;
		} forEach _remLocs;

		// Check what kind of distances we have
		_far = []; // Further than _maxPrefered
		_pref = []; // Closer then _maxPrefered
		{
			_dist = _cntr distance (locationPosition _x);
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

		// Check if there are any prefered locations. If yes, randomly select one
		if (count _pref > 0) then
		{
			_loc = _pref select floor random count _pref;
		};

		// Check if _far has any locations and if _pref is empty
		if (count _far > 0 AND count _pref isEqualTo 0) then
		{
			_loc = _far select floor random count _far;
		};

		// Validate _locs just to prevent the .RPT from getting spammed
		if (count _locs isEqualTo 0) exitWith
		{
			["fn_findPos", 0, "No valid locations found!"] call VEMF_fnc_log
		};

		// Return Name and POS
		_locPos = [((locationPosition _loc) select 0), ((locationPosition _loc) select 1), 0];
		_locName = (text _loc);
		_ret = [_locName, _locPos];
		_usedLocs pushBack _ret;
	};
	case "pos":
	{
		_valid = false;
		for "_p" from 1 to 10 do
		{
			_pos = [_cntr, _tooCloseRange, _rad, 2, 0, 500, 0] call BIS_fnc_findSafePos;
			if _onRoad then
			{
				_roads = _pos nearRoads _roadRange;
				if (count _roads > 0) then
				{
					private ["_closest","_dist"];
					_closest = ["", _roadRange];
					{ // Find the closest road
						_dist = _x distance _pos;
						if (_dist < (_closest select 1)) then
						{
							_closest = [_x, _dist];
						};
					} forEach _roads;
					_pos = position (_closest select 0);
				};
			};
			_hasPlayers = [_pos, _playerCheck] call VEMF_fnc_checkPlayerPresence;
			if not(_hasPlayers) exitWith
			{
				_ret = _pos;
			};
		};
		if _hasPlayers exitWith
		{
			_ret = false;
			["fn_findPos", 0, "unable to find a good _pos! Oops..."] call VEMF_fnc_log;
		};
	};
};

_ret
