/*
    Author: IT07

    Description:
    gets config value of given var from VEMF config

    Returns:
    ARRAY - Result
*/

private["_cfg","_v"];
_r = []; // Result ARRAY
{
	_cfg = (configFile >> "VEMFconfig" >> _x);
	call
	{
		if (isNumber _cfg) exitWith { _v = getNumber _cfg };
		if (isText _cfg) exitWith { _v = getText _cfg };
		if (isArray _cfg) exitWith { _v = getArray _cfg };
		_v = nil; // Value
	};
	_r pushBack _v;
} forEach _this;

if (isNil"_v") then
{
	_r = "No result";
};
_r
