/*
	Spawn demon
	Called from client FEAR_ambientFX.sqf
*/

private["_spawnPos","_demonPos","_demon"];

_spawnPos = _this;

diag_log format["[FEAR] spawning demon at %1",_spawnPos];

// Spawn demon	
_demon = ZombieGroup createUnit["RyanZombieSpider1", _spawnPos, [], 0, "NONE"];