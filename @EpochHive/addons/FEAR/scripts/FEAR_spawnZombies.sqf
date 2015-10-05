private["_arr","_zombiePos","_zombieHordeSize","_zombieCount","_zombieClass","_zombieType","_zombie"];

_arr = _this;
_zombiePos = _arr select 0;
_zombieHordeSize = _arr select 1;
_zombieCount = 0;

_zombieClass = ["RyanZombieC_man_polo_2_Fslow","RyanZombieC_man_polo_4_Fslow","RyanZombieC_man_polo_5_Fslow","RyanZombieC_man_polo_6_Fslow","RyanZombieC_man_p_fugitive_Fslow","RyanZombieC_man_w_worker_Fslow","RyanZombieC_scientist_Fslow","RyanZombieC_man_hunter_1_Fslow","RyanZombieC_man_pilot_Fslow","RyanZombieC_journalist_Fslow","RyanZombieC_Orestesslow","RyanZombieC_Nikosslow","RyanZombieB_Soldier_02_fslow","RyanZombieB_Soldier_02_f_1slow","RyanZombieB_Soldier_02_f_1_1slow","RyanZombieB_Soldier_03_fslow","RyanZombieB_Soldier_03_f_1slow","RyanZombieB_Soldier_03_f_1_1slow","RyanZombieB_Soldier_04_fslow","RyanZombieB_Soldier_04_f_1slow","RyanZombieB_Soldier_04_f_1_1slow","RyanZombieB_Soldier_lite_Fslow","RyanZombieB_Soldier_lite_F_1slow","RyanZombieboss1","RyanZombieB_RangeMaster_Fmedium","RyanZombieSpider1"];

// Assign max horde size if total is larger than max
if ((ZombieTotal + _zombieHordeSize) > ZombieMax) then{
	_zombieHordeSize = (ZombieMax - ZombieTotal);
	diag_log "[FEAR] reached ZombieMax";
};

for "_x" from 1 to _zombieHordeSize do{
	
	// Create zombie unit
	_zombieType = _zombieClass call BIS_fnc_selectRandom;
	_zombie = ZombieGroup createUnit[_zombieType,_zombiePos,[],0,"NONE"];
	// Add event handler for zombie death
	_zombie addMPEventHandler ["mpkilled","if(isDedicated)then{[_this select 0,_this select 1] spawn FEARZombieKilled}"];
	
	_zombieCount = _zombieCount + 1;
};
// Increment global zombie counter
ZombieTotal = ZombieTotal + _zombieCount;
publicVariableServer "ZombieTotal";

diag_log format["[FEAR] %1 zombie(s) spawned at %2. Total zombies: %3",_zombieCount,_zombiePos,ZombieTotal];