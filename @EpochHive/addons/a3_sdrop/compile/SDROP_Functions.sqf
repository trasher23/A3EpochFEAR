// PLAYER DEFINED LOOT TABLES - EDIT ITEMS BELOW FOR CRATES
//Defines LOOT types and gets added to the drop crate


SDROPLoadLootFood = {
	private["_crate"];
	_crate = _this select 0;	
	
	//empty crate first
	clearWeaponCargoGlobal _crate;
	clearMagazineCargoGlobal _crate;
	clearBackpackCargoGlobal _crate;
	clearItemCargoGlobal _crate;
	
	_magArr =  getArray(configFile >> "sdropCfg" >> "SDROP_LoadLootFood" >> "magazines");
	_itemArr = getArray(configFile >> "sdropCfg" >> "SDROP_LoadLootFood" >> "items");
	_backArr = getArray(configFile >> "sdropCfg" >> "SDROP_LoadLootFood" >> "backpacks");
	
	{ _crate addMagazineCargoGlobal _x; } forEach (_magArr);
	{ _crate addItemCargoGlobal _x; } forEach (_itemArr);
	{ _crate addBackpackCargoGlobal _x; } forEach (_backArr);

};

SDROPLoadLootSupplies = {
	private["_crate"];
	_crate = _this select 0;
	
	//empty crate first
	clearWeaponCargoGlobal _crate;
	clearMagazineCargoGlobal _crate;
	clearBackpackCargoGlobal _crate;
	clearItemCargoGlobal _crate;
	
	_magArr =  getArray(configFile >> "sdropCfg" >> "SDROP_LoadLootSupplies" >> "magazines");
	_itemArr = getArray(configFile >> "sdropCfg" >> "SDROP_LoadLootSupplies" >> "items");
	_weapArr = getArray(configFile >> "sdropCfg" >> "SDROP_LoadLootSupplies" >> "weapons");
	_backArr = getArray(configFile >> "sdropCfg" >> "SDROP_LoadLootSupplies" >> "backpacks");
	
	{ _crate addMagazineCargoGlobal _x; } forEach (_magArr);
	{ _crate addItemCargoGlobal _x; } forEach (_itemArr);
	{ _crate addWeaponCargoGlobal _x; } forEach (_weapArr);
	{ _crate addBackpackCargoGlobal _x; } forEach (_backArr);
};

SDROPLoadLootWeapons = {
	private["_crate"];
	_crate = _this select 0;
	
	//empty crate first
	clearWeaponCargoGlobal _crate;
	clearMagazineCargoGlobal _crate;
	clearBackpackCargoGlobal _crate;
	clearItemCargoGlobal _crate;
	
	_magArr =  getArray(configFile >> "sdropCfg" >> "SDROP_LoadLootWeapons" >> "magazines");
	_itemArr = getArray(configFile >> "sdropCfg" >> "SDROP_LoadLootFood" >> "items");
	_weapArr = getArray(configFile >> "sdropCfg" >> "SDROP_LoadLootWeapons" >> "weapons");
	_backArr = getArray(configFile >> "sdropCfg" >> "SDROP_LoadLootWeapons" >> "backpacks");
	
	{ _crate addMagazineCargoGlobal _x; } forEach (_magArr);
	{ _crate addItemCargoGlobal _x; } forEach (_itemArr);
	{ _crate addWeaponCargoGlobal _x; } forEach (_weapArr);
	{ _crate addBackpackCargoGlobal _x; } forEach (_backArr);
	
};

SDROPLoadLootRandom = {
	[_crate] call SDROPRandomLoot;
};

// Crate Blacklist - These are items that should NOT be in random crate - should eliminate most BE filter issues (may need more testing)
SDROPCrateBlacklist = getArray( configFile >> "sdropCfg" >> "SDROP_Blacklist");


