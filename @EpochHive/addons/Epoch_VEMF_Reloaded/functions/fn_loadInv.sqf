/*
	Author: IT07

	Description:
	loads AI inventory

	Param:
	_this: ARRAY
	_this select 0: ARRAY - units to load inventory for
	_this select 1: STRING - what type of mission the loadout should be for

	Returns:
	BOOLEAN - true if nothing failed
*/

_ok = false;
private [
	"_params","_units","_mode","_useLaunchers","_aiGear","_launchers","_launcherChance"
];
_params = _this;
if (typeName _this isEqualTo "ARRAY") then
{
	_units = [_this, 0, [], [[]]] call BIS_fnc_param;
	if (count _units > 0) then
	{
		_mode = [_this, 1, "", [""]] call BIS_fnc_param;
		if not(_mode isEqualTo "") then
		{
			// Define settings
			_aiGear = [["aiGear"],["aiLaunchers"]] call VEMFr_fnc_getSetting;
			_useLaunchers = "useLaunchers" call VEMFr_fnc_getSetting;
			if (_useLaunchers isEqualTo 1) then
			{
				_launchers = _aiGear select 0;
				_launcherChance = "launcherChance" call VEMFr_fnc_getSetting;
			};
			
			{
				private ["_unit","_gear","_ammo"];
				_unit = _x;
				// Strip it
				removeAllWeapons _unit;
				removeAllItems _unit;
				removeUniform _unit;
				removeVest _unit;
				removeBackpack _unit;
				removeGoggles _unit;
				removeHeadGear _unit;
				
				// FEAR - Quarantine Equipment
				_unit addGoggles "G_mas_wpn_gasmask";
				_unit forceAddUniform "U_C_Scientist";
				
				// Vest
				_gear = A3EAI_vestTypes0 call VEMFr_fnc_random;
				_unit addVest _gear;
				
				// Backpack
				_gear = A3EAI_backpackTypes0 call VEMFr_fnc_random;
				_unit addBackpack _gear;
				
				// Add Weapons & Ammo
				
				// Launcher
				if (_useLaunchers isEqualTo 1) then
				{
					if (random 1 < (_launcherChance/ 100*1)) then
					{
						private ["_ammo"];
						_gear = _launchers call VEMFr_fnc_random;
						_unit addWeapon _gear;
						_ammo = getArray (configFile >> "cfgWeapons" >> _gear >> "magazines");
						if (count _ammo > 2) then
						{
							_ammo resize 2;
						};
						for "_i" from 0 to (2 + (round random 1)) do
						{
							_unit addMagazine (_ammo select floor random count _ammo);
						};
					};
				};
				
				// Primary
				_gear = A3EAI_rifleList call VEMFr_fnc_random;
				_unit addWeapon _gear;
				_unit selectWeapon _gear;
				_ammo = getArray (configFile >> "cfgWeapons" >> _gear >> "magazines");
				if (count _ammo > 2) then
				{
					_ammo resize 2;
				};
				for "_i" from 0 to (3 + (round random 2)) do
				{
					_unit addMagazine (_ammo select floor random count _ammo);
				};
				
				// Secondary
				_gear = A3EAI_pistolList call VEMFr_fnc_random;
				_unit addWeapon _gear;
				_ammo = getArray (configFile >> "cfgWeapons" >> _gear >> "magazines");
				for "_i" from 0 to (2 + (round random 2)) do
				{
					_unit addMagazine (_ammo select floor random count _ammo);
				};
				
			} forEach _units;
			
			_ok = true;
		};
	};
};
_ok
