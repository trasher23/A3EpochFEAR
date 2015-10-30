if (!isDedicated && hasInterface) then {
	
	/* Load functions
	-----------------------------------------------------------
	*/
	call compileFinal preprocessFileLineNumbers "SHK_pos\shk_pos_init.sqf";
	
	/* Server to Client functions
	-----------------------------------------------------------
	*/
	"NUKESiren" addPublicVariableEventHandler {
		[_this select 1] spawn FEAR_fnc_nukeSiren;
	};

	"NUKEDetonate" addPublicVariableEventHandler {
		[_this select 1] spawn FEAR_fnc_nukeDetonate;
		NUKEDetonate = nil;
		publicVariable "NUKEDetonate";
	};
	
	"NUKEQuake" addPublicVariableEventHandler {
		[random 4] spawn BIS_fnc_earthquake;
		NUKEQuake = nil;
		publicVariable "NUKEQuake";
	};
	
	"NUKEGeiger" addPublicVariableEventHandler {
		[_this select 1] spawn FEAR_fnc_nukeGeiger;
	};
	
	/* Client to Server functions
	---------------------------------
	*/
	// Client to Server logging
	FEARserverLog = {
		ServerLog = _this select 0;
		publicVariableServer "ServerLog";
	};
	
	// Spawn wolfpack
	FEARspawnWolfpack = {
		SpawnWolfpack = _this select 0;
		publicVariableServer "SpawnWolfpack";
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
	
	// If incoming missile, warn player
	_EHincomingmissle = player addEventHandler ["IncomingMissile", {[_this] spawn "FEAR_fnc_incomingMissile.sqf"}];
};

/*
Need to run on both server and client
*/
// Halv scripts http://epochmod.com/forum/index.php?/tags/forums/Halv/
[] execVM "halv_spawn\init.sqf";
[] execVM "trader\init.sqf";
[] execVM "trader\HALV_takegive_crypto_init.sqf";
[] execVM "trader\resetvehicleammo.sqf";
[] execVM "messages\init.sqf";							// Kill msgs http://epochmod.com/forum/index.php?/topic/34570-easy-kill-feedmessages-beta/

// At bottom of script, causes problems otherwise
if (!isDedicated && hasInterface) then {
	#include "A3EAI_Client\A3EAI_initclient.sqf";		// A3AI radio messages
};

waitUntil{(isPlayer player) && (alive player) && !(isNil "EPOCH_loadingScreenDone")};

if (!isDedicated && hasInterface) then {
	// Add gasmask if in spawnbox
	if((player distance (getMarkerPos "respawn_west")) < 1500) then {
		player addGoggles "G_mas_wpn_gasmask";
	};
	(vehicle player) switchCamera "EXTERNAL"; 			// Start in 3rd person view
};