SDROPRandomLoot = {
	private ["_crate","_var","_tmp","_kindOf","_report","_cAmmo"];
	
	_crate = _this select 0;
	
	// Empty Crate
	clearWeaponCargoGlobal _crate;
	clearMagazineCargoGlobal _crate;
	clearBackpackCargoGlobal  _crate;
	clearItemCargoGlobal _crate;
	

		SDROPLootList = [];
		// Generate Loot
		{
			_tmp = (getArray(_x >> 'items'));
			{ SDROPLootList = SDROPLootList + [ ( _x select 0 ) select 0 ]; } forEach (_tmp);
		} forEach ("configName _x != 'Uniforms' && configName _x != 'Headgear'" configClasses (configFile >> "CfgLootTable"));
		//diag_log format ["[SDROPLootList]: %1", SDROPLootList];

	_report = [];
	// Load Random Loot Amount
	for "_i" from 1 to ((floor(random 10)) + 10) do {
		_var = (SDROPLootList call BIS_fnc_selectRandom);
						
		if (!(_var in SDROPCrateBlacklist)) then {
			switch (true) do
			{
				case (isClass (configFile >> "CfgWeapons" >> _var)): {
					_kindOf = [(configFile >> "CfgWeapons" >> _var),true] call BIS_fnc_returnParents;
					if ("ItemCore" in _kindOf) then {
						_crate addItemCargoGlobal [_var,1];
					} else {
						_crate addWeaponCargoGlobal [_var,1];
						
						_cAmmo = [] + getArray (configFile >> "cfgWeapons" >> _var >> "magazines");
						{
							if (isClass(configFile >> "CfgPricing" >> _x)) exitWith {
								_crate addMagazineCargoGlobal [_x,2];
							};
						} forEach _cAmmo;
					};
				};
				case (isClass (configFile >> "cfgMagazines" >> _var)): {
					_crate addMagazineCargoGlobal [_var,1];
				};
				case ((getText(configFile >> "cfgVehicles" >> _var >>  "vehicleClass")) == "Backpacks"): {
					_crate addBackpackCargoGlobal [_var,1];
				};
				default {
					_report = _report + [_var];
				};
			};
		};
	};
	
	if ((count _report) > 0) then {
		diag_log text format ["[SDROP]: LoadLoot: <Unknown> %1", str _report];
	};
};

SDROPBroadcast = {
	private ["_title","_subTitle"];
	
	_title = _this select 0;
	_subTitle = _this select 1;
	_alertMsg = "<t align='center' size='2.0' color='#f29420'>"+ _title + "</t><br/><t size='1.25' color='#ffff00'>______________<br/><br/>"+ _subTitle + "</t>";
	[_alertMsg] call SDROP_Alert;
};

SDROPSetAIWaypoints = {
	private ["_grp","_crate"];
	
	_grp = _this select 0;
	_crate = _this select 1;
	_cratePos = getPos _crate;
	
	_wpPatrolGrid = [
		[(_cratePos select 0)+20, (_cratePos select 1), 0],
		[(_cratePos select 0), (_cratePos select 1)+20, 0],
		[(_cratePos select 0)-20, (_cratePos select 1), 0],
		[(_cratePos select 0), (_cratePos select 1)-20, 0]
	];
	
	for "_i" from 0 to ((count _wpPatrolGrid)-1) do {
		_wp = _grp addWaypoint [(_wpPatrolGrid select _i), 0];
		_wp setWaypointType "SAD";
		_wp setWaypointBehaviour "COMBAT";
		_wp setWaypointCompletionRadius 10;
	};
	
	_cycle = _grp addWaypoint [_cratePos, 20];
	_cycle setWaypointType "CYCLE";
	_cycle setWaypointBehaviour "COMBAT";
	_cycle setWaypointCompletionRadius 10;
};

