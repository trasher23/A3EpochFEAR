private["_zombiePos"];
_zombiePos = _this select 0;
diag_log format ["[FEAR] zombies triggered at %1", _zombiePos];
ZombieLogic = ZombieGroup createUnit["Ryanzombieslogicspawnmixed", _zombiePos, [], 0, "NONE"];
// Settings
ZombieLogic setVariable ["ryanzombiesstart", 5];
ZombieLogic setVariable ["ryanzombiesdelay", 0.5];
ZombieLogic setVariable ["ryanzombiescurrentamount", 0];
ZombieLogic setVariable ["ryanzombiestotalamount", 20];
ZombieLogic setVariable ["ryanzombiesamount", 10];
ZombieLogic setVariable ["ryanzombiesfrequency", 60];
ZombieLogic setVariable ["ryanzombiesactivation", 0.9];
ZombieLogic setVariable ["ryanzombieshordesize", 10];