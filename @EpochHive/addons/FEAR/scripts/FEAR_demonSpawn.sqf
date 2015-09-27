/*
	Spawn demon
	Called from client FEAR_ambientFX.sqf
*/

private["_spawnPos","_demonPos","_demon"];

_spawnPos = _this; // Starting location for wolfpack
_demonPos = nil;

// Spawn demon	
diag_log format["[FEAR] spawning demon at %1",_spawnPos];
			
_demonPos = [_spawnPos,[5,10],random 360] call SHK_pos; // Random spawn position for each wolf	
_demon = ZombieGroup createUnit["RyanZombieSpider1", _demonPos, [], 0, "NONE"];