/*
   	Author: IT07

   	Description:
   	hpp config file for Vampire's Epoch Mission Framework (a.k.a. VEMF)

	Little back story:
	VEMF is originally made by Vampire but he kind of gave up on the project.
	Now, I (IT07) am carrying on with the project.
	Please keep in mind that some of VEMF's code is still left-over from before I took over VEMF.
	Want to report an issue? Then either PM me on the Epochmod.com forums or reply to the VEMF forum post.
	Do you like and appreciate my work? Please leave a like or a nice comment for me on the forums :)
*/

class VEMFconfig
{
	/////////////////////////////
	VEMF_version = 0.0722.8; /// Do NOT change
	/////////////////////////////
	/////// Configure VEMF here ///////
	// Global settings
	allowHeadLessClient = -1; // HC support is currently broken // Set to 1 if you have (a) headless client(s) | -1 = DISABLED
	minServerFPS = 20; // Missions will not spawn if server's FPS is below this number
	validateLoot = -1; // Use -1 to disable. Checks if defined classes in loot and ai gear (except blacklist) are valid. Will output test result to RPT if ERROR logs enabled
	minPlayers = 1; // Missions will not start until player count reaches this number OR when player count goes below this amount
	maxGlobalMissions = 5; // Use -1 to disable limit | Max amount of missions that are allowed to run at the same time
 	timeOutTime = 20; // In minutes. Use -1 to disable mission timeout; Minimal: 5
	minNew = 3; // Minimum time before new mission can run
	maxNew = 15; // Maximum time before new mission can run
	missionList[] = {"MilitiaInvasions"}; // Speaks for itself, right?
	addons[] = {}; // Not used for now
	noMissionPos[] = {{{18452.8,14279.5,0.00128174},500}}; // Format: {{position},radius} | Default: Altis East spawn
	locationBlackList[] = {"Sagonisi","Monisi","Fournos","Savri","Atsalis","Polemista","Cap Makrinos","Pyrgi","Makrynisi","Chelonisi","Almyra","Surf Club"};
	killPercentage = 100; // In percent. 100 means all AI that belong to mission need to be killed
	sayKilled = 1; // Set to -1 if you do not want AI killed messages
	allowSmall = 1; // Set to -1 if you do not want missions to target very small unusual locations
	useLaunchers = 1; // Set to -1 to prevent AI from having anti-tank launchers
		launcherChance = 50; // In percentage
		keepLaunchers = 1; // Set to 1 if you want the AI to keep their launchers when they are killed
	keepAIbodies = 1; // Set to -1 if you want the AI's body to stay after they are killed
	useCryptoReward = 1; // Use 1 to ENABLE player crypto reward for killing an AI
		maxCryptoReward = 50; // Amount of crypto to give (minimum) | amount is being scaled upwards depending on kill skill

	/////// Debugging/learning mode ///////
	enableDebug = 2; // -1 to disable all VEMF logs, 0 = ERRORS only | 1 = INFO only | 2 = ERRORS & INFO
	///////////////////////////////////////

	// Global AI skill settings. They affect each VEMF unit for any default VEMF mission
	class aiSkill // Minimum: 0 | Maximum: 1
	{
		difficulty = "Veteran"; // Options: "Easy" "Normal" "Veteran" "Hardcore" | Default: Veteran
		class Easy
		{
			accuracy = 0.4; aimingShake = 0.3; aimingSpeed = 0.3; endurance = 0.45; spotDistance = 0.65; spotTime = 0.5; courage = 1; reloadSpeed = 0.3; commanding = 0.85; general = 0.3;
		};
		class Normal
		{
			accuracy = 0.4; aimingShake = 0.3; aimingSpeed = 0.3; endurance = 0.45; spotDistance = 0.65; spotTime = 0.5; courage = 1; reloadSpeed = 0.3; commanding = 0.85; general = 0.4;
		};
		class Veteran
		{
			accuracy = 0.4; aimingShake = 0.3; aimingSpeed = 0.3; endurance = 0.45; spotDistance = 0.65; spotTime = 0.5; courage = 1; reloadSpeed = 0.3; commanding = 0.85; general = 0.5;
		};
		class Hardcore // Also known as Aimbots
		{
			accuracy = 0.4; aimingShake = 0.3; aimingSpeed = 0.3; endurance = 0.45; spotDistance = 0.65; spotTime = 0.5; courage = 1; reloadSpeed = 0.3; commanding = 0.85; general = 0.7;
		};
	};

