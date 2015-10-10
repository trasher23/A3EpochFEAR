/*
	File: fn_statusBar.sqf
	Author: Osef (Ported to EpochMod by piX)
	Edited by: [piX]
	Description: Puts a small bar in the bottom centre of screen to display in-game information
	
	PLEASE KEEP CREDITS - THEY ARE DUE TO THOSE WHO PUT IN THE EFFORT!
*/
waitUntil {!(isNull (findDisplay 46))};
disableSerialization;

_rscLayer = "osefStatusBar" call BIS_fnc_rscLayer;
_rscLayer cutRsc["osefStatusBar","PLAIN"];
[] spawn {
	private ["_damage","_pos","_posPlayer","_fatigue"];
	
	while {true} do
	{
		uiSleep 1;
	
		// Damage as percentage, with % symbol
		_damage = parseText format["%1&#37", round(damage player * 100)];
		_fatigue = ((getFatigue player) * 100) / 100; // two decimal places (10^2)
		
		((uiNamespace getVariable "osefStatusBar")displayCtrl 1000)ctrlSetText format
		[
			"DAMAGE: %1 | HUNGER: %2 | THIRST: %3 | STAMINA: %4 | FATIGUE: %5 | CRYPTO: %6 | FPS: %7 | PLAYERS: %8" ,
			_damage,round EPOCH_playerHunger,round EPOCH_playerThirst,round EPOCH_playerStamina,_fatigue,EPOCH_playerCrypto,round diag_fps,count playableUnits
		];
	}; 
};