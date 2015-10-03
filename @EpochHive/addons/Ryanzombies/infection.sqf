_target = _this select 0
_zombie = _this select 1

if !(isServer) then {goto "end"}
if (isnil "Ryanzombiesinfection") then {goto "end"}

~0.1

_uniform = uniform _target
_backpack = backpack _target
_vest = vest _target
_headgear = headgear _target
_dir = getdir _target
_pos = position _target
_sidetarget = side group _target
_side = side group _zombie

if (side group _zombie == CIVILIAN) then {goto "end"}
~Ryanzombiesinfectiontimer
if (ryanzombiesinfection == 0.9) then {goto "fast"}
if (ryanzombiesinfection == 0.7) then {goto "medium"}
if (ryanzombiesinfection == 0.5) then {goto "slow"}
if (ryanzombiesinfection == 0.3) then {goto "demon"}
if (ryanzombiesinfection == 0.1) then {goto "spider"}
goto "end"

#fast
if (_sidetarget == WEST) then {_grp = creategroup _side; "RyanZombieB_Soldier_BluforResurrect" createunit [_pos, _grp, "this addbackpack _backpack; this addvest _vest; this addheadgear _headgear; this switchmove 'AmovPpneMstpSnonWnonDnon'; this playmove 'AmovPercMstpSnonWnonDnon'; this setdir _dir; [this, _uniform] exec '\ryanzombies\infectionuniform.sqf'"]; deletevehicle _target; goto "end"}
if (_sidetarget == EAST) then {_grp = creategroup _side; "RyanZombieB_Soldier_OpforResurrect" createunit [_pos, _grp, "this addbackpack _backpack; this addvest _vest; this addheadgear _headgear; this switchmove 'AmovPpneMstpSnonWnonDnon'; this playmove 'AmovPercMstpSnonWnonDnon'; this setdir _dir; [this, _uniform] exec '\ryanzombies\infectionuniform.sqf'"]; deletevehicle _target; goto "end"}
if (_sidetarget == RESISTANCE) then {_grp = creategroup _side; "RyanZombieB_Soldier_IndepResurrect" createunit [_pos, _grp, "this addbackpack _backpack; this addvest _vest; this addheadgear _headgear; this switchmove 'AmovPpneMstpSnonWnonDnon'; this playmove 'AmovPercMstpSnonWnonDnon'; this setdir _dir; [this, _uniform] exec '\ryanzombies\infectionuniform.sqf'"]; deletevehicle _target; goto "end"}
goto "end"

#medium
if (_sidetarget == WEST) then {_grp = creategroup _side; "RyanZombieB_Soldier_BluforResurrectmedium" createunit [_pos, _grp, "this addbackpack _backpack; this addvest _vest; this addheadgear _headgear; this switchmove 'AmovPpneMstpSnonWnonDnon'; this playmove 'AmovPercMstpSnonWnonDnon'; this setdir _dir; [this, _uniform] exec '\ryanzombies\infectionuniform.sqf'"]; deletevehicle _target; goto "end"}
if (_sidetarget == EAST) then {_grp = creategroup _side; "RyanZombieB_Soldier_OpforResurrectmedium" createunit [_pos, _grp, "this addbackpack _backpack; this addvest _vest; this addheadgear _headgear; this switchmove 'AmovPpneMstpSnonWnonDnon'; this playmove 'AmovPercMstpSnonWnonDnon'; this setdir _dir; [this, _uniform] exec '\ryanzombies\infectionuniform.sqf'"]; deletevehicle _target; goto "end"}
if (_sidetarget == RESISTANCE) then {_grp = creategroup _side; "RyanZombieB_Soldier_IndepResurrectmedium" createunit [_pos, _grp, "this addbackpack _backpack; this addvest _vest; this addheadgear _headgear; this switchmove 'AmovPpneMstpSnonWnonDnon'; this playmove 'AmovPercMstpSnonWnonDnon'; this setdir _dir; [this, _uniform] exec '\ryanzombies\infectionuniform.sqf'"]; deletevehicle _target; goto "end"}
goto "end"

