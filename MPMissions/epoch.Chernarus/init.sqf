if !( isServer || isDedicated ) then {	
	
	waitUntil{(isPlayer player) && (alive player) && !isNil "EPOCH_loadingScreenDone"};
	
	/* All broadcasts, uses VEMF missions [title, type]
	-----------------------------------------------------------
	*/
	"VEMFChatMsg" addPublicVariableEventHandler {
		playSound "RadioAmbient6";
		systemChat ((_this select 1) select 0);
		[
			[
				[((_this select 1) select 0),"align = 'center' size = '1' font='PuristaBold'"],
				["","<br/>"],
				[((_this select 1) select 1),"align = 'center' size = '0.5'"]
			]
		] spawn BIS_fnc_typeText2;
		VEMFChatMsg = nil;
	};
	// --------------------------------------------------------
	
	/* Nuke
	-----------------------------------------------------------
	*/
	"NUKESiren" addPublicVariableEventHandler {
		[_this select 1] spawn FEAR_fnc_nukeSiren;
		NUKESiren = nil;
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
		NUKEGeiger = nil;
	};
	
	// --------------------------------------------------------
	
	/* 	N8M4RE Persistence https://github.com/n8m4re/A3_Epoch_PersistenceAddon
	-----------------------------------------------------------
	*/
	player addEventHandler ["Put",{ 
		N8M4RE_PERSISTENCE_PUT =_this;
		publicVariableServer "N8M4RE_PERSISTENCE_PUT";
	}];

	player addEventHandler ["Take",{ 
		N8M4RE_PERSISTENCE_TAKE = _this;
		publicVariableServer "N8M4RE_PERSISTENCE_TAKE";
	}];
	// --------------------------------------------------------
	
	/* Load other scripts
	-----------------------------------------------------------
	*/
	call compileFinal preprocessFileLineNumbers "SHK_pos\shk_pos_init.sqf";
	call compileFinal preprocessFileLineNumbers "FEAR\scripts\FEAR_nuke_clientFunctions.sqf";
	call compileFinal preProcessFileLineNumbers "cmEarplugs\config.sqf";
	
	[] execVM "FEAR\scripts\fn_statusBar.sqf";			// Status bar lower screen
	[] execVM "FEAR\scripts\FEAR_ambientFx.sqf";			// Random sound fx
	[] execVM "wai\remote.sqf";								// Wicked AI
	[] execVM "service_point\service_point.sqf";			// http://epochmod.com/forum/index.php?/topic/34454-repair-rearming-script/
	[] execVM "FEAR\scripts\OX3_GetInProtect.sqf";			// http://epochmod.com/forum/index.php?/topic/35767-exploding-heli-protection-script/
	[] execVM "paintshop\paintshop.sqf";					// http://epochmod.com/forum/index.php?/topic/35945-painshop-paintset-custom-textures-on-backpack-uniforms-and-vehicles/
	// --------------------------------------------------------
	
	#include "A3EAI_Client\A3EAI_initclient.sqf";			// A3AI radio messages
};

[] execVM "messages\init.sqf";								// Kill msgs  http://epochmod.com/forum/index.php?/topic/34570-easy-kill-feedmessages-beta/
[] execVM "service_point\HALV_takegive_crypto_init.sqf";	// Service point

// Halv scripts http://epochmod.com/forum/index.php?/tags/forums/Halv/
[] execVM "halv_spawn\init.sqf";
[] execVM "trader\init.sqf";
[] execVM "trader\resetvehicleammo.sqf";

if (!isDedicated && hasInterface) then {
	// http://epochmod.com/forum/index.php?/topic/34576-release-attach-explosives/
	while {true} do
	{
		waitUntil {alive vehicle player};
		Sleep 30;
		[] execVM "FEAR\scripts\EtV.sqf";
		waitUntil {!isNil "EtVInitialized"};
		[player] call EtV_Actions;
				
		waitUntil {!alive player};
		Sleep 30;
		[] execVM "FEAR\scripts\EtV.sqf";
		waitUntil {!isNil "EtVInitialized"};
		[player] call EtV_Actions;	
	};
};