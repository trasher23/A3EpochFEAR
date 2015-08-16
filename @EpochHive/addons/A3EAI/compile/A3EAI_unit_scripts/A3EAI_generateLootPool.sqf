private ["_lootPool","_groupSize"];
_lootPool = _this getVariable ["LootPool",[]];
_groupSize = _this getVariable ["GroupSize",0];

for "_j" from 1 to _groupSize do {
	//Add first aid kit to loot list
	if (A3EAI_chanceFirstAidKit call A3EAI_chance) then {
		_lootPool pushBack "FAK";
	};

	//Add food to loot list
	for "_i" from 1 to A3EAI_foodLootCount do {
		if (A3EAI_chanceFoodLoot call A3EAI_chance) then {
			_lootPool pushBack (A3EAI_foodLoot call A3EAI_selectRandom);
		};
	};

	//Add items to loot list
	for "_i" from 1 to A3EAI_miscLootCount1 do {
		if (A3EAI_chanceMiscLoot1 call A3EAI_chance) then {
			_lootPool pushBack (A3EAI_MiscLoot1 call A3EAI_selectRandom);
		};
	};

	//Add items to loot list
	for "_i" from 1 to A3EAI_miscLootCount2 do {
		if (A3EAI_chanceMiscLoot2 call A3EAI_chance) then {
			_lootPool pushBack (A3EAI_MiscLoot2 call A3EAI_selectRandom);
		};
	};
	sleep 0.5;
};

//Update local group loot pool
_this setVariable ["LootPool",_lootPool];

true