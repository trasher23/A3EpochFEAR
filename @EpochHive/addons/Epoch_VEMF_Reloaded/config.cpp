/*
   	Author: IT07

   	Description:
   	contains configuration for VEMF_Reloaded
*/

class CfgVemfReloaded
{
	// Global settings
	allowHeadLessClient = -1; // HC support is currently broken // Set to 1 if you have (a) headless client(s) | -1 = DISABLED
	minServerFPS = 20; // Missions will not spawn if server's FPS is below this number
	minPlayers = 1; // Missions will not start until player count reaches this number OR when player count goes below this amount
	maxGlobalMissions = 5; // Use -1 to disable limit | Max amount of missions that are allowed to run at the same time
 	timeOutTime = 20; // In minutes. Use -1 to disable mission timeout; Minimal: 5
	minNew = 5; // Minimum time before new mission can run
	maxNew = 15; // Maximum time before new mission can run
	missionList[] = {"MilitiaInvasions"}; // Speaks for itself, right?
	missionDistance = 1500; // Minimum distance between missions
	addons[] = {}; // Not used for now
	noMissionPos[] = {{{18452.8,14279.5,0.00128174},500}}; // Format: {{position},radius} | Default: Altis East spawn
	locationBlackList[] = {"Sagonisi","Monisi","Fournos","Savri","Atsalis","Polemista","Cap Makrinos","Pyrgi","Makrynisi","Chelonisi","Almyra","Surf Club"};
	housesBlacklist[] = {};
	killPercentage = 100; // In percent. 100 means all AI that belong to mission need to be killed
	sayKilled = 1; // Set to -1 if you do not want AI killed messages
	allowSmall = 1; // Set to -1 if you do not want missions to target very small unusual locations
	useLaunchers = 1; // Set to -1 to prevent AI from having anti-tank launchers
		launcherChance = 50; // In percentage
		keepLaunchers = 1; // Set to 1 if you want the AI to keep their launchers when they are killed
	keepAIbodies = 1; // Set to -1 if you want the AI's body to be deleted after they are killed
	useCryptoReward = -1; // Use 1 to ENABLE player crypto reward for killing an AI
		maxCryptoReward = 50; // Amount of crypto to give (minimum) | amount is being scaled upwards depending on kill skill

	/////// Debugging/learning mode ///////
	enableDebug = 2; // -1 to disable all VEMF logs, 0 = ERRORS only | 1 = INFO only | 2 = ERRORS & INFO
	///////////////////////////////////////

	// Global AI skill settings. They affect each VEMF unit for any default VEMF mission
	class aiSkill // Minimum: 0 | Maximum: 1
	{
		difficulty = "Easy"; // Options: "Easy" "Normal" "Veteran" "Hardcore" | Default: Veteran
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
		useAnnouncements = 1; // Use -1 to disable mission announcements
		useMarker = 1; // Use -1 to disable mission markers
		maxInvasions = 2; // Max amount of active uncompleted invasions allowed at the same time
		cal50s = round(ceil(random 3)); // Max amount of .50 caliber machineguns at mission | Needs to be lower than total unit count per mission
			keep50s = 1; // Set to -1 to enable the removal of all 50s created by MI
			cal50delMode = 1; // 1 is delete, 2 is destroy
		groupCount[] = {1,3}; // In format: {minimum, maximum}; VEMF will pick a random number between min and max. If you want the same amount always, use same numbers for minimum and maximum.
		groupUnits[] = {2,3}; // How much units in each group. Works the same like groupCount
		/* TIP: increase groupCount and decrease groupUnits to make it harder for players. Easier to get flanked from all sides */
		playerCheck = 800; // If player(s) within this range of location, location gets skipped. Distance in m (meters)
		distanceCheck = 15000; // Check for locations around random player within this distance in m (meters)
		/* distanceCheck NOTE: set it to the minimal distance between ANY town on the map you are using. Otherwise location selection will fail */
		distanceTooClose = 2500; // Mission will not spawn closer to random player than this distance in meters
		distanceMaxPrefered = 4500; // Mission will prefer locations closer than this distance (in meters) to random player
		parachuteCrate = 1; // Use -1 to disable the crate parachuting in
			crateAltitude = 200; // Crate with parachute(!) will spawn at this altitude (meters)
		crateMapMarker = 1; // Use -1 if you do not want a marker to be placed on the crate
		crateVisualMarker = 1; // Use -1 to disable chemlight/smoke on crate
		crateTypes[] = {"I_CargoNet_01_ammo_F","O_CargoNet_01_ammo_F","B_CargoNet_01_ammo_F","I_supplyCrate_F","Box_East_AmmoVeh_F","Box_NATO_AmmoVeh_F"};
		smokeTypes[] = {"SmokeShell","SmokeShellBlue","SmokeShellGreen","SmokeShellOrange","SmokeShellRed","SmokeShellYellow"};
		flairTypes[] = {"Chemlight_green","Chemlight_red","Chemlight_yellow","Chemlight_blue"};
		placeMines = -1; // Set to -1 if you do not want mines at missions | using infiSTAR? set _RAM to false if you set placeMines to 1
		minesMode = 1; // 1 = Anti-Armor | 2 = Anti-Personell | 3 = Both Anti-Armor and Anti-Personell
		minesAmount = 20; // Ignore if placeMines = -1;
		cleanMines = 2; // 1 = remove mines when mission done | 2 = explode mines when mission done :D guarenteed chaos, LOL!
	};

	class aiGear
	{
		// Configuration of what AI have
		aiLaunchers[] =
		{
			"launch_NLAW_F","launch_RPG32_F","launch_I_Titan_F","launch_I_Titan_short_F"
		};
	};
};

class CfgPatches
{
	class Epoch_VEMF_Reloaded
	{
		units[] = {"I_Soldier_EPOCH"};
		requiredAddons[] = {};
		fileName = "Epoch_VEMF_Reloaded.pbo";
		requiredVersion = 1.50;
		version = 0725.8; // Do NOT change
		author[]= {"IT07"};
	};
};

class CfgFunctions
{
	class Epoch_VEMF_Reloaded
	{
		tag = "VEMFr";
		class serverFunctions
		{
			file = "Epoch_VEMF_Reloaded\functions";
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
			class missionTimer {};
			class launch { postInit = 1; };
			class REMOTEguard { postInit = 1; };
		};
	};
};
