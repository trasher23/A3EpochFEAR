if (!isServer) then {	
	
	waitUntil{(isPlayer player) && (alive player) && !isNil "EPOCH_loadingScreenDone"};
	
	/* VEMF missions
	-----------------------------------------------------------
	*/
	"VEMFChatMsg" addPublicVariableEventHandler {
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
	
	/* Nuke eventhandlers
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
	// --------------------------------------------------------
	
	/* 	N8M4RE SupplyDropAddon https://github.com/n8m4re/A3Epoch_SupplyDropAddon
	-----------------------------------------------------------
	*/
	"SDROP_globalHint" addPublicVariableEventHandler { 
		_this select 1 spawn {	hint parseText format["%1", _this select 1]; };
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

	[] execVM "FEAR\scripts\fn_statusBar.sqf";			// Status bar lower screen
	[] execVM "FEAR\scripts\FEAR_ambientFx.sqf";		// Random sound fx
	[] execVM "FEAR\scripts\FEAR_playerLoadOut.sqf";	// Initial player gear
	[] execVM "wai\remote.sqf";							// Wicked AI
	// --------------------------------------------------------
	
	#include "A3EAI_Client\A3EAI_initclient.sqf";	// A3AI radio messages
	
};

[] execVM "messages\init.sqf";	// Kill msgs  http://epochmod.com/forum/index.php?/topic/34570-easy-kill-feedmessages-beta/
