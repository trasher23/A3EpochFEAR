/*
	FEAR_ambient_fx.sqf
*/

getSoundFx = {
	private["_soundArray","_index","_sound"];
	
	_soundArray = ["wolfhowl1.ogg","eeriewind.ogg","girlscreaming.ogg","zombienoise1.ogg","childrenlaughing.ogg","babycry1.ogg"];

	// Pick a sound from array	
	_sound = _soundArray select floor random count _soundArray
	
	// Assign mission path
	_sound = MISSION_ROOT + "FEAR\fx\" + _sound;
	_sound;
};

playSoundFx = {
	private["_sound","_randomPos","_soundSource"];
	
	_sound = call getSoundFx;
	_randomPos = [getPos player,random 360,[100,400]] call SHK_pos;
	_soundSource = "Land_HelipadEmpty_F" createVehicle _randomPos;
	
	playSound3D [_sound, player, false, _soundSource];
};

private ["_timeDiff","_maxTime","_minTime"];

_minTime = 3; // minutes
_maxTime = 10; 

// Find the min and max time
_timeDiff = ((_maxTime*60) - (_minTime*60));
	
while {true} do {
	// Wait a Random Amount
	uiSleep ((floor(random(_timeDiff))) + (_minTime*60));

	// Not in a vehicle
	if (vehicle player == player) then { [] spawn playSoundFx; };
};
