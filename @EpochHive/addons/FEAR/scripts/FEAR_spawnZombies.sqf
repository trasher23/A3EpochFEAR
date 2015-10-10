private["_arr","_zombiePos","_zombieHordeSize","_zombieCount","_zombieClass","_zombieType","_zombie","_zBags","_zLoots","_zBag","_zLoot"];

_arr = _this;
_zombiePos = _arr select 0;
_zombieHordeSize = _arr select 1;
_zombieCount = 0;

_zombieClass = ["RyanZombieC_man_polo_2_Fslow","RyanZombieC_man_polo_4_Fslow","RyanZombieC_man_polo_5_Fslow","RyanZombieC_man_polo_6_Fslow","RyanZombieC_man_p_fugitive_Fslow","RyanZombieC_man_w_worker_Fslow","RyanZombieC_scientist_Fslow","RyanZombieC_man_hunter_1_Fslow","RyanZombieC_man_pilot_Fslow","RyanZombieC_journalist_Fslow","RyanZombieC_Orestesslow","RyanZombieC_Nikosslow","RyanZombieB_Soldier_02_fslow","RyanZombieB_Soldier_02_f_1slow","RyanZombieB_Soldier_02_f_1_1slow","RyanZombieB_Soldier_03_fslow","RyanZombieB_Soldier_03_f_1slow","RyanZombieB_Soldier_03_f_1_1slow","RyanZombieB_Soldier_04_fslow","RyanZombieB_Soldier_04_f_1slow","RyanZombieB_Soldier_04_f_1_1slow","RyanZombieB_Soldier_lite_Fslow","RyanZombieB_Soldier_lite_F_1slow","RyanZombieB_RangeMaster_Fmedium","RyanZombieSpider1"];

// Zombie Loot settings - used from Captainjack's Exile ZOM script: http://www.exilemod.com/topic/191-exile-z-project-add-zombies-to-exile/
_zBags = ["V_TacVest_blk_POLICE","V_Rangemaster_belt","V_BandollierB_khk"];
// Ammo loot on zombies, you'll need it!
_zLoots = [
		   "30Rnd_556x45_Stanag_Tracer_Red",
		   "30Rnd_65x39_caseless_mag_Tracer",
		   "30Rnd_556x45_Stanag_Tracer_Yellow",
		   "16Rnd_9x21_Mag",
		   "20Rnd_556x45_UW_mag",
		   "20Rnd_762x51_Mag",
		   "30Rnd_45ACP_Mag_SMG_01",
		   "30Rnd_556x45_Stanag",
		   "30Rnd_9x21_Mag",
		   "9Rnd_45ACP_Mag",
		   "16Rnd_9x21_Mag",
		   "1Rnd_HE_Grenade_shell",
		   "20Rnd_556x45_UW_mag",
		   "20Rnd_762x51_Mag",
		   "30Rnd_45ACP_Mag_SMG_01",
		   "30Rnd_556x45_Stanag",
		   "30Rnd_556x45_Stanag_Tracer_Green",
		   "30Rnd_556x45_Stanag_Tracer_Red",
		   "30Rnd_556x45_Stanag_Tracer_Yellow",
		   "30Rnd_65x39_caseless_green",
		   "30Rnd_65x39_caseless_green_mag_Tracer",
		   "30Rnd_65x39_caseless_mag",
		   "30Rnd_65x39_caseless_mag_Tracer",
		   "30Rnd_9x21_Mag",
		   "3Rnd_HE_Grenade_shell",
		   "5Rnd_127x108_Mag",
		   "7Rnd_408_Mag",
		   "9Rnd_45ACP_Mag",
		   "20Rnd_556x45_UW_mag",
		   "30Rnd_45ACP_Mag_SMG_01",
		   "30Rnd_556x45_Stanag",
		   "30Rnd_556x45_Stanag_Tracer_Green",
		   "30Rnd_556x45_Stanag_Tracer_Red",
		   "30Rnd_556x45_Stanag_Tracer_Yellow",
		   "30Rnd_65x39_caseless_green",
		   "30Rnd_65x39_caseless_green_mag_Tracr",
		   "30Rnd_65x39_caseless_mag",
		   "30Rnd_65x39_caseless_mag_Tracer",
		   "30Rnd_9x21_Mag",
		   "wolf_mask_epoch",
		   "pkin_mask_epoch"
];

_zBag = _zBags select(floor(random(count _zBags)));
_zLoot = _zLoots select(floor(random(count _zLoots)));

if ((isNil "_zombieHordeSize") || (_zombieHordeSize == 0)) then{_zombieHordeSize = 1};

// Assign _zombieHordeSize if total is larger than ZombieMax
if ((ZombieTotal + _zombieHordeSize) > ZombieMax) then{
	_zombieHordeSize = (ZombieMax - ZombieTotal);
	diag_log "[FEAR] reached ZombieMax";
};

for "_x" from 1 to _zombieHordeSize do{
	
	// Create zombie unit
	_zombieType = _zombieClass select(floor(random(count _zombieClass)));
	_zombie = ZombieGroup createUnit[_zombieType,_zombiePos,[],0,"NONE"];
	
	// Add loot
	_zombie addVest _zBag; 
	_zombie addItemToVest _zLoot; 
	if (20 > random 100) then {_zombie addItemToVest "FAK"}; // 20% chance of First Aid Kit
	
	//_zombie disableAI "FSM";
	//_zombie disableAI "AUTOTARGET";
	//_zombie disableAI "TARGET";
	//_zombie setBehaviour "CARELESS";
	//_zombie disableConversation true;
	//_zombie addRating -10000;
	//_zombie setCaptive false;
				
	// Add event handler for zombie death
	_zombie addMPEventHandler["mpkilled","if(isDedicated)then{[_this select 0,_this select 1] spawn FEARZombieKilled}"];
	_zombie setVariable["LAST_CHECK", (diag_tickTime + 600)]; // Epoch Server_Monitor, delete after 600s if no players near
	
	_zombieCount = _zombieCount + 1;
};
// Increment global zombie counter
ZombieTotal = ZombieTotal + _zombieCount;
publicVariableServer "ZombieTotal";

diag_log format["[FEAR] %1 zombie(s) spawned at %2. Total zombies: %3",_zombieCount,_zombiePos,ZombieTotal];