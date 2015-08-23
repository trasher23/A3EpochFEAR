/*
    Author: IT07

    Description:
    gets config value of given var from VEMF config OR cfgPath

	Params:
	method 1:
		_this: STRING - SINGLE config value to get from root of VEMFconfig
	method 2:
		_this select 0: ARRAY of STRINGS - MULTIPLE config values to get from root of VEMFconfig
	method 3:
		_this select 0: ARRAY of STRINGS - config path to get value from. Example: "root","subclass"
		_this select 1: ARRAY of STRINGS - MULTIPLE config values to get from given path

    Returns:
    ARRAY - Result
*/

private["_cfg","_v","_r","_path"];
_r = [];
_check =
{
	if (isNumber _cfg) exitWith { _v = getNumber _cfg };
	if (isText _cfg) exitWith { _v = getText _cfg };
	if (isArray _cfg) exitWith { _v = getArray _cfg };
};
switch true do
{
	case (typeName _this isEqualTo "STRING"):
	{
		_cfg = configFile >> "VEMFconfig" >> _this;
		call
		{
			if (isNumber _cfg) exitWith { _v = getNumber _cfg };
			if (isText _cfg) exitWith { _v = getText _cfg };
			if (isArray _cfg) exitWith { _v = getArray _cfg };
			_v = nil; // Value
		};
		if not(isNil"_v") exitWith
		{
			_r = _v;
		};
	};
	case (typeName _this isEqualTo "ARRAY"):
	{
		switch (count _this) do
		{
			case 2:
			{
				_cfg = configFile;
				_path = _cfg;
				{
					_path = _path >> _x; // Build the config path
				} forEach (_this select 0);
				{
					_cfg = _path >> _x;
					call _check;
					_r pushBack _v;
				} forEach (_this select 1);
			};
			case 1:
			{
				{
					_cfg = configFile >> "VEMFconfig" >> _x;
					call _check;
					_r pushBack _v;
				} forEach (_this select 0);
			};
		};
	};
	default
	{
		["fn_getSetting", 0, format["typeName _this is %1", typeName _this]] call VEMF_fnc_log
	};
};

if (isNil"_v") then
{
	_r = "No result";
};
_r
