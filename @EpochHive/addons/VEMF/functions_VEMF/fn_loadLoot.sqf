/*
	Author: VAMPIRE, rebooted by IT07

	Description:
	loads loot crate inventory
*/
private ["_crate","_prim","_sec","_mags","_att","_items","_vests","_packs","_primaries","_secondaries","_magazines","_attachments","_items","_vests","_backpacks","_headGear","_blackList"];

// Define _vars
_crate = _this select 0;
_primaries = (["primaryWeaponLoot"] call VEMF_fnc_getSetting) select 0;
_secondaries = (["secondaryWeaponLoot"] call VEMF_fnc_getSetting) select 0;
_magazines = (["magazinesLoot"] call VEMF_fnc_getSetting) select 0;
_attachments = (["attachmentsLoot"] call VEMF_fnc_getSetting) select 0;
_items = (["itemsLoot"] call VEMF_fnc_getSetting) select 0;
_vests = (["vestsLoot"] call VEMF_fnc_getSetting) select 0;
_backpacks = (["backpacksLoot"] call VEMF_fnc_getSetting) select 0;
_headGear = (["headGearLoot"] call VEMF_fnc_getSetting) select 0;
_blackList = (["blackListLoot"] call VEMF_fnc_getSetting) select 0;

// Delay Cleanup
_crate setVariable ["LAST_CHECK", (diag_tickTime + 1800)];

// Empty Crate
clearWeaponCargoGlobal _crate;
clearMagazineCargoGlobal _crate;
clearBackpackCargoGlobal  _crate;
clearItemCargoGlobal _crate;

// Add primary weapons
_amount = [6,6,5,8,6,7,5,5,7,5,6,6,4,8,8,8,8,7,6,9,6];
_quant = [2,3,5,2,2,3,3,2,3,1,2,4,3,2,2,2,3,1,1,1,1];
for "_j" from 0 to (_amount select floor random count _amount) do
{
	_prim = _primaries call BIS_fnc_selectRandom;
	if (_prim in _blackList) then
	{
		diag_log format["[VEMF] loadLoot: rifle spawn %1 denied. Is in blacklist", _prim];
	} else
	{
		_crate addWeaponCargoGlobal [_prim,(_quant select floor random count _quant)];
	};
	uiSleep 0.05;
};

// Secondary weapons
_amount = [2,3,3,4,4,4,2,3,5];
_quant = [2,3,1,1,2,3,4,2,3,2,3,1,1,1];
for "_j" from 0 to (_amount select floor random count _amount) do
{
	_sec = _secondaries call BIS_fnc_selectRandom;
	if (_sec in _blackList) then
	{
		diag_log format["[VEMF] loadLoot: pistol spawn %1 denied. Is in blacklist", _sec];
	} else
	{
		_crate addWeaponCargoGlobal [_sec,(_quant select floor random count _quant)];
	};
	uiSleep 0.05;
};

// Magazines
_amount = [6,7,4,5,8,5,6,4,6,7,5,6,4,6,6,7,7,7];
_quant = [20,30,32,18,17,12,22,28,25,24,23,21];
for "_j" from 0 to (_amount select floor random count _amount) do
{
	_mag = _magazines call BIS_fnc_selectRandom;
	if (_mag in _blackList) then
	{
		diag_log format["[VEMF] loadLoot: _mag (%1) in _blackList", _mag];
	} else
	{
		_crate addMagazineCargoGlobal [_mag,(_quant select floor random count _quant)];
	};
	uiSleep 0.05;
};

// Weapon attachments
_amount = [4,5,4,6,3,4,5,5,6,7,4,5];
_quant = [2,3,4,2,1,2,1,2,3,4,2,3,2,3,2,2,2,2,3];
for "_j" from 0 to (_amount select floor random count _amount) do
{
	_att = _attachments call BIS_fnc_selectRandom;
	if (_att in _blackList) then
	{
		diag_log format["[VEMF] loadLoot: _att (%1) in _blacklist", _att];
	} else
	{
		_crate addItemCargoGlobal [_att,(_quant select floor random count _quant)];
	};
	uiSleep 0.05;
};

// Items
_amount = [8,4,7];
_quant = [7,4,5,6,2,3,2,3,4,1,2,3,8,9,5,3,2];
for "_j" from 0 to (_amount select floor random count _amount) do
{
	_item = _items call BIS_fnc_selectRandom;
	if (_item in _blacklist) then
	{
		diag_log format["[VEMF] loadLoot: _item (%1) in _blacklist", _item];
	} else
	{
		_crate addItemCargoGlobal [_item,(_quant select floor random count _quant)];
	};
	uiSleep 0.05;
};

// Vests
_amount = [1,2,2,2];
_quant = [1,2];
for "_j" from 0 to (_amount select floor random count _amount) do
{
	_vest = _vests call BIS_fnc_selectRandom;
	if (_vest in _blackList) then
	{
		diag_log format["[VEMF] loadLoot: _vest (%1) in _blackList", _vest];
	} else
	{
		_crate addItemCargoGlobal [_vest,(_quant select floor random count _quant)];
	};
	uiSleep 0.05;
};

// Backpacks
_amount = [2,3,1,2,2,2,3];
for "_j" from 0 to (_amount select floor random count _amount) do
{
	_pack = _backpacks call BIS_fnc_selectRandom;
	if (_pack in _blackList) then
	{
		diag_log format["[VEMF] loadLoot: _pack (%1) in _blackList", _pack];
	} else
	{
		_crate addBackpackCargoGlobal [_pack,1];
	};
	uiSleep 0.05;
};

// Helmets / caps / berets / bandanas
_amount = [2,3,1,2,2,2];
_quant = [2,1,2,2,2];
for "_j" from 0 to (_amount select floor random count _amount) do
{
	_headGearItem = _headGear call BIS_fnc_selectRandom;
	if (_headGearItem in _blackList) then
	{
		diag_log format["[VEMF] loadLoot: _headGearItem (%1) in _blackList", _headGearItem];
	} else
	{
		_crate addItemCargoGlobal [_headGearItem,(_quant select floor random count _quant)];
	};
	uiSleep 0.05;
};
