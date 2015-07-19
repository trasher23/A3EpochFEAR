/*
   	Author: IT07

   	Description:
   	hpp config file for Vampire's Epoch Mission Framework (a.k.a. VEMF)

	Little back story:
	VEMF is originally made by Vampire but he kind of gave up on the project.
	Now, I (IT07) am carrying on with the project.
	Please keep in mind that a lot of code from this project is still old code and needs fixing and rewriting.
	Want to report an issue? Then either PM me on the Epochmod.com forums or reply to the VEMF forum post.
	Remember that this stuff is freeware even though a lot of time has been put into making this.
*/

class VEMFconfig
{
	/////// Configure VEMF here ///////
	// Global settings
	minPlayers = 1; // Missions will not start until player count reaches this number
	maxMissions = 4; // Max amount of missions that are allowed to run at the same time
	timeOut = 1; // Set to 0 if you do not want missions to timeout
 	timeOutTime = 25; // In minutes. Ignore if useTimeout = 0;
	minMissionTime = 3; // Minimum time before next mission can run
	maxMissionTime = 5; // Maximum time before next mission can run
	//missionList[] = {"DynamicLocationInvasion","heliCrash"}; // Speaks for itself, right?
	missionList[] = {"DynamicLocationInvasion","heliCrash"}; // Speaks for itself, right?
	addons[] = {}; // Not used for now
	noMissionPos[] = {}; // Needs functionality check
	locationBlackList[] = {"Sagonisi","Monisi","Fournos","Savri","Atsalis","Polemista","Cap Makrinos","Pyrgi","Makrynisi","Chelonisi"};  // Works

	// Helicrash settings
	redropDistanceMin = 5000; // Minimal distance in meters from last attacked location
	redropTimeMin = 20; // Minimal difference in minutes with last attacked location
	/* NOTE: The two settings above will make sure that players will not get spammed by heli crashes if player count is low */

