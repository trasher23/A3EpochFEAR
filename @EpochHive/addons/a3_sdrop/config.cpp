class CfgPatches {
	class A3_sdrop {
		units[] = {};
		weapons[] = {};
		requiredVersion = 0.1;
		requiredAddons[] = {};
	};
};

class CfgFunctions {
	class A3_sdrop {
		class sdrop_main {	
			file = "\x\addons\a3_sdrop\init";
			class init {preInit = 1;};
			class postinit {postInit = 1;};
		};
	};
};



class sdropCfg {
	
	SDROP_Debug = 1;					//Set to 0 if you don't want logs added to your RPT - used mostly for testing/diagnosis of issues
	SDROP_CreateParatrooperAI = 1;		//Set to 0 if you do NOT want AI to drop with the crate
	SDROP_MissionTimer = 900;			//mission timer - time taken for new helicopter to arrive / conditional (default: 900, which is 15 minutes real-time)
	SDROP_CrateTimeout = 1800;			//This is the NON-LOOTED crate cleanup timer - (default is 1800 which is half-hour real-time)
	SDROP_SupplyDropFailChance = 0;		//Change probability of supply drop - enter chance as whole number from 1-100 (default 0)
	SDROP_HelicopterCrashChance = 0;	//Change probability of helicopter crashing - enter chance as whole number from 1-100 (default 0)
	
	// Crate Blacklist - These are items that should NOT be in random crate - should eliminate most BE filter issues (may need more testing)
	SDROP_Blacklist[] = {
		"DemoCharge_Remote_Mag",
		"SatchelCharge_Remote_Mag",
		"ATMine_Range_Mag",
		"ClaymoreDirectionalMine_Remote_Mag",
		"APERSMine_Range_Mag",
		"APERSBoundingMine_Range_Mag",
		"SLAMDirectionalMine_Wire_Mag",
		"APERSTripMine_Wire_Mag",
		"NVG_EPOCH",
		"NVGoggles_OPFOR",
		"NVGoggles_INDEP",
		"FirstAidKit",
		"Medikit",
		"ToolKit",
		"optic_DMS"
	};
	
	SDROP_HeadgearList[] = {	
		"H_39_EPOCH","H_40_EPOCH","H_41_EPOCH","H_42_EPOCH","H_43_EPOCH","H_44_EPOCH","H_45_EPOCH","H_46_EPOCH","H_47_EPOCH","H_48_EPOCH",
		"H_49_EPOCH","H_50_EPOCH","H_51_EPOCH","H_52_EPOCH","H_53_EPOCH","H_54_EPOCH","H_55_EPOCH","H_56_EPOCH","H_57_EPOCH","H_58_EPOCH",
		"H_59_EPOCH","H_60_EPOCH","H_61_EPOCH","H_62_EPOCH","H_63_EPOCH","H_64_EPOCH","H_65_EPOCH","H_66_EPOCH","H_67_EPOCH","H_68_EPOCH",
		"H_69_EPOCH","H_70_EPOCH","H_74_EPOCH","H_75_EPOCH","H_76_EPOCH","H_77_EPOCH","H_86_EPOCH","H_87_EPOCH","H_88_EPOCH","H_89_EPOCH",
		"H_90_EPOCH","H_91_EPOCH","H_92_EPOCH","H_Beret_blk","H_Beret_red","H_Beret_grn"
	};
	
	SDROP_UniformList[] = {
		"U_O_CombatUniform_ocamo","U_O_PilotCoveralls","U_OG_Guerilla1_1","U_OG_Guerilla2_1","U_OG_Guerilla2_3","U_IG_leader",
		"U_OG_Guerilla3_1","U_OG_Guerilla3_2","U_OG_leader","U_C_WorkerCoveralls","U_I_CombatUniform_tshirt","U_I_OfficerUniform",
		"U_CamoRed_uniform","U_CamoBrn_uniform","U_CamoBlue_uniform","U_Camo_uniform","U_O_CombatUniform_oucamo","U_I_CombatUniform_shortsleeve"
	};
	
	SDROP_VestList[] = {
		"V_1_EPOCH","V_2_EPOCH","V_3_EPOCH","V_4_EPOCH","V_5_EPOCH","V_6_EPOCH","V_7_EPOCH","V_8_EPOCH","V_9_EPOCH","V_10_EPOCH",
		"V_11_EPOCH","V_12_EPOCH","V_13_EPOCH","V_14_EPOCH","V_15_EPOCH","V_16_EPOCH","V_17_EPOCH","V_18_EPOCH","V_19_EPOCH","V_20_EPOCH",
		"V_21_EPOCH","V_22_EPOCH","V_23_EPOCH","V_24_EPOCH","V_25_EPOCH","V_26_EPOCH","V_27_EPOCH","V_28_EPOCH","V_29_EPOCH","V_30_EPOCH",
		"V_31_EPOCH","V_32_EPOCH","V_33_EPOCH","V_34_EPOCH","V_35_EPOCH","V_36_EPOCH","V_37_EPOCH","V_38_EPOCH","V_39_EPOCH","V_40_EPOCH"
	};

