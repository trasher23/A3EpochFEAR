/*
	FEAR_ambient_fx.sqf
*/

getSoundFx = {
	private["_soundArray","_sound"];
	
	_soundArray = [
		"wolfhowl1.ogg",
		"eeriewind.ogg",
		"girlscreaming.ogg",
		"babycry1.ogg"
	];

	// Pick a sound from array	
	_sound = _soundArray call BIS_fnc_selectRandom;
	//_sound = "wolfhowl1.ogg";
	
	// Log to RPT
	[format["playing soundfx: %1",_sound]] call FEARserverLog;
	
	// Assign mission path
	_sound = MISSION_directory + "FEAR\fx\" + _sound;
	_sound
};

playSoundFx = {
	private["_sound","_randomPos","_soundSource"];
	
	_sound = call getSoundFx;
	
	// Get random position between 25 & 150m, around player in 360 degrees for sound source
	[[player,position player,25,150]] call FEARgetRandomPosition;
	waitUntil {!(isNil "RandomPosition")};
	_randomPos = RandomPosition;
	
	_soundSource = "Land_HelipadEmpty_F" createVehicle _randomPos;
	
	// Spawn wolfpack if wolfhowl.ogg
	if (_sound == MISSION_directory + "FEAR\fx\wolfhowl1.ogg") then { [_randomPos] spawn FEARspawnWolfpack; };
	
	playSound3D [_sound,player,false,_soundSource,2];
};

private ["_timeDiff","_maxTime","_minTime"];

_minTime = 3; // minutes
_maxTime = 15; 

// Find the min and max time
_timeDiff = ((_maxTime*60) - (_minTime*60));
	
while {true} do {
	// Wait a Random Amount
	uiSleep ((floor(random(_timeDiff))) + (_minTime*60));

	// Not in a vehicle
	if (vehicle player == player) then {[] spawn playSoundFx};
};