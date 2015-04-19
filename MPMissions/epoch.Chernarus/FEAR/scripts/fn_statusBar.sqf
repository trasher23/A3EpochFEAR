waitUntil {!(isNull (findDisplay 46))};
disableSerialization;
/*
	File: fn_statusBar.sqf
	Author: Osef (Ported to EpochMod by piX)
	Edited by: [piX]
	Description: Puts a small bar in the bottom centre of screen to display in-game information
	
	PLEASE KEEP CREDITS - THEY ARE DUE TO THOSE WHO PUT IN THE EFFORT!

*/
_rscLayer = "osefStatusBar" call BIS_fnc_rscLayer;
_rscLayer cutRsc["osefStatusBar","PLAIN"];
systemChat format["statusBar Loading player info...", _rscLayer];

[] spawn {
	while {true} do
	{
		sleep 1;
		((uiNamespace getVariable "osefStatusBar")displayCtrl 1000)ctrlSetText format["FPS: %1 | PLAYERS: %2 | DAMAGE: %3 | KRYPTO: %4 | HUNGER: %5 | THIRST: %6 | STAMINA: %7 | GRIDREF: %8", round diag_fps, count playableUnits, damage player, EPOCH_playerCrypto, EPOCH_playerHunger, EPOCH_playerThirst, round EPOCH_playerStamina, mapGridPosition player];
	}; 
};