SDROPLoadAIGear = {
	private ["_unit","_isSniper","_prim","_seco","_pAmmo","_hAmmo"];
	
	_unit = _this select 0;
	_isSniper = _this select 1;
	
	if (!isNull _unit) then {
		removeAllWeapons _unit;
		{_unit removeMagazine _x;} forEach (magazines _unit);
		removeAllItems _unit;
		removeUniform _unit;
		removeVest _unit;
		removeBackpack _unit;
		removeGoggles _unit;
		removeHeadGear _unit;
		
		if (_isSniper) then {
			// Add Sniper Clothing
			_unit forceAddUniform ("U_O_GhillieSuit");
			_unit addHeadGear (SDROPHeadgearList call BIS_fnc_selectRandom);
			_unit addVest (SDROPVestList call BIS_fnc_selectRandom);
			
			// Add Sniper Weapons & Ammo (default M104 with LR scope and ammo)
			_prim = "srifle_LRR_SOS_F";
			_seco = SDROPPistolsList call BIS_fnc_selectRandom;
		} else {
			//clothing
			_unit forceAddUniform (SDROPUniformList call BIS_fnc_selectRandom);
			_unit addHeadGear (SDROPHeadgearList call BIS_fnc_selectRandom);
			_unit addVest (SDROPVestList call BIS_fnc_selectRandom);
			
			//weapons & Ammo
			_prim = SDROPRiflesList call BIS_fnc_selectRandom;
			_seco = SDROPPistolsList call BIS_fnc_selectRandom;
		};
		
		// Give unit parachute
		_unit addBackpack "B_Parachute";
		
		//NV Goggles for night drops
		if (SunOrMoon < 1) then {
			_unit addItem "NVG_EPOCH";
			_unit assignItem "NVG_EPOCH";
		};
		
		//Gotta get paid yo!
		_kryptoAmount = floor (random 300) +1;
		_unit setVariable ["krypto", _kryptoAmount];
		
		_pAmmo = [] + getArray (configFile >> "cfgWeapons" >> _prim >> "magazines");
		{
			if (isClass(configFile >> "CfgPricing" >> _x)) exitWith {
				_unit addMagazine _x;
				_unit addMagazine _x;
			};
		} forEach _pAmmo;
		
		_hAmmo = [] + getArray (configFile >> "cfgWeapons" >> _seco >> "magazines");
		{
			if (isClass(configFile >> "CfgPricing" >> _x)) exitWith {
				_unit addMagazine _x;
				_unit addMagazine _x;
			};
		} forEach _hAmmo;
		
		_unit addWeapon _prim;
		_unit selectWeapon _prim;
		_unit addWeapon _seco;

	};
};

SDROPHeadgearList = getArray( configFile >> "sdropCfg" >> "SDROP_HeadgearList");

SDROPUniformList = getArray( configFile >> "sdropCfg" >> "SDROP_UniformList");

SDROPVestList = getArray( configFile >> "sdropCfg" >> "SDROP_VestList");

SDROPRiflesList = getArray( configFile >> "sdropCfg" >> "SDROP_RiflesList");

SDROPPistolsList = getArray( configFile >> "sdropCfg" >> "SDROP_PistolsList");

// Set AI Skills
SDROPSetUnitSkills = {
	private ["_unit","_skillSetArray"];

	_unit = _this select 0;
	_skillSetArray = _this select 1;
	
	{
		_unit setSkill [(_x select 0),(_x select 1)];
		//diag_log text format ["[SDROP]: Skill: %1:%2", (_x select 0),(_x select 1)];
	} forEach _skillSetArray;
};

//SkillSets - endurance removed from Arma 3
skillsRookie = getArray( configFile >> "sdropCfg" >> "SDROP_skillsRookie");

skillsVeteran =  getArray( configFile >> "sdropCfg" >> "SDROP_skillsVeteran");

skillsElite = getArray( configFile >> "sdropCfg" >> "SDROP_skillsElite");

if (SDROP_Debug) then {
	diag_log text format ["[SDROP]: Functions loaded. Starting supply drop timer."];
};


true
