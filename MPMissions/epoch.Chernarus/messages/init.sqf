/*
	a3 epoch killfeed init
	By Halv
*/

// Settings
HALV_KillFeedsideChat		= true; //note that sideChat only shows if more than one player is on the server (not that it matters much)       
HALV_KillFeedglobalChat		= true;
HALV_KillFeedsystemChat		= true;
HALV_KillFeedtitleText		= true;
HALV_KillFeedcutText		= true;
HALV_KillFeedhint			= true;
HALV_KillFeedhintSilent		= true;
HALV_KillFeeddynamictext	= true;
HALV_KillFeed_AI			= true; //this is to allow killfeed for players killed by anything that is not a player (sometimes a player is apparently not a player, so i leave this as an option for now)

private ["_folder"];
_folder = "messages\";

if(isServer)then{
		[] execVM (_folder + "halv_killed_loop.sqf");
		diag_log "[KillFeed]: Server loading killfeed function";
		Halv_fnc_playerdied = compileFinal preprocessFileLineNumbers (_folder + "halv_fnc_playerdied.sqf");
};
 
if (hasInterface) then {
		diag_log "[KillFeed]: Client loading message function";
		Halv_fnc_message_players = compileFinal preprocessFileLineNumbers (_folder + "Halv_fnc_message_players.sqf");
		diag_log "[KillFeed]: Client loading PublicVariableEventHandler";
		"HalvPV_player_message" addPublicVariableEventHandler {(_this select 1) call Halv_fnc_message_players;};
		waitUntil {!isNull (findDisplay 46)};
		waitUntil {!dialog};
		sleep 4;
		enableRadio true;
};