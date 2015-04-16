private ["_startTime", "_foodList", "_items", "_itemClassInfo", "_itemClassBias", "_itemClassType", "_itemList", "_itemInfo", "_itemBias", "_itemType", "_item","_itemClass"];

_startTime = diag_tickTime;

_foodList = [configFile >> "CfgLootTable" >> "Food","items",[]] call BIS_fnc_returnConfigEntry;
_items = [];
{
	_itemClassInfo = _x select 0;
	_itemClassBias = _x select 1;
	_itemClassType = _itemClassInfo select 1;
	call {
		if (_itemClassType isEqualTo "CfgLootTable") exitWith {
			_itemClass = _itemClassInfo select 0;
			_itemList = [configFile >> "CfgLootTable" >> _itemClass,"items",[]] call BIS_fnc_returnConfigEntry;
			{
				_itemInfo = _x select 0;
				_itemBias = _x select 1;
				_itemType = _itemInfo select 1;
				if (_itemType isEqualTo "magazine") then {
					_item = _itemInfo select 0;
					_items pushBack _item;
				};
			} forEach _itemList;
		};
		if (_itemClassType isEqualTo "magazine") exitWith {
			_item = _itemClassInfo select 0;
			_items pushBack _item;
		};
	};
} forEach _foodList;

if !(_items isEqualTo []) then {
	A3EAI_foodLoot = _items;
	if (A3EAI_debugLevel > 0) then {diag_log format ["A3EAI Debug: Generated %1 food classnames in %2 seconds.",(count _items),diag_tickTime - _startTime]};
} else {
	diag_log "A3EAI Error: Could not dynamically generate food classname list. Classnames from A3EAI_config.sqf used instead.";
};