	SDROP_RiflesList[] = {
		"srifle_EBR_F","srifle_DMR_01_F","arifle_Katiba_F","arifle_Katiba_C_F","arifle_Katiba_GL_F","arifle_MXC_F","arifle_MX_F",
		"arifle_MX_GL_F","arifle_MXM_F","arifle_SDAR_F","arifle_TRG21_F","arifle_TRG20_F","arifle_TRG21_GL_F","arifle_Mk20_F",
		"arifle_Mk20C_F","arifle_Mk20_GL_F","arifle_Mk20_plain_F","arifle_Mk20C_plain_F","arifle_Mk20_GL_plain_F","SMG_01_F",
		"SMG_02_F","hgun_PDW2000_F","arifle_MXM_Black_F","arifle_MX_GL_Black_F","arifle_MX_Black_F","arifle_MXC_Black_F","Rollins_F",
		"LMG_Mk200_F","arifle_MX_SW_F","LMG_Zafir_F","arifle_MX_SW_Black_F","m249_EPOCH","m249Tan_EPOCH",
		"m16_EPOCH","m16Red_EPOCH","M14_EPOCH","M14Grn_EPOCH","m4a3_EPOCH","AKM_EPOCH"
	};

	SDROP_PistolsList[] = {
		"hgun_ACPC2_F","hgun_Rook40_F","hgun_P07_F","hgun_Pistol_heavy_01_F","hgun_Pistol_heavy_02_F","ruger_pistol_epoch",
		"1911_pistol_epoch","hgun_Pistol_Signal_F"
	};
	
	//SkillSets - endurance removed from Arma 3
	SDROP_skillsRookie[] = {
		{"aimingAccuracy",0.4},
		{"aimingShake",0.3},
		{"aimingSpeed",0.3},
		{"spotDistance",0.3},
		{"spotTime",0.3},
		{"courage",0.4},
		{"reloadSpeed",0.6},
		{"commanding",0.6},
		{"general",1.0}
	};
	
	SDROP_skillsVeteran[] = {
		{"aimingAccuracy",0.6},
		{"aimingShake",0.6},
		{"aimingSpeed",0.6},
		{"spotDistance",0.6},
		{"spotTime",0.6},
		{"courage",0.6},
		{"reloadSpeed",0.7},
		{"commanding",0.8},
		{"general",1.0}
	};

	SDROP_skillsElite[] = {
		{"aimingAccuracy",0.8},
		{"aimingShake",0.75},
		{"aimingSpeed",0.7},
		{"spotDistance",0.8},
		{"spotTime",0.8},
		{"courage",1.0},
		{"reloadSpeed",0.8},
		{"commanding",1.0},
		{"general",1.0}
	};
	
	class Default {magazines[]={{"B_FieldPack_ocamo",2}};items[]={{"optic_Arco",1}};backpacks[]={{"20Rnd_762x51_Mag",4}};weapons[]={{"srifle_DMR_01_F",1}};spawnPosArray[]={{0,0,200}};findSafePos[]={{500,10000,30,0,30,0}}; dropPosArray[]={{0,0,200}};};


	//fill the crate with WEAPONS and AMMO
	class SDROP_LoadLootWeapons:Default {
		
		weapons[] = {
			{"srifle_DMR_01_F",1},
			{"arifle_Mk20_F",1},
			{"arifle_MX_Black_F",1},
			{"M249_EPOCH",1},
			{"srifle_LRR_SOS_F",1}
		};

		magazines[] = {
			{"20Rnd_762x51_Mag",4},
			{"30Rnd_556x45_Stanag",4},
			{"30Rnd_65x39_caseless_mag_Tracer",4},
			{"200Rnd_556x45_M249",2},
			{"7Rnd_408_Mag",3},
			{"HandGrenade",2},
			{"MiniGrenade",2}
		};		
		
		items[] = {
			{"optic_Arco",1},
			{"optic_SOS",1},
			{"optic_Aco",1},
			{"optic_LRPS",1},
			{"Muzzle_snds_H",1},
			{"Muzzle_snds_M",1},
			{"Muzzle_snds_B",1},
			{"ItemCompass",4},
			{"ItemGPS",4},
			{"EpochRadio0",4},
			{"ItemWatch",4},
			{"V_7_EPOCH",1},
			{"V_10_EPOCH",1},
			{"V_13_EPOCH",1},
			{"V_14_EPOCH",1},
			{"V_15_EPOCH",1},
			{"V_37_EPOCH",1},
			{"V_38_EPOCH",1}
		};
		
		backpacks[] = {
			{"B_FieldPack_ocamo",2}
		};
		
	};
	
	//fill the crate with SUPPLIES
	class SDROP_LoadLootSupplies:Default {
		