	class MI // Militia Invasions settings
	{
		useMarker = 1; // Use -1 to disable mission markers
		maxInvasions = 5; // Max amount of active uncompleted invasions allowed at the same time
		cal50s = 3; // Max amount of .50 caliber machineguns at mission | Needs to be lower than total unit count per mission
		groupCount[] = {2,4}; // In format: {minimum, maximum}; VEMF will pick a random number between min and max. If you want the same amount always, use same numbers for minimum and maximum.
		groupUnits[] = {4,6}; // How much units in each group. Works the same like groupCount
		/* TIP: increase groupCount and decrease groupUnits to make it harder for players. Easier to get flanked from all sides */
		playerCheck = 800; // If player(s) within this range of location, location gets skipped. Distance in m (meters)
		distanceCheck = 15000; // Check for locations around random player within this distance in m (meters)
		/* distanceCheck NOTE: set it to the minimal distance between ANY town on the map you are using. Otherwise location selection will fail */
		distanceTooClose = 2500; // Mission will not spawn closer to random player than this distance in meters
		distanceMaxPrefered = 4500; // Mission will prefer locations closer than this distance (in meters) to random player
		parachuteCrate = 1; // Use -1 to disable the crate parachuting in
			crateAltitude = 150; // Crate with parachute(!) will spawn at this altitude (meters)
		crateMapMarker = 1; // Use -1 if you do not want a marker to be placed on the crate
		crateVisualMarker = 1; // Use -1 to disable chemlight/smoke on crate
		crateSpawnSound = -1; // Use -1 to disable a spawn sound when crate spawns (only if parachuteCrate = 1)
		crateTypes[] = {"I_CargoNet_01_ammo_F","O_CargoNet_01_ammo_F","B_CargoNet_01_ammo_F","I_supplyCrate_F","Box_East_AmmoVeh_F","Box_NATO_AmmoVeh_F"};
		smokeTypes[] = {"SmokeShell","SmokeShellBlue","SmokeShellGreen","SmokeShellOrange","SmokeShellRed","SmokeShellYellow"};
		flairTypes[] = {"Chemlight_green","Chemlight_red","Chemlight_yellow","Chemlight_blue"};
		placeMines = -1; // Set to -1 if you do not want mines at missions | using infiSTAR? set _RAM to false if you set placeMines to 1
		minesMode = 1; // 1 = Anti-Armor | 2 = Anti-Personell | 3 = Both Anti-Armor and Anti-Personell
		minesAmount = 20; // Ignore if placeMines = -1;
		cleanMines = 2; // 1 = remove mines when mission done | 2 = explode mines when mission done :D guarenteed chaos, LOL!
	};

