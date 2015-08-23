/*
	Author: VAMPIRE, rebooted by IT07

	Description:
	loads loot crate inventory
*/
private
[
	"_crate","_settings","_loot","_amount","_quant","_prim","_sec","_mags","_att","_items","_vests","_packs","_primaries","_secondaries",
	"_magazines","_attachments","_items","_vests","_backpacks","_headGear","_blackList","_maxPrim","_minPrim","_maxSec","_minSec",
	"_maxMagSlots","_minMagSlots","_maxAttSlots","_minAttSlots","_maxItemSlots","_minItemSlots","_maxVestSlots","_minVestSlots",
	"_maxHeadGearSlots","_minHeadGearSlots","_maxBagSlots","_minBagSlots"
];

// Define _vars
_crate = _this select 0;
_settings = [["VEMFconfig","crateLoot"],["maxPrimarySlots","minPrimarySlots","maxSecondarySlots","minSecondarySlots","maxMagSlots","minMagsSlots","maxAttSlots","minAttSlots","maxItemSlots","minItemSlots","maxVestSlots","minVestSlots","maxHeadGearSlots","minHeadGearSlots","maxBagSlots","minBagSlots"]] call VEMF_fnc_getSetting;
_maxPrim = _settings select 0;
_minPrim = _settings select 1;
_maxSec = _settings select 2;
_minSec = _settings select 3;
_maxMagSlots = _settings select 4;
_minMagSlots = _settings select 5;
_maxAttSlots = _settings select 6;
_minAttSlots = _settings select 7;
_maxItemSlots = _settings select 8;
_minItemSlots = _settings select 9;
_maxVestSlots = _settings select 10;
_minVestSlots = _settings select 11;
_maxHeadGearSlots = _settings select 12;
_minHeadGearSlots = _settings select 13;
_maxBagSlots = _settings select 14;
_minBagSlots = _settings select 15;

_loot = [["VEMFconfig","crateLoot"],["primaryWeaponLoot","secondaryWeaponLoot","magazinesLoot","attachmentsLoot","itemsLoot","vestsLoot","backpacksLoot","headGearLoot","blackListLoot"]] call VEMF_fnc_getSetting;
_primaries = _loot select 0;
_secondaries = _loot select 1;
_magazines = _loot select 2;
_attachments = _loot select 3;
_items = _loot select 4;
_vests = _loot select 5;
_backpacks = _loot select 6;
_headGear = _loot select 7;
_blackList = _loot select 8;

// Delay Cleanup
//_crate setVariable ["LAST_CHECK", (diag_tickTime + 1800)]; // Disabled for now. Let us see what it does

// Empty Crate
clearWeaponCargoGlobal _crate;
clearMagazineCargoGlobal _crate;
clearBackpackCargoGlobal  _crate;
clearItemCargoGlobal _crate;

// Add primary weapons
for "_j" from 0 to (_maxPrim - _minPrim + floor random _minPrim) do
{
	_prim = _primaries call BIS_fnc_selectRandom;
	if ((_prim select 0) in _blackList) then
	{
		["fn_loadLoot", 1, format["rifle spawn %1 denied. Is in blacklist", _prim]] call VEMF_fnc_log;
	} else
	{
		_crate addWeaponCargoGlobal [_prim select 0, _prim select 1];
	};
};

// Secondary weapons
for "_j" from 0 to (_maxSec - _minSec + floor random _minSec) do
{
	_sec = _secondaries call BIS_fnc_selectRandom;
	if ((_sec select 0) in _blackList) then
	{
		["fn_loadLoot", 1, format["pistol spawn %1 denied. Is in blacklist", _sec]] call VEMF_fnc_log;
	} else
	{
		_crate addWeaponCargoGlobal [_sec select 0, _sec select 1];
	};
};

// Magazines
for "_j" from 0 to (_maxMagSlots - _minMagSlots + floor random _minMagSlots) do
{
	_mag = _magazines call BIS_fnc_selectRandom;
	if ((_mag select 0) in _blackList) then
	{
		["fn_loadLoot", 1, format["spawning of magazine (%1) denied. Is in _blackList", _mag]] call VEMF_fnc_log;
	} else
	{
		_crate addMagazineCargoGlobal [_mag select 0, _mag select 1];
	};
};

// Weapon attachments
for "_j" from 0 to (_maxAttSlots - _minAttSlots + floor random _minAttSlots) do
{
	_att = _attachments call BIS_fnc_selectRandom;
	if ((_att select 0) in _blackList) then
	{
		["fn_loadLoot", 1, format["Spawning of attachment (%1) denied. Is in _blacklist", _att]] call VEMF_fnc_log;
	} else
	{
		_crate addItemCargoGlobal [_att select 0, _att select 1];
	};
};

// Items
for "_j" from 0 to (_maxItemSlots - _minItemSlots + floor random _minItemSlots) do
{
	_item = _items call BIS_fnc_selectRandom;
	if ((_item select 0) in _blacklist) then
	{
		["fn_loadLoot", 1, format["Spawning of _item (%1) denied. Is in _blacklist", _item]] call VEMF_fnc_log;
	} else
	{
		_crate addItemCargoGlobal [_item select 0, _item select 1];
	};
};

// Vests
for "_j" from 0 to (_maxVestSlots - _minVestSlots + floor random _minVestSlots) do
{
	_vest = _vests call BIS_fnc_selectRandom;
	if ((_vest select 0) in _blackList) then
	{
		["fn_loadLoot", 1, format["Spawning of _vest (%1) denied. Is in _blackList", _vest]] call VEMF_fnc_log;
	} else
	{
		_crate addItemCargoGlobal [_vest select 0, _vest select 1];
	};
};

// Helmets / caps / berets / bandanas
for "_j" from 0 to (_maxHeadGearSlots - _minHeadGearSlots + floor random _minHeadGearSlots) do
{
	_headGearItem = _headGear call BIS_fnc_selectRandom;
	if ((_headGearItem select 0) in _blackList) then
	{
		["fn_loadLoot", 1, format["Spawning of _headGearItem (%1) denied. Is in _blackList", _headGearItem]] call VEMF_fnc_log;
	} else
	{
		_crate addItemCargoGlobal [_headGearItem select 0, _headGearItem select 1];
	};
};

// Backpacks
for "_j" from 0 to (_maxBagSlots - _minBagSlots + floor random _minBagSlots) do
{
	_pack = _backpacks call BIS_fnc_selectRandom;
	if ((_pack select 0) in _blackList) then
	{
		["fn_loadLoot", 1, format["Spawning of _pack (%1) denied. Is in _blackList", _pack]] call VEMF_fnc_log;
	} else
	{
		_crate addBackpackCargoGlobal [_pack select 0, _pack select 1];
	};
};

true