#slow
if (_sidetarget == WEST) then {_grp = creategroup _side; "RyanZombieB_Soldier_BluforResurrectslow" createunit [_pos, _grp, "this addbackpack _backpack; this addvest _vest; this addheadgear _headgear; this switchmove 'AmovPpneMstpSnonWnonDnon'; this playmove 'AmovPercMstpSnonWnonDnon'; this setdir _dir; [this, _uniform] exec '\ryanzombies\infectionuniform.sqf'"]; deletevehicle _target; goto "end"}
if (_sidetarget == EAST) then {_grp = creategroup _side; "RyanZombieB_Soldier_OpforResurrectslow" createunit [_pos, _grp, "this addbackpack _backpack; this addvest _vest; this addheadgear _headgear; this switchmove 'AmovPpneMstpSnonWnonDnon'; this playmove 'AmovPercMstpSnonWnonDnon'; this setdir _dir; [this, _uniform] exec '\ryanzombies\infectionuniform.sqf'"]; deletevehicle _target; goto "end"}
if (_sidetarget == RESISTANCE) then {_grp = creategroup _side; "RyanZombieB_Soldier_IndepResurrectslow" createunit [_pos, _grp, "this addbackpack _backpack; this addvest _vest; this addheadgear _headgear; this switchmove 'AmovPpneMstpSnonWnonDnon'; this playmove 'AmovPercMstpSnonWnonDnon'; this setdir _dir; [this, _uniform] exec '\ryanzombies\infectionuniform.sqf'"]; deletevehicle _target; goto "end"}
goto "end"

#demon
_array = ["RyanZombieboss1", "RyanZombieboss2", "RyanZombieboss3", "RyanZombieboss4", "RyanZombieboss5", "RyanZombieboss6", "RyanZombieboss7", "RyanZombieboss8", "RyanZombieboss9", "RyanZombieboss10", "RyanZombieboss11", "RyanZombieboss12", "RyanZombieboss13", "RyanZombieboss14"]
_random = _array select floor random count _array
if (_sidetarget == WEST) then {_grp = creategroup _side; format ["%1",_random] createunit [_pos, _grp, "this switchmove 'AmovPpneMstpSnonWnonDnon'; this playmove 'AmovPercMstpSnonWnonDnon'; this setdir _dir"]; deletevehicle _target; goto "end"}
if (_sidetarget == EAST) then {_grp = creategroup _side; format ["%1",_random] createunit [_pos, _grp, "this switchmove 'AmovPpneMstpSnonWnonDnon'; this playmove 'AmovPercMstpSnonWnonDnon'; this setdir _dir"]; deletevehicle _target; goto "end"}
if (_sidetarget == RESISTANCE) then {_grp = creategroup _side; format ["%1",_random] createunit [_pos, _grp, "this switchmove 'AmovPpneMstpSnonWnonDnon'; this playmove 'AmovPercMstpSnonWnonDnon'; this setdir _dir"]; deletevehicle _target; goto "end"}
goto "end"

#spider
if (_sidetarget == WEST) then {_grp = creategroup _side; "RyanZombieB_Soldier_BluforResurrectSpider" createunit [_pos, _grp, "this addbackpack _backpack; this addvest _vest; this addheadgear _headgear; this setdir _dir; [this, _uniform] exec '\ryanzombies\infectionuniform.sqf'"]; deletevehicle _target; goto "end"}
if (_sidetarget == EAST) then {_grp = creategroup _side; "RyanZombieB_Soldier_OpforResurrectSpider" createunit [_pos, _grp, "this addbackpack _backpack; this addvest _vest; this addheadgear _headgear; this setdir _dir; [this, _uniform] exec '\ryanzombies\infectionuniform.sqf'"]; deletevehicle _target; goto "end"}
if (_sidetarget == RESISTANCE) then {_grp = creategroup _side; "RyanZombieB_Soldier_IndepResurrectSpider" createunit [_pos, _grp, "this addbackpack _backpack; this addvest _vest; this addheadgear _headgear; this setdir _dir; [this, _uniform] exec '\ryanzombies\infectionuniform.sqf'"]; deletevehicle _target; goto "end"}
goto "end"

#end