	// Loot crate configuration
	class crateLoot
	{
		maxPrimarySlots = 10; // Maximum primary weapons in each loot crate
		minPrimarySlots = 4; // Minimum primary weapons in each loot crate
		primaryWeaponLoot[] =
		{ // The number after each classname means how much of that type will be put in crate. WARNING: DO NOT USE NUMBERS WITH DECIMALS.
			{"srifle_DMR_01_F",2},{"srifle_EBR_F",3},{"srifle_GM6_F",1},{"LMG_Mk200_F",3},{"LMG_Zafir_F",3},{"arifle_Katiba_F",3},{"arifle_Katiba_GL_F",2},{"arifle_Mk20_F",2},
			{"arifle_Mk20_plain_F",2},{"arifle_Mk20C_F",2},{"arifle_Mk20C_plain_F",2},{"arifle_Mk20_GL_F",2},{"arifle_Mk20_GL_plain_F",2},{"arifle_MXC_F",2},{"arifle_MX_F",2},
			{"arifle_MX_GL_F",2},{"arifle_MX_SW_F",2},{"arifle_MXM_F",2},{"arifle_MXC_Black_F",2},{"arifle_MX_Black_F",2},{"arifle_MX_GL_Black_F",2},{"arifle_MX_SW_Black_F",2},
			{"arifle_MXM_Black_F",2},{"arifle_SDAR_F",2},{"arifle_TRG21_F",2},{"arifle_TRG20_F",2},{"arifle_TRG21_GL_F",2},{"SMG_01_F",2},{"SMG_02_F",2},{"srifle_GM6_camo_F",2},
			{"srifle_LRR_camo_F",2},{"srifle_DMR_02_F",2},{"srifle_DMR_02_camo_F",2},{"srifle_DMR_02_sniper_F",2},{"srifle_DMR_03_F",2},{"srifle_DMR_03_khaki_F",2},{"srifle_DMR_03_tan_F",2},
			{"srifle_DMR_03_multicam_F",2},{"srifle_DMR_03_woodland_F",2},{"srifle_DMR_04_F",2},{"srifle_DMR_04_Tan_F",2},{"srifle_DMR_05_blk_F",2},{"srifle_DMR_05_hex_F",2},{"srifle_DMR_05_tan_f",2},{"srifle_DMR_06_camo_F",2},{"srifle_DMR_06_olive_F",2},{"MMG_01_hex_F",2},{"MMG_01_tan_F",2},{"MMG_02_camo_F",2},
			{"MMG_02_black_F",2},{"MMG_02_sand_F",2},{"m249_EPOCH",2},{"m249Tan_EPOCH",2},{"m16_EPOCH",2},{"m16Red_EPOCH",2},{"M14_EPOCH",2},{"M14Grn_EPOCH",2},{"m4a3_EPOCH",2},{"AKM_EPOCH",2}
		};

		maxSecondarySlots = 4; // Maximum number of secondary weapons to be in each loot crate
		minSecondarySlots = 2; // Minimum number of secondary weapons to be in each loot crate
		secondaryWeaponLoot[] =
		{ // The number after each classname means how much of that type will be put in crate. WARNING: DO NOT USE NUMBERS WITH DECIMALS.
			{"hgun_ACPC2_F",3},{"hgun_P07_F",3},{"hgun_Pistol_heavy_01_F",3},{"hgun_Pistol_heavy_02_F",3},{"hgun_Rook40_F",3},{"ruger_pistol_epoch",3},{"1911_pistol_epoch",3}
		};

		maxMagSlots = 6; // Maximum number of magazine slots in each loot crate
		minMagSlots = 4; // Minimum number of magazine slots in each loot crate
		magazinesLoot[] =
		{ // The number after each classname means how much of that type will be put in crate. WARNING: DO NOT USE NUMBERS WITH DECIMALS.
			{"30Rnd_556x45_Stanag",20},{"30Rnd_556x45_Stanag_Tracer_Red",20},{"30Rnd_556x45_Stanag_Tracer_Green",20},
			{"30Rnd_556x45_Stanag_Tracer_Yellow",20},{"30Rnd_65x39_caseless_mag",20},{"30Rnd_65x39_caseless_green",20},{"30Rnd_65x39_caseless_mag_Tracer",20},
			{"30Rnd_65x39_caseless_green_mag_Tracer",20},{"20Rnd_762x51_Mag",20},{"7Rnd_408_Mag",20},{"5Rnd_127x108_Mag",20},{"100Rnd_65x39_caseless_mag",20},
			{"100Rnd_65x39_caseless_mag_Tracer",20},{"200Rnd_65x39_cased_Box",20},{"200Rnd_65x39_cased_Box_Tracer",20},{"30Rnd_9x21_Mag",20},{"16Rnd_9x21_Mag",20},
			{"30Rnd_45ACP_Mag_SMG_01",20},{"30Rnd_45ACP_Mag_SMG_01_Tracer_Green",20},{"9Rnd_45ACP_Mag",20},{"150Rnd_762x51_Box",20},{"150Rnd_762x51_Box_Tracer",20},
			{"150Rnd_762x54_Box",20},{"150Rnd_762x54_Box_Tracer",20},{"11Rnd_45ACP_Mag",20},{"6Rnd_45ACP_Cylinder",20},{"10Rnd_762x51_Mag",20},{"10Rnd_762x54_Mag",20},
			{"5Rnd_127x108_APDS_Mag",20},{"10Rnd_338_Mag",20},{"130Rnd_338_Mag",20},{"10Rnd_127x54_Mag",20},{"150Rnd_93x64_Mag",20},{"10Rnd_93x64_DMR_05_Mag",20}
		};

