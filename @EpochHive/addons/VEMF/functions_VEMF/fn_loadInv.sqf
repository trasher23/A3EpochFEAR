/*
	Author: VAMPIRE, rebooted by IT07

	Description:
	loads AI inventory

	Param:
	_this: ARRAY
	_this select 0: ARRAY - units to load inventory for
	_this select 1: STRING - what type of mission the loadout should be for

	Returns:
	BOOLEAN - true if nothing failed
*/

private ["_params","_units","_mode","_settings","_useLaunchers","_aiGear","_uniforms","_headGear","_vests","_backpacks","_launchers","_rifles","_pistols"];
_params = _this;
if not((typeName _this) isEqualTo "ARRAY") exitWith
{
	["fn_loadInv", 0, "incorrect params given!"] call VEMF_fnc_log;
	false
};

_units = [_this, 0, [], [[]]] call BIS_fnc_param;
if (_units isEqualTo []) exitWith
{
	["fn_loadInv", 0, "incorrect or no units given!"] call VEMF_fnc_log;
	false
};

_mode = [_this, 1, "", [""]] call BIS_fnc_param;
if (_mode isEqualTo "") exitWith
{
	["fn_loadInv", 0, "incorrect OR missing _mode..."] call VEMF_fnc_log;
	false
};

// Define settings
_useLaunchers = ([["VEMFconfig","DLI"],["useLaunchers"]] call VEMF_fnc_getSetting) select 0;

_aiGear = [["VEMFconfig","aiGear"],["aiUniforms","aiHeadGear","aiVests","aiBackpacks","aiLaunchers","aiRifles","aiPistols"]] call VEMF_fnc_getSetting;
_uniforms = _aiGear select 0;
_headGear = _aiGear select 1;
_vests = _aiGear select 2;
_backpacks = _aiGear select 3;
_launchers = _aiGear select 4;
_rifles = _aiGear select 5;
_pistols = _aiGear select 6;

{
	private ["_unit","_gear","_hasVest","_ammo"];
	_unit = _x;
	// Strip it
	removeAllWeapons _unit;
	removeAllItems _unit;
	removeUniform _unit;
	removeVest _unit;
	removeBackpack _unit;
	removeGoggles _unit;
	removeHeadGear _unit;
	{ // Remove all magazines
		_unit removeMagazine _x;
	} foreach (magazines _unit);

	_gear = _uniforms call VEMF_fnc_random;
	_unit forceAddUniform _gear; // Give the poor naked guy some clothing :)

	_gear = _headGear call VEMF_fnc_random;
	_unit addHeadGear _gear;

	if ((floor random 3) isEqualTo 2) then
	{
		_gear = _vests call VEMF_fnc_random;
		_unit addVest _gear;
		_hasVest = true;
	};

	if ((floor random 2) isEqualTo 0 OR isNil"_hasVest") then
	{
		_gear = _backpacks call VEMF_fnc_random;
		_unit addBackpack _gear;
		if (_useLaunchers isEqualTo 1 AND (floor random 4) isEqualTo 0) then
		{
			_gear = _launchers call VEMF_fnc_random;
			_unit addWeapon _gear;
			_ammo = [] + getArray (configFile >> "cfgWeapons" >> _gear >> "magazines");
			{
				for "_i" from 0 to (1+(round random 2)) do
				{
					_unit addMagazine _x;
				};
			} forEach _ammo;
		};
	};

	// Add Weapons & Ammo
	_gear = _rifles call VEMF_fnc_random;
	_unit addWeapon _gear;
	_unit selectWeapon _gear;

	_ammo = [] + getArray (configFile >> "cfgWeapons" >> _gear >> "magazines");
	{
		for "_i" from 0 to (3+(round random 2)) do
		{
			_unit addMagazine _x;
		};
	} forEach _ammo;

	if not isNil"_hasVest" then
	{
		_gear = _pistols call VEMF_fnc_random;
		_unit addWeapon _gear;
		_ammo = [] + getArray (configFile >> "cfgWeapons" >> _gear >> "magazines");
		{
			for "_i" from 0 to (1+(round random 2)) do
			{
				_unit addMagazine _x;
			};
		} forEach _ammo;
	};
} forEach _units;
true
