/////////////////////////////////////
//      Function file for UKGZ	   //
//        Created by: Richie       //
//  Modded by:  Vampire & xBowBii  //
/////////////////////////////////////

private ["_crashNum","_lootNum","_loot","_spawnCrashes"];
_crashNum = 5; // Number of Crashes
_lootNum = 5; // Number of Loot Piles

_loot = [
	// Weapons
	"m107_EPOCH","MultiGun","Srifle_GM6_F","Srifle_LRR_F","M14_EPOCH","srifle_EBR_F","m249_EPOCH","LMG_Mk200_F","LMG_Zafir_F",
	"m16_EPOCH","akm_EPOCH","m4a3_EPOCH","Rollins_F","sr25_epoch","l85a2_epoch","arifle_MX_GL_F",
	"srifle_DMR_02_ARCO_F","srifle_DMR_02_sniper_F","srifle_DMR_03_spotter_F","srifle_DMR_03_tan_AMS_LP_F","srifle_DMR_03_tan_F","srifle_DMR_03_woodland_F",
	"srifle_DMR_04_ARCO_F","srifle_DMR_04_DMS_F","srifle_DMR_04_F","srifle_DMR_04_MRCO_F","srifle_DMR_05_blk_F","srifle_DMR_05_DMS_F","srifle_DMR_05_DMS_snds_F","srifle_DMR_05_hex_F",
	"srifle_DMR_06_camo_F","srifle_DMR_06_camo_khs_F","srifle_DMR_06_olive_F","MMG_01_hex_ACRO_LP_F","MMG_01_hex_F","MMG_01_tan_F","MMG_02_camo_F","MMG_02_sand_F","MMG_02_sand_RCO_LP_F",
	
	//  Attachments
	"optic_Nightstalker","optic_LRPS","optic_DMS","optic_Aco_smg","optic_ACO_grn_smg","optic_Holosight_smg",
	"optic_Aco","optic_Holosight","acc_pointer_IR","Rangefinder",
	
	// Items
	"EnergyPack","Repair_EPOCH","Defib_EPOCH","Heal_EPOCH","FAK","ItemWatch","CircuitParts","ItemScraps","jerrycan_epoch","VehicleRepair","CircuitParts",
	
	// Food
	"meatballs_epoch","ItemSodaRbull","sardines_epoch","scam_epoch","sweetcorn_epoch","Towelette"
];

_spawnCrashes = {
	private["_posOfCrash","_helicopters","_element","_vehHeli","_burnHelicopter","_crate0","_crate1","_item","_kindOf","_cAmmo","_cutter0","_cutter1"];
	
	for "_j" from 1 to _crashNum do {
		
		_posOfCrash = [MapCentre,0,MapRadius,10,0,20,0] call BIS_fnc_findSafePos; // find a random loc
		
		_helicopters = [
			"Land_Wreck_Heli_Attack_01_F",
			"Land_Wreck_Plane_Transport_01_F",
			"C130J_wreck_EP1",
			"Land_Wreck_Heli_Attack_02_F",
			"Mi8Wreck"
		];
		
		_element = _helicopters call BIS_fnc_SelectRandom;
		_vehHeli = _element createVehicle [0,0,0];
		_burnHelicopter = "test_EmptyObjectForFireBig" createVehicle (position _vehHeli);
		_burnHelicopter attachto [_vehHeli, [0,0,-1]];  
		_vehHeli setposATL [(_posOfCrash) select 0,(_posOfCrash) select 1,0];
		_vehHeli setVariable ["LAST_CHECK", (diag_tickTime + 14400)];
				
		for "_i" from 1 to _lootNum do {
			_crate0 = createVehicle ["weaponHolderSimulated", _vehHeli modelToWorld [(random 10) - 3, (random 10) - 4, 0], [], 0, "CAN_COLLIDE"];
			_crate1 = createVehicle ["weaponHolderSimulated", _vehHeli modelToWorld [(random 10) - 3, (random 10) - 4, 0], [], 0, "CAN_COLLIDE"];
			
			_item = _loot call BIS_fnc_selectRandom;
			switch (true) do
			{
				
				case (isClass (configFile >> "CfgWeapons" >> _item)): {
					_kindOf = [(configFile >> "CfgWeapons" >> _item),true] call BIS_fnc_returnParents;
					if ("ItemCore" in _kindOf) then {
						// Min 1, Max 2
						_crate0 addItemCargoGlobal [_item,(floor(random(2)))+1];
						_crate1 addItemCargoGlobal [_item,(floor(random(2)))+1];
					} else {
						// One Weapon, Three Mags
						_crate0 addWeaponCargoGlobal [_item,1];
						_crate1 addWeaponCargoGlobal [_item,1];
						
						_cAmmo = [] + getArray (configFile >> "cfgWeapons" >> _item >> "magazines");
						{
							if (isClass(configFile >> "CfgPricing" >> _x)) exitWith {
								_crate0 addMagazineCargoGlobal [_x,3];
								_crate1 addMagazineCargoGlobal [_x,3];
							};
						} forEach _cAmmo;
					};
				};
				
				case (isClass (configFile >> "cfgMagazines" >> _item)): {
					// Min 1, Max 3
					_crate0 addMagazineCargoGlobal [_item,(floor(random(3)))+1];
					_crate1 addMagazineCargoGlobal [_item,(floor(random(3)))+1];
				};
				
				case ((getText(configFile >> "cfgVehicles" >> _item >>  "vehicleClass")) == "Backpacks"): {
					// One Bag
					_crate0 addBackpackCargoGlobal [_item,1];
					_crate1 addBackpackCargoGlobal [_item,1];
				};
				
			};
			
			_crate0 setPos [(getPos _crate0 select 0) +5, (getPos _crate0 select 1), 0];
			_crate1 setPos [(getPos _crate1 select 0) -10, (getPos _crate1 select 1), 0];
			_crate0 setVariable ["LAST_CHECK", (diag_tickTime + 14400)];
			_crate1 setVariable ["LAST_CHECK", (diag_tickTime + 14400)];
			_cutter0 = "Land_ClutterCutter_medium_F" createVehicle (getpos _crate0);
			_cutter1 = "Land_ClutterCutter_medium_F" createVehicle (getpos _crate1);
			_cutter0 setVariable ["LAST_CHECK", (diag_tickTime + 14400)];
			_cutter1 setVariable ["LAST_CHECK", (diag_tickTime + 14400)];	
		};
	};
};

diag_log "[FEAR] spawning air crash sites";
call _spawnCrashes;