		maxAttSlots = 4; // Maximum number of attachment slots in each loot crate
		minAttSlots = 2; // Minimum number of attachment slots in each loot crate
		attachmentsLoot[] =
		{ // The number after each classname means how much of that type will be put in crate. WARNING: DO NOT USE NUMBERS WITH DECIMALS.
			{"ItemGPS",5},{"ItemRadio",4},{"ItemMap",6},{"MineDetector",1},{"Binocular",4},{"Rangefinder",2},{"Medikit",3},{"ToolKit",1},
			{"muzzle_snds_H",2},{"muzzle_snds_L",2},{"muzzle_snds_M",2},{"muzzle_snds_B",2},{"muzzle_snds_H_MG",2},{"muzzle_snds_H_SW",2},
			{"optic_Arco",3},{"optic_Aco",3},{"optic_ACO_grn",3},{"optic_Aco_smg",3},{"optic_ACO_grn_smg",3},{"optic_Holosight",3},
			{"optic_Holosight_smg",3},{"optic_SOS",3},{"acc_flashlight",3},{"acc_pointer_IR",3},{"optic_MRCO",3},{"muzzle_snds_acp",3},
			{"optic_NVS",3},{"optic_DMS",3},{"optic_Yorris",2},{"optic_MRD",2},{"optic_LRPS",3},{"muzzle_snds_338_black",3},{"muzzle_snds_338_green",3},
			{"muzzle_snds_338_sand",3},{"muzzle_snds_93mmg",3},{"muzzle_snds_93mmg_tan",3},{"optic_AMS",3},{"optic_AMS_khk",3},{"bipod_03_F_oli",3},
			{"optic_AMS_snd",3},{"optic_KHS_blk",3},{"optic_KHS_hex",3},{"optic_KHS_old",3},{"optic_KHS_tan",3},{"bipod_01_F_snd",3},
			{"bipod_01_F_blk",3},{"bipod_01_F_mtp",3},{"bipod_02_F_blk",3},{"bipod_02_F_tan",3},{"bipod_02_F_hex",3},{"bipod_03_F_blk",3}
		};

		maxItemSlots = 4; // Maximum number of attachment slots in each loot crate
		minItemSlots = 2; // Minimum number of attachment slots in each loot crate
		itemsLoot[] =
		{ // The number after each classname means how much of that type will be put in crate. WARNING: DO NOT USE NUMBERS WITH DECIMALS.
			{"FAK",15},{"EnergyPack",10},{"EnergyPackLg",6}
		};

		maxVestSlots = 4; // Maximum number of vest slots in each loot crate
		minVestSlots = 2; // Minimum number of vest slots in each loot crate
		vestsLoot[] = // NOTE ABOUT VESTS: it is recommended to keep amount for each vest at 1 because vests do not stack unlike weapons, items and magazines
		{ // The number after each classname means how much of that type will be put in crate. WARNING: DO NOT USE NUMBERS WITH DECIMALS.
			{"V_PlateCarrier1_rgr",1},{"V_PlateCarrier2_rgr",1},{"V_PlateCarrier3_rgr",1},{"V_PlateCarrierGL_rgr",1},{"V_PlateCarrier1_blk",1},
			{"V_PlateCarrierSpec_rgr",1},{"V_Chestrig_khk",1},{"V_Chestrig_rgr",1},{"V_Chestrig_blk",1},{"V_Chestrig_oli",1},{"V_TacVest_khk",1},
			{"V_TacVest_brn",1},{"V_TacVest_oli",1},{"V_TacVest_blk",1},{"V_TacVest_camo",1},{"V_TacVest_blk_POLICE",1},{"V_TacVestIR_blk",1},{"V_TacVestCamo_khk",1},
			{"V_HarnessO_brn",1},{"V_HarnessOGL_brn",1},{"V_HarnessO_gry",1},{"V_HarnessOGL_gry",1},{"V_HarnessOSpec_brn",1},{"V_HarnessOSpec_gry",1},
			{"V_PlateCarrierIA1_dgtl",1},{"V_PlateCarrierIA2_dgtl",1},{"V_PlateCarrierIAGL_dgtl",1},{"V_RebreatherB",1},{"V_RebreatherIR",1},{"V_RebreatherIA",1},
			{"V_PlateCarrier_Kerry",1},{"V_PlateCarrierL_CTRG",1},{"V_PlateCarrierH_CTRG",1},{"V_I_G_resistanceLeader_F",1},{"V_Press_F",1}
		};

