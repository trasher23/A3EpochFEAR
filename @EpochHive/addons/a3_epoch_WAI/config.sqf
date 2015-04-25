if(isServer) then {

	/* GENERAL CONFIG */

		debug_mode					= false;		// enable debug
		blacklist					= [
			/*
			[[0,16000,0],[1000,-0,0]],		   	// Left
			[[0,16000,0],[16000.0,14580.3,0]], 	// Top
			
			// Altis
			[[13000,15000,0],[14000,14000,0]], 	// Middle spawn
			[[05900,17100,0],[06400,16600,0]], 	// West spawn
			[[18200,14500,0],[18800,14100,0]], 	// East spawn
			[[22561,19336,0],[24551,16947,0]], 	// salt lake
			[[10545,11025,0],[11140,10423,0]]	// Drimea
			*/
			
			//Cherno
			// Need data
			//Bornholm
			// Need data
		];
	/* END GENERAL CONFIG */

	/* AI CONFIG */

		ai_clear_body 				= false;		// instantly clear bodies
		ai_clean_dead 				= true;			// clear bodies after certain amount of time
		ai_cleanup_time 			= 3600;			// time to clear bodies in seconds
		ai_clean_roadkill			= false; 		// clean bodies that are roadkills
		ai_roadkill_damageweapon	= 90;			// percentage of chance a roadkill will destroy weapon AI is carrying

		ai_bandit_combatmode		= "RED";		// combatmode of bandit AI
		ai_bandit_behaviour			= "COMBAT";		// behaviour of bandit AI

		ai_share_info				= true;			// AI share info on player position
		ai_share_distance			= 300;			// distance from killed AI for AI to share your rough position

		ai_crypto_gain				= true;			// gain crypto for killing AI
		ai_crypto_gain_drop			= 50;			// chance of drop in %
		ai_add_krypto				= 100;			// amount of crypto gained for killing a bandit AI
		ai_special_krypto			= 1000;			// amount of crypto gained for killing a special AI
		ai_crypto_bomb				= 5000;			// amount of krypto gaind for defusing the nuke/bomb
		

		// https://community.bistudio.com/wiki/AI_Sub-skills#general
		ai_skill_extreme			= [["aimingAccuracy",1.00],["aimingShake",1.00],["aimingSpeed",1.00],["spotDistance",1.00],["spotTime",1.00],["courage",1.00],["reloadSpeed",1.00],["commanding",1.00],["general",1.00]]; 	// Extreme
		ai_skill_hard				= [["aimingAccuracy",0.70],["aimingShake",0.70],["aimingSpeed",0.70],["spotDistance",0.70],["spotTime",0.80],["courage",1.00],["reloadSpeed",1.00],["commanding",1.00],["general",0.70]]; 	// Hard
		ai_skill_medium				= [["aimingAccuracy",0.60],["aimingShake",0.60],["aimingSpeed",0.60],["spotDistance",0.60],["spotTime",0.60],["courage",1.00],["reloadSpeed",1.00],["commanding",1.00],["general",0.60]];	// Medium
		ai_skill_easy				= [["aimingAccuracy",0.30],["aimingShake",0.50],["aimingSpeed",0.50],["spotDistance",0.50],["spotTime",0.50],["courage",1.00],["reloadSpeed",1.00],["commanding",1.00],["general",0.50]];	// Easy
		ai_skill_random				= [ai_skill_extreme,ai_skill_hard,ai_skill_hard,ai_skill_hard,ai_skill_hard,ai_skill_medium,ai_skill_medium,ai_skill_medium,ai_skill_medium,ai_skill_easy];

		ai_static_useweapon			= true;	// Allows AI on static guns to have a loadout 	
		ai_static_weapons			= ["O_HMG_01_F","O_HMG_01_A_F","O_HMG_01_high_F"];	// static guns 

		ai_static_skills			= false;	// Allows you to set custom array for AI on static weapons. (true: On false: Off) 
		ai_static_array				= [["aimingAccuracy",0.20],["aimingShake",0.70],["aimingSpeed",0.75],["endurance",1.00],["spotDistance",0.70],["spotTime",0.50],["courage",1.00],["reloadSpeed",1.00],["commanding",1.00],["general",1.00]];
		
		ai_assault_wep				= ["arifle_Katiba_GL_F","arifle_MX_GL_F","arifle_MX_GL_Black_F","arifle_Mk20_GL_F","arifle_Mk20_GL_plain_F","arifle_TRG21_GL_F","AKM_EPOCH","arifle_Katiba_C_F","arifle_Katiba_F","arifle_MXC_F","arifle_MX_F","arifle_MX_Black_F","arifle_MXC_Black_F","arifle_TRG21_F","arifle_TRG20_F","arifle_Mk20_plain_F","arifle_Mk20C_plain_F","arifle_Mk20C_F","arifle_Mk20_F","m16_EPOCH","m16Red_EPOCH","m4a3_EPOCH"];	// Assault
		ai_assault_scope			= ["optic_Arco","optic_Hamr","optic_Aco","optic_ACO_grn","optic_Aco_smg","optic_ACO_grn_smg","optic_Holosight","optic_Holosight_smg","optic_MRCO","optic_NVS"];
		ai_assault_gear				= ["ItemGPS"];
		ai_assault_skin				= ['U_O_CombatUniform_ocamo','U_OG_Guerilla1_1','U_OG_Guerilla2_1','U_OG_Guerilla2_3','U_OG_Guerilla3_1','U_OG_Guerilla3_2','U_OG_leader','U_O_PilotCoveralls'];
		ai_assault_backpack			= ["B_AssaultPack_cbr","B_AssaultPack_dgtl","B_AssaultPack_khk","B_AssaultPack_mcamo","B_AssaultPack_ocamo","B_AssaultPack_rgr","B_AssaultPack_sgg"];
		ai_assault_vest				= [""];
		ai_assault					= [ai_assault_wep,ai_assault_scope,ai_assault_gear,ai_assault_skin,ai_assault_backpack,ai_assault_vest];
		
		ai_machine_wep				= ["LMG_Zafir_F","LMG_Mk200_F","arifle_MX_SW_F","arifle_MX_SW_Black_F","m249_EPOCH","m249Tan_EPOCH"];	// Light machine guns
		ai_machine_scope			= ["optic_Arco","optic_Hamr","optic_Aco","optic_ACO_grn","optic_Aco_smg","optic_ACO_grn_smg","optic_Holosight","optic_Holosight_smg","optic_MRCO","optic_NVS"];
		ai_machine_gear				= ["ItemWatch"];
		ai_machine_skin				= ['U_O_CombatUniform_ocamo','U_OG_Guerilla1_1','U_OG_Guerilla2_1','U_OG_Guerilla2_3','U_OG_Guerilla3_1','U_OG_Guerilla3_2','U_OG_leader','U_O_PilotCoveralls'];
		ai_machine_backback			= ["B_TacticalPack_blk","B_TacticalPack_mcamo","B_TacticalPack_ocamo","B_TacticalPack_oli","B_TacticalPack_rgr"];
		ai_machine_vest				= [""];
		ai_machine					= [ai_machine_wep,ai_machine_scope,ai_machine_gear,ai_machine_skin,ai_machine_backback,ai_machine_vest];
		
		ai_sniper_wep				= ["srifle_EBR_F","srifle_DMR_01_F","M14_EPOCH","M14Grn_EPOCH","srifle_GM6_F","m107Tan_EPOCH","m107_EPOCH","srifle_LRR_F","arifle_MXM_F","arifle_MXM_Black_F"];	// Sniper rifles
		ai_sniper_scope				= ["optic_SOS","optic_DMS","optic_LRPS"];
		ai_sniper_gear				= ["Rangefinder"];
		ai_sniper_skin				= ["U_O_GhillieSuit"];
		ai_sniper_backpack			= ["B_Kitbag_cbr","B_Kitbag_mcamo","B_Kitbag_rgr","B_Kitbag_sgg"];
		ai_sniper_vest				= [""];
		ai_sniper					= [ai_sniper_wep,ai_sniper_scope,ai_sniper_gear,ai_sniper_skin,ai_sniper_backpack,ai_sniper_vest];

		ai_random					= [ai_assault,ai_assault,ai_assault,ai_sniper,ai_machine];	// random weapon 60% chance assault rifle,20% light machine gun,20% sniper rifle
		
		// Weapons accessories
		ai_wep_item					= ["acc_pointer_IR","acc_flashlight"];
		ai_wep_Suppressor			= ["muzzle_snds_H","muzzle_snds_L","muzzle_snds_M","muzzle_snds_B","muzzle_snds_H_MG","muzzle_snds_acp"];
		
		
		ai_pistols 					= ["hgun_PDW2000_F","hgun_ACPC2_F","hgun_Rook40_F","hgun_P07_F","hgun_Pistol_heavy_01_F","hgun_Pistol_heavy_02_F","ruger_pistol_epoch","1911_pistol_epoch","hgun_Pistol_Signal_F"];
		ai_wep_water 				= ["speargun_epoch","arifle_SDAR_F"];
		
		// AT/AA launchers
		ai_wep_launchers_AT			= ["launch_RPG32_F"];
		ai_wep_launchers_AA			= ["launch_O_Titan_F"];
		
	/* END AI CONFIG */

	/* WAI MISSIONS CONFIG */
		wai_mission_system			= true;				// use built in mission system

		wai_mission_markers			= ["DZMSMajMarker","DZMSMinMarker","DZMSBMajMarker","DZMSBMinMarker"];
		wai_avoid_missions			= 300;				// avoid spawning missions this close to other missions, these are defined in wai_mission_markers
		//wai_avoid_traders				= 0;			// avoid spawning missions this close to traders
		//wai_avoid_town				= 0;			// avoid spawning missions this close to towns, *** doesn't function with infiSTAR enabled ***
		//wai_avoid_road				= 0;			// avoid spawning missions this close to roads
		//wai_avoid_water				= 0;			// avoid spawning missions this close to water
		
		wai_blacklist_players_range = 750;				// distance to players
		wai_blacklist_range			= 600;				// Distiance to base, traders, spawnpoint

		wai_mission_timer			= [300,900];		// time between missions 5-15 minutes
		wai_mission_timeout			= [900,1800]; 		// time each missions takes to despawn if inactive 15-30 minutes
		wai_timeout_distance		= 1000;				// if a player is this close to a mission then it won't time-out
		wai_timeout_bomb			= 1800;				// How long bomb missions is, when it times out it gos BOOM
		
		wai_clean_mission			= true;				// clean all mission buildings after a certain period
		wai_clean_mission_time		= 900;				// time after a mission is complete to clean mission buildings

		//wai_mission_fuel			= [5,60];			// fuel inside mission spawned vehicles [min%,max%]
		//wai_vehicle_damage		= [20,70];			// damages to spawn vehicles with [min%,max%]
		//wai_keep_vehicles			= true;				// save vehicles to database and keep them after restart
		//wai_lock_vehicles			= true;				// lock mission vehicles and add keys to random AI bodies (be careful with ai_clean_dead if this is true

		wai_crates_smoke			= true;				// pop smoke on crate when mission is finished during daytime
		wai_crates_flares			= true;				// pop flare on crate when mission is finished during nighttime
		
		wai_players_online			= 0; 				// number of players online before mission starts
		wai_server_fps				= 10; 				// missions only starts if server FPS is over wai_server_fps
		
		// Don't use might be buged 
		wai_kill_percent			= 0;				// percentage of AI players that must be killed at "crate" missions to be able to trigger completion

		wai_high_value				= true;				// enable the possibility of finding a high value item (defined below crate_items_high_value) inside a crate
		wai_high_value_chance		= 10;				// chance in percent you find above mentioned item

		wai_enable_minefield		= true;				// enable minefields to better defend missions
		wai_use_launchers			= true;				// add a rocket launcher to each spawned AI group
		wai_remove_launcher			= true;				// remove rocket launcher from AI on death

		// Missions
		wai_announce				= "radio";			// Setting this to true will announce the missions to those that hold a radio only "radio", "global", "hint", "text"
		wai_bandit_limit			= 1;				// define how many bandit missions can run at once
		
		//Syntax ["MISSION NAME","CHANGE"] Change must equal 100 when put together 
		wai_bandit_missions			= [
										["nuke",2],
										["sniper_team",23],
										["rebel_base",25],
										["medi_camp",20],
										["ikea_convoy",30],
										
										
										["patrol",0],
										["armed_vehicle",0],
										["black_hawk_crash",0],
										["captured_mv22",0],
										["broken_down_ural",0],
										["presidents_mansion",0],
										["weapon_cache",0],
										
										["debug",0]
									];
		
		// Vehicle arrays
		armed_vehicle 				= []; 
		armed_chopper 				= ["B_Heli_Transport_01_camo_EPOCH"];
		refuel_trucks				= [];
		
		civil_chopper 				= ["B_Heli_Light_01_EPOCH","B_Heli_Transport_01_EPOCH","B_Heli_Transport_01_camo_EPOCH","O_Heli_Light_02_unarmed_EPOCH","I_Heli_Transport_02_EPOCH","I_Heli_light_03_unarmed_EPOCH"];
		military_unarmed 			= ["B_MRAP_01_EPOCH","B_Truck_01_transport_EPOCH","O_Truck_02_covered_EPOCH","O_Truck_02_transport_EPOCH","O_Truck_03_covered_EPOCH","O_Truck_02_box_EPOCH"];
		cargo_trucks 				= ["C_Van_01_box_EPOCH","C_Van_01_transport_EPOCH"];

		civil_vehicles 				= ["C_Hatchback_01_EPOCH","C_Hatchback_02_EPOCH","C_Offroad_01_EPOCH","C_Quadbike_01_EPOCH","C_SUV_01_EPOCH"];
		boots						= ["B_SDV_01_EPOCH"];
		
		wreck_water					= ["Land_UWreck_FishingBoat_F","Land_UWreck_Heli_Attack_02_F","Land_UWreck_MV22_F","Land_Wreck_Traw2_F","Land_Wreck_Traw_F"];
		wreck						= [];

		// Dynamic box array
		crates_large				= ["Box_NATO_AmmoVeh_F"]; 
		crates_medium				= ["C_supplyCrate_F"];  
		crates_small				= ["Box_NATO_WpsSpecial_F"];
		
		// weapons
		crate_weapons_buildables    = ["MultiGun"];
		crate_tools					= ["Hatchet","Binocular","Rangefinder","ItemCompass","ItemGPS","NVG_EPOCH","EpochRadio0"];
		crate_tools_sniper			= ["ItemCompass","ItemWatch","Binocular","Rangefinder","NVG_EPOCH","ItemGPS","EpochRadio0"];
		
		//item
		crate_tools_buildable		= ["ItemMixOil","jerrycan_Epoch","EpochRadio0"];
		
		crate_items					= ["ItemSodaRbull","ItemSodaOrangeSherbet","ItemSodaPurple","ItemSodaOrangeSherbet","ItemSodaMocha","ItemSodaBurst","FoodBioMeat","FoodSnooter","FoodWalkNSons","ItemMixOil","ItemScraps","ItemCorrugated","ItemCorrugatedLg","CSGAS","EnergyPack","EnergyPackLg","WhiskeyNoodle","CircuitParts","VehicleRepair","VehicleRepairLg","Pelt_EPOCH","JackKit","PaintCanBlk","PaintCanBlu","PaintCanBrn","PaintCanGrn","PaintCanOra","PaintCanPur","PaintCanRed","PaintCanTeal","PaintCanYel","Towelette","KitCinderWall","KitPlotPole","MortarBucket","KitFoundation","KitShelf","KitTiPi","KitFirePlace","KitWoodRamp","KitWoodStairs","KitWoodFloor","KitStudWall","ItemMixOil","emptyjar_epoch","jerrycan_epoch"];
		crate_items_high_value		= ["Heal_EPOCH","Repair_EPOCH","ItemLockbox"];
		
		crate_items_food			= ["WhiskeyNoodle","honey_epoch","sardines_epoch","meatballs_epoch","scam_epoch","sweetcorn_epoch","ItemSodaRbull","ItemSodaOrangeSherbet","ItemSodaPurple","ItemSodaOrangeSherbet","ItemSodaMocha","ItemSodaBurst","FoodBioMeat","FoodSnooter","FoodWalkNSons"];
		crate_items_buildables		= ["ItemMixOil",["ItemScraps",10],["ItemCorrugated",6],["ItemCorrugatedLg",6],"CSGAS","MeleeSledge","sledge_swing",'hatchet',["EnergyPack",3],"EnergyPackLg",["CircuitParts",3],"Pelt_EPOCH","JackKit","PaintCanBlk","PaintCanBlu","PaintCanBrn","PaintCanGrn","PaintCanOra","PaintCanPur","PaintCanRed","PaintCanTeal","PaintCanYel","KitCinderWall","KitPlotPole","MortarBucket","KitFoundation","KitShelf","KitTiPi","KitFirePlace","KitWoodRamp","KitWoodStairs","KitWoodFloor","KitStudWall"];
		
		crate_items_vehicle_repair	= ["VehicleRepair","VehicleRepairLg"];
		crate_items_medical			= ["Defib_EPOCH","Heal_EPOCH",["FAK",2]];
		crate_items_sniper			= ["U_O_GhillieSuit",["FAK",2]];
		crate_items_president		= ["ItemDocument","ItemGoldBar10oz"];

		crate_backpacks_all			= ["B_AssaultPack_cbr","B_AssaultPack_dgtl","B_AssaultPack_khk","B_AssaultPack_mcamo","B_AssaultPack_ocamo","B_AssaultPack_rgr","B_AssaultPack_sgg"];
		crate_backpacks_large		= ["B_Carryall_cbr","B_Carryall_khk","B_Carryall_mcamo"];

		crate_random				= [crate_items,crate_items_food,crate_items_buildables,crate_items_vehicle_repair,crate_items_medical];

	/* END WAI MISSIONS CONFIG */
	
		// DEBUG SETTINGS
		if(debug_mode) then {
			wai_remove_launcher		= false;	
			wai_mission_timer		= [60,60];
			wai_mission_timeout		= [300,300];
			wai_bandit_missions		= [["debug",100]];			
			//wai_bandit_missions		= [["nuke",100]];			
			//wai_bandit_missions		= [["treasure_hunt_water",100]];			
		};

	/* STATIC MISSIONS CONFIG */

		static_missions				= false;		// use static mission file
		custom_per_world			= false;		// use a custom mission file per world

	WAIconfigloaded = true;

};