	// DynamicLocationInvasion settings
	killPercentage = 100; // In percent. 100 means all AI in location need to be killed before loot crate drops
	groupCount = 2; // Amount of groups that spawn at location
	groupUnits = 4; // Amount of units in each group
	/* TIP: increase groupCount and decrease groupUnits to make it harder for players. Easier to get flanked from all sides */
	aiSkill = 0.23; // Equals to very skilled players
	useLaunchers = 1; // Set to 0 if you do NOT want the AI to have launchers
	remLaunchers = 0; // Set to 0 if you do NOT want the launchers (and ammo) to be removed from AI when they die
	playerCheck = 650; // If player(s) within this range of location, location gets skipped. Distance in m (meters)
	distanceCheck = 15000; // Check for locations around random player within this distance in m (meters)
	/* distanceCheck NOTE: set it to the minimal distance between ANY town on the map you are using. Otherwise location selection will fail */
	distanceTooClose = 2000; // Mission will not spawn closer to random player than this distance in meters
	distanceMaxPrefered = 6500; // Mission will prefer locations closer than this distance (in meters) to random player
	primaryWeaponLoot[] =
	{
		"srifle_DMR_01_F","srifle_DMR_01_ACO_F","srifle_DMR_01_MRCO_F","srifle_DMR_01_SOS_F","srifle_DMR_01_DMS_F",
		"srifle_DMR_01_DMS_snds_F","srifle_DMR_01_ARCO_F","srifle_EBR_F","srifle_EBR_ACO_F","srifle_EBR_MRCO_pointer_F",
		"srifle_EBR_ARCO_pointer_F","srifle_EBR_SOS_F","srifle_EBR_ARCO_pointer_snds_F","srifle_EBR_DMS_F","srifle_EBR_Hamr_pointer_F",
		"srifle_EBR_DMS_pointer_snds_F","srifle_GM6_F","srifle_GM6_SOS_F","srifle_GM6_LRPS_F","srifle_LRR_F","srifle_LRR_SOS_F","srifle_LRR_LRPS_F",
		"LMG_Mk200_F","LMG_Mk200_MRCO_F","LMG_Mk200_pointer_F","LMG_Zafir_F","LMG_Zafir_pointer_F","LMG_Zafir_ARCO_F","arifle_Katiba_F","arifle_Katiba_C_F",
		"arifle_Katiba_GL_F","arifle_Katiba_C_ACO_pointer_F","arifle_Katiba_C_ACO_F","arifle_Katiba_ACO_F","arifle_Katiba_pointer_F","arifle_Katiba_ACO_pointer_F",
		"arifle_Katiba_ARCO_F","arifle_Katiba_ARCO_pointer_F","arifle_Katiba_GL_ACO_F","arifle_Katiba_GL_ARCO_pointer_F","arifle_Katiba_GL_ACO_pointer_F",
		"arifle_Katiba_GL_ACO_pointer_snds_F","arifle_Katiba_C_ACO_pointer_snds_F","arifle_Katiba_ACO_pointer_snds_F","arifle_Katiba_ARCO_pointer_snds_F",
		"arifle_Mk20_F","arifle_Mk20_plain_F","arifle_Mk20C_F","arifle_Mk20C_plain_F","arifle_Mk20_GL_F","arifle_Mk20_GL_plain_F","arifle_Mk20C_ACO_F","arifle_Mk20C_ACO_pointer_F",
		"arifle_Mk20_pointer_F","arifle_Mk20_Holo_F","arifle_Mk20_ACO_F","arifle_Mk20_ACO_pointer_F","arifle_Mk20_MRCO_F","arifle_Mk20_MRCO_plain_F","arifle_Mk20_MRCO_pointer_F",
		"arifle_Mk20_GL_MRCO_pointer_F","arifle_Mk20_GL_ACO_F","arifle_MXC_F","arifle_MX_F","arifle_MX_GL_F","arifle_MX_SW_F","arifle_MXM_F","arifle_MX_pointer_F","arifle_MX_Holo_pointer_F",
		"arifle_MX_Hamr_pointer_F","arifle_MX_ACO_pointer_F","arifle_MX_ACO_F","arifle_MX_GL_ACO_F","arifle_MX_GL_ACO_pointer_F","arifle_MX_GL_Hamr_pointer_F",
		"arifle_MXC_Holo_F","arifle_MXC_Holo_pointer_F","arifle_MX_SW_pointer_F","arifle_MX_SW_Hamr_pointer_F","arifle_MXM_Hamr_pointer_F","arifle_MXC_ACO_F",
		"arifle_MXC_Holo_pointer_snds_F","arifle_MXC_SOS_point_snds_F","arifle_MXC_ACO_pointer_snds_F","arifle_MXC_ACO_pointer_F","arifle_MX_ACO_pointer_snds_F",
		"arifle_MX_RCO_pointer_snds_F","arifle_MX_GL_Holo_pointer_snds_F","arifle_MXM_SOS_pointer_F","arifle_MXM_RCO_pointer_snds_F","arifle_MXM_DMS_F","arifle_MXC_Black_F",
		"arifle_MX_Black_F","arifle_MX_GL_Black_F","arifle_MX_SW_Black_F","arifle_MXM_Black_F","arifle_MX_GL_Black_Hamr_pointer_F","arifle_MX_Black_Hamr_pointer_F",
		"arifle_MX_SW_Black_Hamr_pointer_F","arifle_SDAR_F","arifle_TRG21_F","arifle_TRG20_F","arifle_TRG21_GL_F","arifle_TRG20_Holo_F","arifle_TRG20_ACO_pointer_F",
		"arifle_TRG20_ACO_Flash_F","arifle_TRG20_ACO_F","arifle_TRG21_ACO_pointer_F","arifle_TRG21_ARCO_pointer_F","arifle_TRG21_MRCO_F","arifle_TRG21_GL_MRCO_F",
		"arifle_TRG21_GL_ACO_pointer_F","hgun_PDW2000_F","hgun_PDW2000_snds_F","hgun_PDW2000_Holo_F","hgun_PDW2000_Holo_snds_F","SMG_01_F","SMG_01_Holo_F",
		"SMG_01_Holo_pointer_snds_F","SMG_01_ACO_F","SMG_02_F","SMG_02_ACO_F","SMG_02_ARCO_pointg_F","srifle_GM6_camo_F","srifle_GM6_camo_SOS_F","srifle_GM6_camo_LRPS_F",
		"srifle_LRR_camo_F","srifle_LRR_camo_SOS_F","srifle_LRR_camo_LRPS_F","hgun_Pistol_Signal_F","srifle_DMR_01_DMS_BI_F","srifle_DMR_01_DMS_snds_BI_F",
		"srifle_EBR_MRCO_LP_BI_F","LMG_Mk200_LP_BI_F","LMG_Mk200_BI_F","arifle_MXM_DMS_LP_BI_snds_F","arifle_MXM_Hamr_LP_BI_F","srifle_DMR_02_F","srifle_DMR_02_camo_F",
		"srifle_DMR_02_sniper_F","srifle_DMR_02_ACO_F","srifle_DMR_02_MRCO_F","srifle_DMR_02_SOS_F","srifle_DMR_02_DMS_F","srifle_DMR_02_sniper_AMS_LP_S_F",
		"srifle_DMR_02_camo_AMS_LP_F","srifle_DMR_02_ARCO_F","srifle_DMR_03_F","srifle_DMR_03_khaki_F","srifle_DMR_03_tan_F","srifle_DMR_03_multicam_F","srifle_DMR_03_woodland_F",
		"srifle_DMR_03_ACO_F","srifle_DMR_03_MRCO_F","srifle_DMR_03_SOS_F","srifle_DMR_03_DMS_F","srifle_DMR_03_ACO_F","srifle_DMR_03_MRCO_F","srifle_DMR_03_SOS_F","srifle_DMR_03_DMS_F",
		"srifle_DMR_03_tan_AMS_LP_F","srifle_DMR_03_DMS_snds_F","srifle_DMR_03_ARCO_F","srifle_DMR_03_AMS_F","srifle_DMR_04_F","srifle_DMR_04_Tan_F","srifle_DMR_04_ACO_F","srifle_DMR_04_MRCO_F",
		"srifle_DMR_04_SOS_F","srifle_DMR_04_DMS_F","srifle_DMR_04_ARCO_F","srifle_DMR_04_NS_LP_F","srifle_DMR_05_blk_F","srifle_DMR_05_hex_F","srifle_DMR_05_tan_f","srifle_DMR_05_ACO_F",
		"srifle_DMR_05_MRCO_F","srifle_DMR_05_SOS_F","srifle_DMR_05_DMS_F","srifle_DMR_05_KHS_LP_F","srifle_DMR_05_DMS_snds_F","srifle_DMR_05_ARCO_F","srifle_DMR_06_camo_F",
		"srifle_DMR_06_olive_F","srifle_DMR_06_camo_khs_F","MMG_01_hex_F","MMG_01_tan_F","MMG_01_hex_ARCO_LP_F","MMG_02_camo_F","MMG_02_black_F","MMG_02_sand_F","MMG_02_sand_RCO_LP_F",
		"MMG_02_black_RCO_BI_F","m249_EPOCH","m249Tan_EPOCH","m16_EPOCH","m16Red_EPOCH","M14_EPOCH","M14Grn_EPOCH","m4a3_EPOCH","AKM_EPOCH"
	};
	secondaryWeaponLoot[] =
	{
		"hgun_ACPC2_F","hgun_ACPC2_snds_F","hgun_P07_F","hgun_P07_snds_F","hgun_Pistol_heavy_01_F","hgun_Pistol_heavy_01_snds_F",
		"hgun_Pistol_heavy_01_MRD_F","hgun_Pistol_heavy_02_F","hgun_Pistol_heavy_02_Yorris_F","hgun_Rook40_F","hgun_Rook40_snds_F",
		"ruger_pistol_epoch","1911_pistol_epoch","hgun_Pistol_Signal_F"
	};
	magazinesLoot[] =
	{
		"30Rnd_556x45_Stanag","30Rnd_556x45_Stanag_Tracer_Red","30Rnd_556x45_Stanag_Tracer_Green",
		"30Rnd_556x45_Stanag_Tracer_Yellow","30Rnd_65x39_caseless_mag","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_mag_Tracer",
		"30Rnd_65x39_caseless_green_mag_Tracer","20Rnd_762x51_Mag","7Rnd_408_Mag","5Rnd_127x108_Mag","100Rnd_65x39_caseless_mag",
		"100Rnd_65x39_caseless_mag_Tracer","200Rnd_65x39_cased_Box","200Rnd_65x39_cased_Box_Tracer","30Rnd_9x21_Mag","16Rnd_9x21_Mag",
		"30Rnd_45ACP_Mag_SMG_01","30Rnd_45ACP_Mag_SMG_01_Tracer_Green","9Rnd_45ACP_Mag","150Rnd_762x51_Box","150Rnd_762x51_Box_Tracer",
		"150Rnd_762x54_Box","150Rnd_762x54_Box_Tracer","11Rnd_45ACP_Mag","6Rnd_45ACP_Cylinder","10Rnd_762x51_Mag","10Rnd_762x54_Mag",
		"5Rnd_127x108_APDS_Mag","6Rnd_GreenSignal_F","6Rnd_RedSignal_F","10Rnd_338_Mag","130Rnd_338_Mag","10Rnd_127x54_Mag",
		"150Rnd_93x64_Mag","10Rnd_93x64_DMR_05_Mag"
	};
	attachmentsLoot[] =
	{
		"ItemGPS","ItemRadio","ItemMap","MineDetector","Binocular","Rangefinder","Medikit","ToolKit",
		"muzzle_snds_H","muzzle_snds_L","muzzle_snds_M","muzzle_snds_B","muzzle_snds_H_MG","muzzle_snds_H_SW",
		"optic_Arco","optic_Hamr","optic_Aco","optic_ACO_grn","optic_Aco_smg","optic_ACO_grn_smg","optic_Holosight",
		"optic_Holosight_smg","optic_SOS","acc_flashlight","acc_pointer_IR","optic_MRCO","muzzle_snds_acp","optic_NVS",
		"optic_DMS","optic_Yorris","optic_MRD","optic_LRPS","muzzle_snds_338_black","muzzle_snds_338_green",
		"muzzle_snds_338_sand","muzzle_snds_93mmg","muzzle_snds_93mmg_tan","optic_AMS","optic_AMS_khk",
		"optic_AMS_snd","optic_KHS_blk","optic_KHS_hex","optic_KHS_old","optic_KHS_tan","bipod_01_F_snd",
		"bipod_01_F_blk","bipod_01_F_mtp","bipod_02_F_blk","bipod_02_F_tan","bipod_02_F_hex","bipod_03_F_blk",
		"bipod_03_F_oli"
	};
	itemsLoot[] =
	{
		"FAK","ItemSodaRbull","ItemSodaOrangeSherbet","ItemSodaPurple","ItemSodaMocha","ItemSodaBurst","ItemTrout",
		"ItemSeaBass","FoodBioMeat","FoodMeeps","FoodSnooter","FoodWalkNSons","ItemTopaz","ItemOnyx","ItemSapphire",
		"ItemEmerald","ItemRuby","JackKit","EnergyPack","EnergyPackLg","WhiskeyNoodle"
	};
	vestsLoot[] =
	{
		"V_PlateCarrier1_rgr","V_PlateCarrier2_rgr","V_PlateCarrier3_rgr","V_PlateCarrierGL_rgr","V_PlateCarrier1_blk",
		"V_PlateCarrierSpec_rgr","V_Chestrig_khk","V_Chestrig_rgr","V_Chestrig_blk","V_Chestrig_oli","V_TacVest_khk",
		"V_TacVest_brn","V_TacVest_oli","V_TacVest_blk","V_TacVest_camo","V_TacVest_blk_POLICE","V_TacVestIR_blk","V_TacVestCamo_khk",
		"V_HarnessO_brn","V_HarnessOGL_brn","V_HarnessO_gry","V_HarnessOGL_gry","V_HarnessOSpec_brn","V_HarnessOSpec_gry","V_PlateCarrierIA1_dgtl",
		"V_PlateCarrierIA2_dgtl","V_PlateCarrierIAGL_dgtl","V_RebreatherB","V_RebreatherIR","V_RebreatherIA","V_PlateCarrier_Kerry",
		"V_PlateCarrierL_CTRG","V_PlateCarrierH_CTRG","V_I_G_resistanceLeader_F","V_Press_F"
	};
	headGearLoot[] =
	{
		"H_HelmetB","H_HelmetB_camo","H_HelmetB_paint","H_HelmetB_light","H_Booniehat_khk","H_Booniehat_oli","H_Booniehat_indp","H_Booniehat_mcamo",
		"H_Booniehat_grn","H_Booniehat_tan","H_Booniehat_dirty","H_Booniehat_dgtl","H_Booniehat_khk_hs","H_HelmetB_plain_mcamo","H_HelmetB_plain_blk",
		"H_HelmetSpecB","H_HelmetSpecB_paint1","H_HelmetSpecB_paint2","H_HelmetSpecB_blk","H_HelmetIA","H_HelmetIA_net","H_HelmetIA_camo","H_Helmet_Kerry",
		"H_HelmetB_grass","H_HelmetB_snakeskin","H_HelmetB_desert","H_HelmetB_black","H_HelmetB_sand","H_Cap_red","H_Cap_blu","H_Cap_oli","H_Cap_headphones",
		"H_Cap_tan","H_Cap_blk","H_Cap_blk_CMMG","H_Cap_brn_SPECOPS","H_Cap_tan_specops_US","H_Cap_khaki_specops_UK","H_Cap_grn","H_Cap_grn_BI","H_Cap_blk_Raven",
		"H_Cap_blk_ION","H_Cap_oli_hs","H_Cap_press","H_Cap_usblack","H_Cap_police","H_HelmetCrew_B","H_HelmetCrew_O","H_HelmetCrew_I","H_PilotHelmetFighter_B",
		"H_PilotHelmetFighter_O","H_PilotHelmetFighter_I","H_PilotHelmetHeli_B","H_PilotHelmetHeli_O","H_PilotHelmetHeli_I","H_CrewHelmetHeli_B","H_CrewHelmetHeli_O",
		"H_CrewHelmetHeli_I","H_HelmetO_ocamo","H_HelmetLeaderO_ocamo","H_MilCap_ocamo","H_MilCap_mcamo","H_MilCap_oucamo","H_MilCap_rucamo","H_MilCap_gry","H_MilCap_dgtl",
		"H_MilCap_blue","H_HelmetB_light_grass","H_HelmetB_light_snakeskin","H_HelmetB_light_desert","H_HelmetB_light_black","H_HelmetB_light_sand","H_BandMask_blk",
		"H_BandMask_khk","H_BandMask_reaper","H_BandMask_demon","H_HelmetO_oucamo","H_HelmetLeaderO_oucamo","H_HelmetSpecO_ocamo","H_HelmetSpecO_blk","H_Bandanna_surfer",
		"H_Bandanna_khk","H_Bandanna_khk_hs","H_Bandanna_cbr","H_Bandanna_sgg","H_Bandanna_sand","H_Bandanna_surfer_blk","H_Bandanna_surfer_grn","H_Bandanna_gry","H_Bandanna_blu",
		"H_Bandanna_camo","H_Bandanna_mcamo","H_Shemag_khk","H_Shemag_tan","H_Shemag_olive","H_Shemag_olive_hs","H_ShemagOpen_khk","H_ShemagOpen_tan","H_Beret_blk","H_Beret_blk_POLICE",
		"H_Beret_red","H_Beret_grn","H_Beret_grn_SF","H_Beret_brn_SF","H_Beret_ocamo","H_Beret_02","H_Beret_Colonel","H_Watchcap_blk","H_Watchcap_cbr","H_Watchcap_khk",
		"H_Watchcap_camo","H_Watchcap_sgg","H_TurbanO_blk","H_Cap_marshal"
	};
	backpacksLoot[] =
	{
		"smallbackpack_red_epoch","smallbackpack_green_epoch","smallbackpack_teal_epoch","smallbackpack_pink_epoch",
		"B_AssaultPack_khk","B_AssaultPack_dgtl","B_AssaultPack_rgr","B_AssaultPack_sgg","B_AssaultPack_cbr",
		"B_AssaultPack_mcamo","B_TacticalPack_rgr","B_TacticalPack_mcamo","B_TacticalPack_ocamo","B_TacticalPack_blk",
		"B_TacticalPack_oli","B_FieldPack_khk","B_FieldPack_ocamo","B_FieldPack_oucamo","B_FieldPack_cbr","B_FieldPack_blk",
		"B_Carryall_ocamo","B_Carryall_oucamo","B_Carryall_mcamo","B_Carryall_khk","B_Carryall_cbr","B_Parachute",
		"B_FieldPack_oli","B_Carryall_oli"
	};
	blackListLoot[] =
	{
		"DemoCharge_Remote_Mag","SatchelCharge_Remote_Mag","ATMine_Range_Mag","ClaymoreDirectionalMine_Remote_Mag",
		"APERSMine_Range_Mag","APERSBoundingMine_Range_Mag","SLAMDirectionalMine_Wire_Mag","APERSTripMine_Wire_Mag",
		"ChainSaw","srifle_DMR_03_spotter_F"
	};
	// Configuration of what AI have
	aiHeadGear[] =
	{
		"H_39_EPOCH","H_40_EPOCH","H_41_EPOCH","H_42_EPOCH","H_43_EPOCH","H_44_EPOCH","H_45_EPOCH","H_46_EPOCH",
		"H_47_EPOCH","H_48_EPOCH","H_49_EPOCH","H_50_EPOCH","H_51_EPOCH","H_52_EPOCH","H_53_EPOCH","H_54_EPOCH",
		"H_55_EPOCH","H_56_EPOCH","H_57_EPOCH","H_58_EPOCH","H_59_EPOCH","H_60_EPOCH","H_61_EPOCH","H_62_EPOCH",
		"H_63_EPOCH","H_64_EPOCH","H_65_EPOCH","H_66_EPOCH","H_67_EPOCH","H_68_EPOCH","H_69_EPOCH","H_70_EPOCH",
		"H_74_EPOCH","H_75_EPOCH","H_76_EPOCH","H_77_EPOCH","H_78_EPOCH","H_79_EPOCH","H_80_EPOCH","H_81_EPOCH",
		"H_82_EPOCH","H_83_EPOCH","H_84_EPOCH","H_85_EPOCH","H_86_EPOCH","H_87_EPOCH","H_88_EPOCH","H_89_EPOCH",
		"H_90_EPOCH","H_91_EPOCH","H_92_EPOCH","wolf_mask_epoch","pkin_mask_epoch"
	};
	aiUniforms[] =
	{
		"U_O_CombatUniform_ocamo","U_O_PilotCoveralls","U_OG_Guerilla1_1","U_OG_Guerilla2_1","U_OG_Guerilla2_3",
		"U_OG_Guerilla3_1","U_OG_Guerilla3_2","U_OG_leader","U_C_Poloshirt_stripped","U_C_Poloshirt_blue",
		"U_C_Poloshirt_burgundy","U_C_Poloshirt_tricolour","U_C_Poloshirt_salmon","U_C_Poloshirt_redwhite",
		"U_C_Poor_1","U_C_WorkerCoveralls","U_C_Journalist","U_OrestesBody","U_CamoRed_uniform","U_CamoBrn_uniform",
		"U_CamoBlue_uniform","U_Camo_uniform","U_C_Driver_3","U_C_Driver_4"
	};
	aiVests[] =
	{
		"V_1_EPOCH","V_2_EPOCH","V_3_EPOCH","V_4_EPOCH","V_5_EPOCH","V_6_EPOCH","V_7_EPOCH","V_8_EPOCH",
		"V_9_EPOCH","V_10_EPOCH","V_11_EPOCH","V_12_EPOCH","V_13_EPOCH","V_14_EPOCH","V_15_EPOCH","V_16_EPOCH",
		"V_17_EPOCH","V_18_EPOCH","V_19_EPOCH","V_20_EPOCH","V_21_EPOCH","V_22_EPOCH","V_23_EPOCH","V_24_EPOCH",
		"V_25_EPOCH","V_26_EPOCH","V_27_EPOCH","V_28_EPOCH","V_29_EPOCH","V_30_EPOCH","V_31_EPOCH","V_32_EPOCH",
		"V_33_EPOCH","V_34_EPOCH","V_35_EPOCH","V_36_EPOCH","V_37_EPOCH","V_38_EPOCH","V_39_EPOCH","V_40_EPOCH"
	};
	aiRifles[] =
	{
		"srifle_EBR_F","srifle_DMR_01_F","arifle_Katiba_F","arifle_Katiba_C_F","arifle_Katiba_GL_F","arifle_MXC_F",
		"arifle_MX_F","arifle_MX_GL_F","arifle_MXM_F","arifle_SDAR_F","arifle_TRG21_F","arifle_TRG20_F",
		"arifle_TRG21_GL_F","arifle_Mk20_F","arifle_Mk20C_F","arifle_Mk20_GL_F","arifle_Mk20_plain_F",
		"arifle_Mk20C_plain_F","arifle_Mk20_GL_plain_F","SMG_01_F","SMG_02_F","hgun_PDW2000_F","arifle_MXM_Black_F",
		"arifle_MX_GL_Black_F","arifle_MX_Black_F","arifle_MXC_Black_F","Rollins_F","LMG_Mk200_F","arifle_MX_SW_F",
		"LMG_Zafir_F","arifle_MX_SW_Black_F","m249_EPOCH","m249Tan_EPOCH","m16_EPOCH","m16Red_EPOCH","M14_EPOCH",
		"M14Grn_EPOCH","m4a3_EPOCH","AKM_EPOCH"
	};
	aiLaunchers[] =
	{
		"launch_NLAW_F","launch_RPG32_F","launch_Titan_F","launch_Titan_short_F"
	};
	aiPistols[] =
	{
		"hgun_ACPC2_F","hgun_Rook40_F","hgun_P07_F","hgun_Pistol_heavy_01_F","hgun_Pistol_heavy_02_F",
		"ruger_pistol_epoch","1911_pistol_epoch","hgun_Pistol_Signal_F"
	};
	aiItems[] =
	{
		"FAK","EnergyPack","EnergyPackLg"
	};
};


class CfgPatches
{
	class VEMF
	{
		units[] = {"I_Soldier_EPOCH"};
		requiredAddons[] = {"A3_Data_F","A3_Soft_F","A3_Soft_F_Offroad_01","A3_Characters_F"};
		fileName = "VEMF.pbo";
		VEMF_version = "0.0702.16";
		requiredVersion = 1.46;
		author[]= {"Vampire","IT07"};
	};
};
class cfgFunctions
{
	class VEMF
	{
		tag = "VEMF";
		class functions
		{
			file = "\VEMF\functions_VEMF";
			class getSetting {};
			class aiKilled {};
			class broadCast {};
			class findLoc {};
			class findPlayers {};
			class loadInv {};
			class loadLoot {};
			class waitForPlayers {};
			class spawnAI {};
			class waitForMissionDone {};
			class mainFrame { postInit = 1; };
		};
	};
};