		maxHeadGearSlots = 4; // Maximum number of headGear slots in each loot crate
		minHeadGearSlots = 2; // Minimum number of headGear slots in each loot crate
		headGearLoot[] = // NOTE ABOUT HEADGEAR: it is recommended to keep amount for each headGear item at 1 because headGear items do not stack unlike weapons, items and magazines
		{ // The number after each classname means how much of that type will be put in crate. WARNING: DO NOT USE NUMBERS WITH DECIMALS.
			{"H_HelmetB",1},{"H_HelmetB_camo",1},{"H_HelmetB_paint",1},{"H_HelmetB_light",1},{"H_Booniehat_khk",1},{"H_Booniehat_oli",1},{"H_Booniehat_indp",1},
			{"H_Booniehat_mcamo",1},{"H_Booniehat_grn",1},{"H_Booniehat_tan",1},{"H_Booniehat_dirty",1},{"H_Booniehat_dgtl",1},{"H_Booniehat_khk_hs",1},{"H_HelmetB_plain_mcamo",1},
			{"H_HelmetB_plain_blk",1},{"H_HelmetSpecB",1},{"H_HelmetSpecB_paint1",1},{"H_HelmetSpecB_paint2",1},{"H_HelmetSpecB_blk",1},{"H_HelmetIA",1},{"H_HelmetIA_net",1},
			{"H_HelmetIA_camo",1},{"H_Helmet_Kerry",1},{"H_HelmetB_grass",1},{"H_HelmetB_snakeskin",1},{"H_HelmetB_desert",1},{"H_HelmetB_black",1},{"H_HelmetB_sand",1},
			{"H_Cap_red",1},{"H_Cap_blu",1},{"H_Cap_oli",1},{"H_Cap_headphones",1},{"H_Cap_tan",1},{"H_Cap_blk",1},{"H_Cap_blk_CMMG",1},{"H_Cap_brn_SPECOPS",1},{"H_Cap_tan_specops_US",1},
			{"H_Cap_khaki_specops_UK",1},{"H_Cap_grn",1},{"H_Cap_grn_BI",1},{"H_Cap_blk_Raven",1},{"H_Cap_blk_ION",1},{"H_Cap_oli_hs",1},{"H_Cap_press",1},{"H_Cap_usblack",1},{"H_Cap_police",1},
			{"H_HelmetCrew_B",1},{"H_HelmetCrew_O",1},{"H_HelmetCrew_I",1},{"H_PilotHelmetFighter_B",1},{"H_PilotHelmetFighter_O",1},{"H_PilotHelmetFighter_I",1},
			{"H_PilotHelmetHeli_B",1},{"H_PilotHelmetHeli_O",1},{"H_PilotHelmetHeli_I",1},{"H_CrewHelmetHeli_B",1},{"H_CrewHelmetHeli_O",1},{"H_CrewHelmetHeli_I",1},{"H_HelmetO_ocamo",1},
			{"H_HelmetLeaderO_ocamo",1},{"H_MilCap_ocamo",1},{"H_MilCap_mcamo",1},{"H_MilCap_oucamo",1},{"H_MilCap_rucamo",1},{"H_MilCap_gry",1},{"H_MilCap_dgtl",1},
			{"H_MilCap_blue",1},{"H_HelmetB_light_grass",1},{"H_HelmetB_light_snakeskin",1},{"H_HelmetB_light_desert",1},{"H_HelmetB_light_black",1},{"H_HelmetB_light_sand",1},{"H_BandMask_blk",1},
			{"H_BandMask_khk",1},{"H_BandMask_reaper",1},{"H_BandMask_demon",1},{"H_HelmetO_oucamo",1},{"H_HelmetLeaderO_oucamo",1},{"H_HelmetSpecO_ocamo",1},{"H_HelmetSpecO_blk",1},
			{"H_Bandanna_surfer",1},{"H_Bandanna_khk",1},{"H_Bandanna_khk_hs",1},{"H_Bandanna_cbr",1},{"H_Bandanna_sgg",1},{"H_Bandanna_sand",1},{"H_Bandanna_surfer_blk",1},{"H_Bandanna_surfer_grn",1},
			{"H_Bandanna_gry",1},{"H_Bandanna_blu",1},{"H_Bandanna_camo",1},{"H_Bandanna_mcamo",1},{"H_Shemag_khk",1},{"H_Shemag_tan",1},{"H_Shemag_olive",1},{"H_Shemag_olive_hs",1},
			{"H_ShemagOpen_khk",1},{"H_ShemagOpen_tan",1},{"H_Beret_blk",1},{"H_Beret_blk_POLICE",1},{"H_Beret_red",1},{"H_Beret_grn",1},{"H_Beret_grn_SF",1},{"H_Beret_brn_SF",1},
			{"H_Beret_ocamo",1},{"H_Beret_02",1},{"H_Beret_Colonel",1},{"H_Watchcap_blk",1},{"H_Watchcap_cbr",1},{"H_Watchcap_khk",1},{"H_Watchcap_camo",1},{"H_Watchcap_sgg",1},
			{"H_TurbanO_blk",1},{"H_Cap_marshal",1}
		};

