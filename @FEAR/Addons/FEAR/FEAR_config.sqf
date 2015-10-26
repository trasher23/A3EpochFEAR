/*
  FEAR Configuration file
*/

if (!isDedicated) exitWith {};

private ["_center","_logic","_logicPos"];

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
// Zombie side
ZombieCentre = createCenter independent;

// Zombie logics
_center = createCenter sideLogic;
_logic = createGroup _center;
_logicPos = [1,1,1];
"Ryanzombieslogiceasy" createUnit[_logicPos,_logic];
"Ryanzombieslogicthrow25" createUnit[_logicPos,_logic];
"Ryanzombieslogicthrowtank25" createUnit[_logicPos,_logic];
"ryanzombiesjump" createUnit[_logicPos,_logic];
"Ryanzombieslogicroam" createUnit[_logicPos,_logic];
"ryanzombiesfeed" createUnit[_logicPos,_logic];
"ryanzombiescivilianattacks" createUnit[_logicPos,_logic];

// Max number of zombies on map
ZombieMax = 50; 

/*
VEMF mission radius gets sent to clients for increased zombie spawn
Needs array to store position for more than one mission
*/
FEARQuarantineLocs = [];
publicVariable "FEARQuarantineLocs"; // global used in clientLoop

/*
List of objects, used to delete if not near players
*/
FEARCleanup = [];

diag_log "[FEAR] configuration file loaded";

true // Config file run, return true