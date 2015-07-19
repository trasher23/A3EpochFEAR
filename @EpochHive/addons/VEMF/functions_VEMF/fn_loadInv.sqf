/*
	Author: VAMPIRE, rebooted by IT07

	Description:
	loads AI inventory

	Returns:
	BOOLEAN - true if finished
*/

private ["_unit","_fin","_prim","_seco","_pAmmo","_hAmmo","_attachment","_uniforms"];
// Define settings
_uniforms = (["aiUniforms"] call VEMF_fnc_getSetting) select 0;
_headGear = (["aiHeadGear"] call VEMF_fnc_getSetting) select 0;
_vests = (["aiVests"] call VEMF_fnc_getSetting) select 0;
_backpacks = (["backpacksLoot"] call VEMF_fnc_getSetting) select 0;
_useLaunchers = (["useLaunchers"] call VEMF_fnc_getSetting) select 0;
_launchers = (["aiLaunchers"] call VEMF_fnc_getSetting) select 0;
_aiItems = (["aiItems"] call VEMF_fnc_getSetting) select 0;
_rifles = (["aiRifles"] call VEMF_fnc_getSetting) select 0;
_pistols = (["aiPistols"] call VEMF_fnc_getSetting) select 0;

_unit = _this select 0;
_mode = _this select 1;
_fin = false;

if (!isNull _unit) then
{
	// Strip Unit
	removeAllWeapons _unit;
	{
		_unit removeMagazine _x;
		uiSleep 0.05;
	} foreach (magazines _unit);

	removeAllItems _unit;
	removeUniform _unit;
	removeVest _unit;
	removeBackpack _unit;
	removeGoggles _unit;
	removeHeadGear _unit;

	// Add Uniform
	_unit forceAddUniform (_uniforms call BIS_fnc_selectRandom);

	// Add Headgear
	_unit addHeadGear (_headGear call BIS_fnc_selectRandom);

	if ((floor random 3) isEqualTo 2) then
	{
		_unit addVest (_vests call BIS_fnc_selectRandom);
	};

	// 50% chance of unit with backpack
	if ((floor random 2) isEqualTo 0 AND _mode isEqualTo "Invasion") then
	{
		_unit addBackpack (_backpacks call BIS_fnc_selectRandom);
		if (_useLaunchers isEqualTo 1) then
		{
			_launcher = _launchers call BIS_fnc_selectRandom;
			_unit addWeapon _launcher;
			_lAmmo = [] + getArray (configFile >> "cfgWeapons" >> _launcher >> "magazines");
			{
				for "_i" from 0 to (floor(random 3)+2) do
				{
					_unit addMagazine _x;
				};
				uiSleep 0.05;
			} forEach _lAmmo;
		};
	};

	// Add Food/Drink
	if ((floor random 2) isEqualTo 1) then
	{
		_unit addMagazine (_aiItems call BIS_fnc_selectRandom);
	};

	// Add Weapons & Ammo
	_prim = _rifles call BIS_fnc_selectRandom;

	_seco = _pistols call BIS_fnc_selectRandom;

	_pAmmo = [] + getArray (configFile >> "cfgWeapons" >> _prim >> "magazines");
	{
		for "_i" from 0 to (floor(random 4)+2) do
		{
			_unit addMagazine _x;
		};
		uiSleep 0.05;
	} forEach _pAmmo;



	_hAmmo = [] + getArray (configFile >> "cfgWeapons" >> _seco >> "magazines");
	{
		//if (isClass(configFile >> "CfgPricing" >> _x)) exitWith
		//{
			for "_i" from 0 to (floor(random 5)+2) do
			{
				_unit addMagazine _x;
			};
		//};
		uiSleep 0.05;
	} forEach _hAmmo;

	_unit addWeapon _prim;
	_unit selectWeapon _prim;
	_unit addWeapon _seco;

	// Add Grenades for GL Units
	if ((count(getArray (configFile >> "cfgWeapons" >> _prim >> "muzzles"))) > 1) then
	{
		_unit addMagazine "1Rnd_HE_Grenade_shell";
	};

	// 20% Chance Hand Grenade
	// Random Returns 0,1,2,3,4
	if ((floor(random(5))) == 2) then
	{
		_unit addMagazine "HandGrenade";
	};

	// 10% Scope Attachment Chance
	if ((floor(random(10))) == 5) then
	{
		_attachment = (getArray (configFile >> "cfgLootTable" >> "Scopes" >> "items")) call BIS_fnc_selectRandom;
		_unit addPrimaryWeaponItem str(_attachment select 0);
	};

	_fin = true;
};

_fin