		maxBagSlots = 4;
		minBagSlots = 2;
		backpacksLoot[] = // NOTE ABOUT BACKPACKS: it is recommended to keep amount for each bag at 1 because bags do not stack unlike weapons, items and magazines
		{ // The number after each classname means how much of that type will be put in crate. WARNING: DO NOT USE NUMBERS WITH DECIMALS.
			{"B_AssaultPack_khk",1},{"B_AssaultPack_dgtl",1},{"B_AssaultPack_rgr",1},{"B_AssaultPack_sgg",1},{"B_AssaultPack_cbr",1},
			{"B_AssaultPack_mcamo",1},{"B_TacticalPack_rgr",1},{"B_TacticalPack_mcamo",1},{"B_TacticalPack_ocamo",1},{"B_TacticalPack_blk",1},
			{"B_TacticalPack_oli",1},{"B_FieldPack_khk",1},{"B_FieldPack_ocamo",1},{"B_FieldPack_oucamo",1},{"B_FieldPack_cbr",1},
			{"B_FieldPack_blk",1},{"B_Carryall_ocamo",1},{"B_Carryall_oucamo",1},{"B_Carryall_mcamo",1},{"B_Carryall_khk",1},{"B_Carryall_cbr",1},
			{"B_Parachute",1},{"B_FieldPack_oli",1},{"B_Carryall_oli",1},{"B_Kitbag_Base",1},{"B_Kitbag_cbr",1},{"B_Kitbag_mcamo",1},
			{"B_Kitbag_rgr",1},{"B_Kitbag_sgg",1},{"B_OutdoorPack_Base",1},{"B_OutdoorPack_blk",1},{"B_OutdoorPack_blu",1},
			{"B_OutdoorPack_tan",1}
		};