		items[] = {
			{"Heal_EPOCH",2},
			{"FAK",6},
			{"Repair_EPOCH",1}
		};
		magazines[] = {
		  {"CinderBlocks",8},
		  {"jerrycan_epoch",3},
		  {"CircuitParts",4},
		  {"ItemCorrugatedLg",1},
		  {"ItemCorrugated",4},
		  {"ItemMixOil",2},
		  {"MortarBucket",6},
		  {"PartPlankPack",4},
		  {"ItemLockbox",1},
		  {"VehicleRepair",2},
		  {"Towelette",4},
		  {"HeatPack",2},
		  {"ColdPack",2},
		  {"Pelt_EPOCH",2},
		  {"EnergyPack",4},
		  {"EnergyPackLg",1}
		};
	
		backpacks[] = {
			{"B_Carryall_oucamo",1},
			{"B_FieldPack_cbr",1},
			{"B_TacticalPack_ocamo",1}
		};
		
		weapons[] = {
			{"MultiGun",2}
		};
		
	};
	
	//fill the crate with FOOD & CLOTHING
	class SDROP_LoadLootFood:Default {
		
		magazines[] = {
			{"ItemSodaRbull",2},
			{"ItemSodaOrangeSherbet",2},
			{"ItemSodaOrangeSherbet",2},
			{"ItemSodaPurple",2},
			{"ItemSodaMocha",2},
			{"ItemSodaBurst",2},
			{"FoodMeeps",2},
			{"FoodSnooter",2},
			{"FoodWalkNSons",2},
			{"water_epoch",4},
			{"ItemCoolerE",4},
			{"SweetCorn_EPOCH",4},
			{"WhiskeyNoodle",6},
			{"SnakeMeat_EPOCH",1},
			{"CookedRabbit_EPOCH",2},
			{"CookedChicken_EPOCH",2},
			{"CookedGoat_EPOCH",2},
			{"CookedSheep_EPOCH",2}
		};
	
		items[] = {
			{"U_O_CombatUniform_ocamo",1},
			{"U_O_GhillieSuit",1},
			{"U_O_Wetsuit",1},
			{"U_OG_Guerilla1_1",1},
			{"U_OG_Guerilla2_1",1},
			{"U_OG_Guerilla3_1",1},
			{"U_OrestesBody",1},
			{"U_Wetsuit_uniform",1},
			{"U_Ghillie1_uniform",1}
		};
		
		backpacks[] = {
			{"B_Carryall_ocamo",2} 
		};		

	};
	

	class Chernarus:Default {
		//random supply helicopter spawn
		spawnPosArray[] = {
			{5879.0845,11548.684,200},
			{7896.0542,9725.6523,200},
			{3706.9634,8639.5918,200},
			{11037.871,7359.5928,200},
			{6480.2969,6254.1377,200},
			{3454.8428,3946.2578,200},
			{9486.3574,4353.5313,200},
			{11813.63,11432.32,200},
			{9951.8115,13352.32,200},
			{2853.6301,13177.773,200},
			{10106.963,6312.3193,200},
			{5549.3872,3442.0166,200},
			{2329.9932,11063.835,200},
			{11328.78,10035.956,200},
			{12434.235,4954.7427,200},
			{2019.6909,7165.6523,200},
			{6654.8428,13953.532,200}
		};
		
		//random drop positions
		dropPosArray[] = {
			{3457.042,10919.945},
			{11393.261,4881.1865},
			{3437.8723,4823.6763},
			{10588.132,10881.604},
			{7022.5879,7641.7622}
		};
		
		//https://community.bistudio.com/wiki/BIS_fnc_findSafePos
		findSafePos[] = {500,2000,30,0,10,0};
	};
	
	
	
	class Altis:Default {
		//random supply helicopter spawn
		spawnPosArray[] = {
			{15971.3,25950.5,200},
			{14727.5,3934.5,200},
			{26869.5,15454.5,200},
			{1306.16,14832.8,200}
		};
		
		// random drop positions
		dropPosArray[] = {
			{10904.167,8370.4814},
			{13597.261,18526.916},
			{24606.84,21063.703},
			{19795.055,9112.0254},
			{20318.309,15811.264},
			{7321.019,13793.316},
			{6686.8555,19731.402}
		};
		
		//https://community.bistudio.com/wiki/BIS_fnc_findSafePos
		findSafePos[] = {500,3000,30,0,30,0};
	};

	
	class Bornholm:Default {
		//random supply helicopter spawn
		spawnPosArray[] = {
			{9885.76,21958.6,200},
			{9979.83,238.216,200},
			{21319.8,8515.21,200},
			{291.794,8532.42,200}
		};
		
		//random drop positions
		dropPosArray[] = {
			{6858.606,6749.9946},
			{13503.25,4236.4399},
			{5346.7422,12928.046},
			{11983.059,10203.342}
		};
		
		//https://community.bistudio.com/wiki/BIS_fnc_findSafePos
		findSafePos[] = {500,3000,30,0,30,0};
	};
	
	
};