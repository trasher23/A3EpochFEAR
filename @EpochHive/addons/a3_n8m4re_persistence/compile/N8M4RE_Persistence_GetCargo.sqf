private ["_weaponCargo","_itemCargo","_magCargo","_magAmmo","_backpackCargo"];
_weaponCargo = weaponsItemsCargo _this;
if(isNil "_weaponCargo")then{_weaponCargo=[];};
_itemCargo = getItemCargo _this;
if(isNil "_itemCargo")then{_itemCargo=[];};
_magCargo = magazinesAmmoCargo _this;
if(isNil "_magCargo")then{_magCargo=[];};
_magAmmo = [[],[]];
{
	_arr = _magAmmo find(_x select 0);
	if (_arr >=0) then {
		(_magAmmo select 1) set[_arr,((_magAmmo select 1) select _arr) + (_x select 1)];
	} else {
		(_magAmmo select 0) pushBack (_x select 0);
		(_magAmmo select 1) pushBack (_x select 1);
	};
} forEach _magCargo;
_backpackCargo = getBackpackCargo _this;
if(isNil "_backpackCargo")then{_backpackCargo=[];};
[_weaponCargo,_itemCargo,_magAmmo,_backpackCargo]
