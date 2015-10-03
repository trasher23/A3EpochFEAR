if (!isDedicated && hasInterface) then {
	
	/* Server to Client functions
	-----------------------------------------------------------
	*/
	// Nuke event handlers
	"NUKESiren" addPublicVariableEventHandler {
		[_this select 1] spawn FEAR_fnc_nukeSiren;
	};

	"NUKEImpact" addPublicVariableEventHandler {
		[_this select 1] spawn FEAR_fnc_nukeImpact;
		NUKEImpact = nil;
	};
	
	"NUKEQuake" addPublicVariableEventHandler {
		[random 4] spawn BIS_fnc_earthquake;
		NUKEQuake = nil;
	};
	
	"NUKEGeiger" addPublicVariableEventHandler {
		[_this select 1] spawn FEAR_fnc_nukeGeiger;
	};
	
	/* Public client functions
	---------------------------------
	*/
	// Client to Server logging
	FEARserverLog = {
		ServerLog = _this select 0;
		publicVariableServer "ServerLog";
	};
	
	// Spawn wolfpack
	FEARwolfpackSpawn = {
		WolfpackSpawn = _this select 0;
		publicVariableServer "WolfpackSpawn";
	};
	
	// Spawn demon
	FEARdemonSpawn = {
		DemonSpawn = _this select 0;
		publicVariableServer "DemonSpawn";
	};
	
	// Spawn exploding barrel
	FEARspawnExplodingBarrel = {
		SpawnExplodingBarrel = _this select 0;
		publicVariableServer "SpawnExplodingBarrel";
	};
	
	// Spawn zombies
	FEARspawnZombies = {
		SpawnZombies = _this select 0;
		publicVariableServer "SpawnZombies";
	};
	
	/* Load other scripts
	-----------------------------------------------------------
	*/
	call compileFinal preprocessFileLineNumbers "SHK_pos\shk_pos_init.sqf";
	call compileFinal preprocessFileLineNumbers "FEAR\scripts\FEAR_nuke_clientFunctions.sqf";
	call compileFinal preProcessFileLineNumbers "cmEarplugs\config.sqf";
	
	[] execVM "FEAR\scripts\FEAR_statusBar.sqf";			// Status bar lower screen
	[] execVM "FEAR\scripts\FEAR_ambientFx.sqf";			// Random sound fx
	[] execVM "FEAR\scripts\OX3_GetInProtect.sqf";			// http://epochmod.com/forum/index.php?/topic/35767-exploding-heli-protection-script/
	[] execVM "paintshop\paintshop.sqf";					// http://epochmod.com/forum/index.php?/topic/35945-painshop-paintset-custom-textures-on-backpack-uniforms-and-vehicles/
	[] execVM "FEAR\scripts\FEAR_masterLoop.sqf"; 			// FEAR master loop - currently spawns exploding barrels
};

// Needs to run on both server and client
// Halv scripts http://epochmod.com/forum/index.php?/tags/forums/Halv/
[] execVM "halv_spawn\init.sqf";
[] execVM "trader\init.sqf";
[] execVM "trader\HALV_takegive_crypto_init.sqf";
[] execVM "trader\resetvehicleammo.sqf";
[] execVM "messages\init.sqf";								// Kill msgs  http://epochmod.com/forum/index.php?/topic/34570-easy-kill-feedmessages-beta/

// At bottom of script, causes problems otherwise
if (!isDedicated && hasInterface) then {
	#include "A3EAI_Client\A3EAI_initclient.sqf";			// A3AI radio messages
};

waitUntil{(isPlayer player) && (alive player) && !(isNil "EPOCH_loadingScreenDone")};

// Start with apocalyptic environment
[] Call FEAR_fnc_nukeFlash;
[] Call FEAR_fnc_nukeAsh;