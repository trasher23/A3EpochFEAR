/*
  FEAR Configuration file
*/
private "_zombieLogic";

diag_log "[FEAR] reading FEAR configuration file";

/* Assign map centre and radius to global for use in scripts
-------------------------------------------------------------
*/
MapCentre = getArray (configFile >> "CfgWorlds" >> worldName >> "centerPosition");
MapRadius = 5700;

/* Nuke settings
--------------------------------------------------
*/
// The minimum time in seconds before a cruise missile launch.
NukeTimerMin = 30; // minutes
// Maximum time in seconds before a cruise missile launch.
NukeTimerMax = 90;
// Blast radius in km
NukeRadius = 500;
// Ground zero - total annihilation
GroundZero = (NukeRadius / 2);

/* Earthquake settings
--------------------------------------------------
*/
EqTimerMin = 5;
EqTimerMax = 30;

/* Zombie settings
--------------------------------------------------
*/
ZombieGroup = createGroup resistance;
_zombieLogic = ZombieGroup createUnit["LOGIC",[0,0,0],[],0,"NONE"];
_zombieLogic = ZombieGroup createUnit["Ryanzombieslogiceasy",[0,0,0],[],0,"NONE"]; // Zombie setting easy
_zombieLogic = ZombieGroup createUnit["Ryanzombieslogicthrow25",[0,0,0],[],0,"NONE"]; // Zombie throw cars 25 meters
_zombieLogic = ZombieGroup createUnit["Ryanzombieslogicthrowtank25",[0,0,0],[],0,"NONE"]; // Zombie throw tanks 25 meters
_zombieLogic = ZombieGroup createUnit["ryanzombiesjump",[0,0,0],[],0,"NONE"]; // Zombie jumping
_zombieLogic = ZombieGroup createUnit["Ryanzombieslogicroam",[0,0,0],[],0,"NONE"]; // Zombie roam
_zombieLogic = ZombieGroup createUnit["ryanzombiesfeed",[0,0,0],[],0,"NONE"]; // Zombie feed
_zombieLogic = ZombieGroup createUnit["ryanzombiescivilianattacks",[0,0,0],[],0,"NONE"]; // Zombie civilian attack

ZombieMax = 50; // Max number of zombies on map
ZombieTotal = 0; // Zombie counter

diag_log "[FEAR] configuration file loaded";

/*
VEMF mission radius gets sent to clients for increased zombie spawn
Needs array to store position for more than one mission
*/
FEARQuarantineLocs = [];
publicVariable "FEARQuarantineLocs";

true // Config file run, return true