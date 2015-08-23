/*
    Author: IT07

    Description:
    checks for players within given distance of given location/position

    Returns:
    BOOLEAN - true if player(s) found
*/

private ["_pos","_rad","_objs","_found"]; // Prevents these variables overwriting existing vars from where this was called from
_pos = _this select 0;
_rad = _this select 1;

// By default, we assume that there are no players close. The distance check below should prove otherwise if there are players close
_found = false;

// Check all player distances from _loc
{
    if ((call VEMF_fnc_playerCount) AND (speed _x) < 200) then // Ignore fast moving players
    {
        _isClose = if (((position _x) distance _pos) < _rad) then { true } else { false };
        if _isClose exitWith
        {
            _found = true;
        };
    };
    if _found exitWith {};
} forEach playableUnits;

_found
