/*
    Author: IT07

    Description:
    checks if player count is above or equal to given number. If no number given, default of 1 will be used.

    Params:
    none

    Returns:
    ARRAY - [false if current player count is below minimum, true of more than minimum]
*/

private ["_minimum","_players","_params"];
if not((typeName _this) isEqualTo "SCALAR") then { _params = [1]; } else { _params = _this; };
_minimum = [_params, 0, 1, ["SCALAR"]] call BIS_fnc_param;
_players = 0;
{
    if (isPlayer _x AND (side _x) isEqualTo EAST) then
    {
        _players = _players + 1;
    };
} forEach playableUnits;

if (_players > _minimum OR _players isEqualTo _minimum) exitWith
{
    true
};

false