		blackListLoot[] =
		{
			"DemoCharge_Remote_Mag","SatchelCharge_Remote_Mag","ATMine_Range_Mag","ClaymoreDirectionalMine_Remote_Mag",
			"APERSMine_Range_Mag","APERSBoundingMine_Range_Mag","SLAMDirectionalMine_Wire_Mag","APERSTripMine_Wire_Mag",
			"ChainSaw","srifle_DMR_03_spotter_F"
		};
		// End of loot crate configuration
	};
	class aiGear
	{
		// Configuration of what AI have
		aiUniforms[] =
		{
			"U_I_CombatUniform","U_I_CombatUniform_tshirt","U_I_CombatUniform_shortsleeve","U_I_pilotCoveralls",
			"U_I_GhillieSuit","U_I_OfficerUniform","U_MillerBody","U_KerryBody","U_IG_Guerilla1_1","U_IG_Guerilla2_1",
			"U_IG_Guerilla2_2","U_IG_Guerilla2_3","U_IG_Guerilla3_1","U_IG_Guerilla3_2","U_IG_leader","U_BG_Guerilla1_1",
			"U_BG_Guerilla2_1","U_BG_Guerilla2_3","U_BG_Guerilla3_1","U_BG_Guerilla3_2","U_BG_leader","U_OG_Guerilla1_1",
			"U_OG_Guerilla2_1","U_OG_Guerilla2_2","U_OG_Guerilla2_3","U_OG_Guerilla3_1","U_OG_Guerilla3_2","U_OG_leader",
			"U_C_WorkerCoveralls","U_C_HunterBody_grn","U_C_HunterBody_brn","U_B_CTRG_1","U_B_CTRG_2","U_B_CTRG_3","U_B_survival_uniform",
			"U_I_G_Story_Protagonist_F","U_I_G_resistanceLeader_F","U_IG_Guerrilla_6_1","U_BG_Guerrilla_6_1","U_OG_Guerrilla_6_1",
			"U_B_FullGhillie_lsh","U_B_FullGhillie_sard","U_B_FullGhillie_ard","U_O_FullGhillie_lsh","U_O_FullGhillie_sard",
			"U_O_FullGhillie_ard","U_I_FullGhillie_lsh","U_I_FullGhillie_sard","U_I_FullGhillie_ard"
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
		aiBackpacks[] =
		{
			"B_AssaultPack_khk","B_AssaultPack_dgtl","B_AssaultPack_rgr","B_AssaultPack_sgg","B_AssaultPack_cbr",
			"B_AssaultPack_mcamo","B_TacticalPack_rgr","B_TacticalPack_mcamo","B_TacticalPack_ocamo","B_TacticalPack_blk",
			"B_TacticalPack_oli","B_FieldPack_khk","B_FieldPack_ocamo","B_FieldPack_oucamo","B_FieldPack_cbr",
			"B_FieldPack_blk","B_Carryall_ocamo","B_Carryall_oucamo","B_Carryall_mcamo","B_Carryall_khk","B_Carryall_cbr",
			"B_Parachute","B_FieldPack_oli","B_Carryall_oli","B_Kitbag_Base","B_Kitbag_cbr","B_Kitbag_mcamo",
			"B_Kitbag_rgr","B_Kitbag_sgg","B_OutdoorPack_Base","B_OutdoorPack_blk","B_OutdoorPack_blu",
			"B_OutdoorPack_tan"
		};
		aiLaunchers[] =
		{
			"launch_NLAW_F","launch_RPG32_F","launch_I_Titan_F","launch_I_Titan_short_F"
		};
		aiPistols[] =
		{
			"hgun_ACPC2_F","hgun_Rook40_F","hgun_P07_F","hgun_Pistol_heavy_01_F","hgun_Pistol_heavy_02_F",
			"ruger_pistol_epoch","1911_pistol_epoch"
		};
	};
};
class CfgPatches
{
	class Epoch_VEMF
	{
		units[] = {"I_Soldier_EPOCH"};
		requiredAddons[] = {};
		fileName = "Epoch_VEMF.pbo";
		requiredVersion = 1.50;
		author[]= {"Vampire","IT07"}; // Original author: Vampire. Permission to continue/remake VEMF given to IT07
	};
};
class cfgFunctions
{
	class VEMF
	{
		tag = "VEMF";
		class functions
		{
			file = "Epoch_VEMF\functions_VEMF";
			class random {};
			class log {};
			class getSetting {};
			class aiKilled {};
			class findPos {};
			class broadCast {};
			class playerCount {};
			class headLessClient {};
			class signAI {};
			class transferOwner {};
			class checkPlayerPresence {};
			class loadInv {};
			class spawnAI {};
			class loadLoot {};
			class placeMines {};
			class waitForPlayers {};
			class waitForMissionDone {};
			class checkLoot {};
			class missionTimer {};
			class launchVEMF { postInit = 1; };
			class REMOTEguard { postInit = 1; };
		};
	};
};
