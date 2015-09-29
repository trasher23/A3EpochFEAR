private["_zombiePos","_zombieSpawn"];

_zombiePos = _this select 0;
diag_log format ["[FEAR] zombies triggered at %1", _zombiePos];
_zombieSpawn = ZombieGroup createUnit["Ryanzombieslogicspawnmixed", _zombiePos, [], 0, "NONE"];