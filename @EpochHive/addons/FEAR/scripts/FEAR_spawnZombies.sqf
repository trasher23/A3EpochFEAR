private["_zombiePos","_zombieSide","_zombieHordeSize","_zombieCount","_zombieClass","_zombieGroup","_zombieLogic","_zombieType","_center"];

_zombiePos = _this select 0;
_zombieSide = resistance;
_zombieHordeSize = 1 + random 20;
_zombieCount = 0;

_zombieClass = ["RyanZombieC_man_polo_2_Fslow","RyanZombieC_man_polo_4_Fslow","RyanZombieC_man_polo_5_Fslow","RyanZombieC_man_polo_6_Fslow","RyanZombieC_man_p_fugitive_Fslow","RyanZombieC_man_w_worker_Fslow","RyanZombieC_scientist_Fslow","RyanZombieC_man_hunter_1_Fslow","RyanZombieC_man_pilot_Fslow","RyanZombieC_journalist_Fslow","RyanZombieC_Orestesslow","RyanZombieC_Nikosslow","RyanZombieB_Soldier_02_fslow","RyanZombieB_Soldier_02_f_1slow","RyanZombieB_Soldier_02_f_1_1slow","RyanZombieB_Soldier_03_fslow","RyanZombieB_Soldier_03_f_1slow","RyanZombieB_Soldier_03_f_1_1slow","RyanZombieB_Soldier_04_fslow","RyanZombieB_Soldier_04_f_1slow","RyanZombieB_Soldier_04_f_1_1slow","RyanZombieB_Soldier_lite_Fslow","RyanZombieB_Soldier_lite_F_1slow","RyanZombieboss1","RyanZombieB_RangeMaster_Fmedium","RyanZombieSpider1"];

/* Create zombie logic
------------------------
*/
//_center = createCenter sideLogic;
_zombieGroup = createGroup _zombieSide; //_center;
_zombieLogic = _zombieGroup createUnit["LOGIC",[0,0,0],[],0,"NONE"];
_zombieLogic = _zombieGroup createUnit["Ryanzombieslogiceasy",[0,0,0],[],0,"NONE"]; // Zombie setting easy
_zombieLogic = _zombieGroup createUnit["Ryanzombieslogicthrow25",[0,0,0],[],0,"NONE"]; // Zombie throw cars 25 meters
_zombieLogic = _zombieGroup createUnit["Ryanzombieslogicthrowtank25",[0,0,0],[],0,"NONE"]; // Zombie throw tanks 25 meters
_zombieLogic = _zombieGroup createUnit["ryanzombiesjump",[0,0,0],[],0,"NONE"]; // Zombie jumping
_zombieLogic = _zombieGroup createUnit["Ryanzombieslogicroam",[0,0,0],[],0,"NONE"]; // Zombie roam
_zombieLogic = _zombieGroup createUnit["Ryanzombieslogicdelete",[0,0,0],[],0,"NONE"]; // Zombie delete dead bodies
_zombieLogic = _zombieGroup createUnit["Ryanzombieslimit",[0,0,0],[],0,"NONE"]; // Limit zombies

for "_x" from 1 to _zombieHordeSize do{
	_zombieType = _zombieClass call BIS_fnc_selectRandom;
	_zombieLogic = _zombieGroup createUnit[_zombieType,_zombiePos,[],0,"NONE"];
	
	EPOCH_TEMPOBJ_PVS = _zombieLogic;
	publicVariableServer "EPOCH_TEMPOBJ_PVS";

	_zombieCount = _zombieCount + 1;
};

diag_log format["[FEAR] %1 zombies triggered at %2",_zombieCount,_zombiePos];