/*
	Author: IT07

	Description:
	loads loot crate inventory
	Modified to use A3EAI dynamic loot lists

	Returns:
	BOOL - true if everything went ok
*/

private
[
	"_crate","_maxSlots","_minSlots","_ammo","_ammos",
	"_rifle","_rifles","_pistol","_pistols","_machinegun","_machineguns","_sniper","_snipers",
	"_attachment","_attachments","_item","_items","_backpack","_backpacks",
	"_headGear","_headGearItem","_vest","_vests","_ok"
];

_ok = false;

// Define _vars
_crate = [_this, 0, objNull, [objNull]] call BIS_fnc_param;
if not isNull _crate then
{
	clearWeaponCargoGlobal _crate;
	clearMagazineCargoGlobal _crate;
	clearItemCargoGlobal _crate;
	clearBackpackCargoGlobal  _crate;
	
	_maxSlots = 3;
	_minSlots = 1;
	
	_rifles = A3EAI_rifleList;
	_pistols = A3EAI_pistolList;
	_machineguns = A3EAI_machinegunList;
	_snipers = A3EAI_sniperList;
	_attachments = A3EAI_weaponOpticsList;
	_items = A3EAI_MiscLoot1;
	_backpacks = A3EAI_backpackTypes0;
	_headGear = A3EAI_headgearTypes0;
	_vests = A3EAI_vestTypes0;

	// Add rifles
	for "_j" from 0 to (_maxSlots - _minSlots + floor random _minSlots) do {
		
		_rifle = _rifles call BIS_fnc_selectRandom;
		_crate addWeaponCargoGlobal [_rifle, 1]; // Add one of each
		
		// Add ammo for weapon
		_ammos = [] + getArray (configFile >> "cfgWeapons" >> _rifle >> "magazines");
		if (count _ammos > 0) then {
			_ammoamount = ceil(random 5);
			for "_i" from 1 to _ammoamount do {
				_ammo = _ammos select 0;
				_crate addMagazineCargoGlobal [_ammo, 1]; // Add one of each
			};
		};
		
	};
	
	// pistols
	for "_j" from 0 to (_maxSlots - _minSlots + floor random _minSlots) do {
		
		_pistol = _pistols call BIS_fnc_selectRandom;
		_crate addWeaponCargoGlobal [_pistol, 1];
		
		// Add ammo for weapon
		_ammos = [] + getArray (configFile >> "cfgWeapons" >> _pistol >> "magazines");
		if (count _ammos > 0) then {
			_ammoamount = ceil(random 5);
			for "_i" from 1 to _ammoamount do {
				_ammo = _ammos select 0;
				_crate addMagazineCargoGlobal [_ammo, 1];
			};
		};
		
	};
	
	// machineguns
	for "_j" from 0 to (_maxSlots - _minSlots + floor random _minSlots) do {
		
		_machinegun = _machineguns call BIS_fnc_selectRandom;
		_crate addWeaponCargoGlobal [_machinegun, 1];
		
		// Add ammo for weapon
		_ammos = [] + getArray (configFile >> "cfgWeapons" >> _machinegun >> "magazines");
		if (count _ammos > 0) then {
			_ammoamount = ceil(random 5);
			for "_i" from 1 to _ammoamount do {
				_ammo = _ammos select 0;
				_crate addMagazineCargoGlobal [_ammo, 1];
			};
		};
		
	};
	
	// snipers
	for "_j" from 0 to (_maxSlots - _minSlots + floor random _minSlots) do {
		
		_sniper = _snipers call BIS_fnc_selectRandom;
		_crate addWeaponCargoGlobal [_sniper, 1];
		
		// Add ammo for weapon
		_ammos = [] + getArray (configFile >> "cfgWeapons" >> _sniper >> "magazines");
		if (count _ammos > 0) then {
			_ammoamount = ceil(random 5);
			for "_i" from 1 to _ammoamount do {
				_ammo = _ammos select 0;
				_crate addMagazineCargoGlobal [_ammo, 1];
			};
		};
		
	};
	
	// attachments
	for "_j" from 0 to (_maxSlots - _minSlots + floor random _minSlots) do {
		_attachment = _attachments call BIS_fnc_selectRandom;
		_crate addItemCargoGlobal [_attachment, 1];
	};
	
	// items
	for "_j" from 0 to (_maxSlots - _minSlots + floor random _minSlots) do {
		_item = _items call BIS_fnc_selectRandom;
		_crate addItemCargoGlobal [_item, ceil(random 5)];
	};
	
	// backpacks
	for "_j" from 0 to (_maxSlots - _minSlots + floor random _minSlots) do {
		_backpack = _backpacks call BIS_fnc_selectRandom;
		_crate addBackpackCargoGlobal [_backpack, 1];
	};
	
	// Helmets / caps / berets / bandanas
	for "_j" from 0 to (_maxSlots - _minSlots + floor random _minSlots) do {
		_headGearItem = _headGear call BIS_fnc_selectRandom;
		_crate addItemCargoGlobal [_headGearItem, 1];
	};
	
	// Vests
	for "_j" from 0 to (_maxSlots - _minSlots + floor random _minSlots) do {
		_vest = _vests call BIS_fnc_selectRandom;
		_crate addItemCargoGlobal [_vest, 1];
	};
	
	_ok = true;
};
_ok
