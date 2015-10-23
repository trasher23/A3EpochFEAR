/*
	FEAR functions
*/
diag_log "[FEAR] compiling functions";

/* Server Functions
----------------------------------------------
*/
FEARGetPlayers = compileFinal preprocessFileLineNumbers format["%1\scripts\FEAR_getPlayers.sqf",FEAR_directory];
FEARBroadcast = compileFinal preprocessFileLineNumbers format["%1\scripts\FEAR_broadcast.sqf",FEAR_directory];
FEARZombieKilled = compileFinal preprocessFileLineNumbers format["%1\scripts\FEAR_zombieKilled.sqf",FEAR_directory];
FEARQuarantineZone = compileFinal preprocessFileLineNumbers format["%1\scripts\FEAR_quarantineZone.sqf",FEAR_directory];
FEARWolfKilled = compileFinal preprocessFileLineNumbers format["%1\scripts\FEAR_wolfKilled.sqf",FEAR_directory];

/* Client to Server event handlers
-----------------------------------------------
*/
// Client to Server logging
FEARserverLog = compileFinal preprocessFileLineNumbers format["%1\scripts\FEAR_serverLog.sqf",FEAR_directory];
"ServerLog" addPublicVariableEventHandler {_id = (_this select 1) spawn FEARserverLog};

// Spawn wolfpack
FEARspawnWolfpack = compileFinal preprocessFileLineNumbers format["%1\scripts\FEAR_spawnWolfpack.sqf",FEAR_directory];
"SpawnWolfpack" addPublicVariableEventHandler {_id = (_this select 1) spawn FEARspawnWolfpack};

// Spawn exploding barrel
FEARspawnExplodingBarrel = compileFinal preprocessFileLineNumbers format["%1\scripts\FEAR_spawnExplodingBarrel.sqf",FEAR_directory];
"SpawnExplodingBarrel" addPublicVariableEventHandler {_id = (_this select 1) spawn FEARspawnExplodingBarrel};

// Spawn zombies
FEARspawnZombies = compileFinal preprocessFileLineNumbers format["%1\scripts\FEAR_spawnZombies.sqf",FEAR_directory];
"SpawnZombies" addPublicVariableEventHandler {_id = (_this select 1) spawn FEARspawnZombies};

diag_log "[FEAR] functions compiled";

true