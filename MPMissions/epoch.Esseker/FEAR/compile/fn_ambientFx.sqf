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
	_sound = _soundArray select(floor(random(count _soundArray)));
	//_sound = "wolfhowl1.ogg";
	
	// Log to RPT
	[format["%1 playing soundfx: %2",name player,_sound]] call FEARserverLog;
	
	// Assign mission path
	_sound = MISSION_directory + "FEAR\fx\" + _sound;
	_sound
};

playSoundFx = {
	private["_sound","_pos","_soundSource"];
	
	_sound = call getSoundFx;
	
	// Get random position between 25 & 150m, around player in 360 degrees for sound source
	_pos = [player,[25,150],random 360] call SHK_pos;
	_soundSource = "Land_HelipadEmpty_F" createVehicle _pos;
	
	// Spawn wolfpack if wolfhowl.ogg
	if (_sound == MISSION_directory + "FEAR\fx\wolfhowl1.ogg") then { [_pos] spawn FEARspawnWolfpack; };
	
	playSound3D [_sound,player,false,_soundSource,2];
};

if (hasInterface) then
{
	[] spawn {
		private ["_timeDiff"];

		// Find the min and max time
		_timeDiff = ((15*60) - (3*60)); // _maxTime = 15 _minTime = 3
			
		while {true} do {
			// Wait a Random Amount
			uiSleep ((floor(random(_timeDiff))) + (3*60)); // _minTime = 3

			// player on foot
			if (isNull objectParent player) then {[] spawn playSoundFx};
		};
	};
};