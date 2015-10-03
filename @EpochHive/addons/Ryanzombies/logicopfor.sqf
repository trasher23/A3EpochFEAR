_logic = _this select 0

~0.1

if !(isServer) then {goto "end"}

goto format["%1", typeof _logic]

#activationblufor
~3
_trg = createTrigger ["EmptyDetector", getpos _logic]
_trg setTriggerArea [ryanzombiesactivationradius, ryanzombiesactivationradius, 0, false]
_trg setTriggerActivation ["WEST", "PRESENT", false]
~3 + random 3
if (triggeractivated _trg) then {deletevehicle _trg; goto format["%1next", typeof _logic]}
deletevehicle _trg
goto "activationblufor"

#activationopfor
~3
_trg = createTrigger ["EmptyDetector", getpos _logic]
_trg setTriggerArea [ryanzombiesactivationradius, ryanzombiesactivationradius, 0, false]
_trg setTriggerActivation ["EAST", "PRESENT", false]
~3 + random 3
if (triggeractivated _trg) then {deletevehicle _trg; goto format["%1next", typeof _logic]}
deletevehicle _trg
goto "activationopfor"

#activationindep
~3
_trg = createTrigger ["EmptyDetector", getpos _logic]
_trg setTriggerArea [ryanzombiesactivationradius, ryanzombiesactivationradius, 0, false]
_trg setTriggerActivation ["GUER", "PRESENT", false]
~3 + random 3
if (triggeractivated _trg) then {deletevehicle _trg; goto format["%1next", typeof _logic]}
deletevehicle _trg
goto "activationindep"

#activationblufordemon
~3
_trg = createTrigger ["EmptyDetector", getpos _logic]
_trg setTriggerArea [ryanzombiesactivationradiusdemon, ryanzombiesactivationradiusdemon, 0, false]
_trg setTriggerActivation ["WEST", "PRESENT", false]
~3 + random 3
if (triggeractivated _trg) then {deletevehicle _trg; goto format["%1next", typeof _logic]}
deletevehicle _trg
goto "activationblufordemon"

#activationopfordemon
~3
_trg = createTrigger ["EmptyDetector", getpos _logic]
_trg setTriggerArea [ryanzombiesactivationradiusdemon, ryanzombiesactivationradiusdemon, 0, false]
_trg setTriggerActivation ["EAST", "PRESENT", false]
~3 + random 3
if (triggeractivated _trg) then {deletevehicle _trg; goto format["%1next", typeof _logic]}
deletevehicle _trg
goto "activationopfordemon"

#activationindepdemon
~3
_trg = createTrigger ["EmptyDetector", getpos _logic]
_trg setTriggerArea [ryanzombiesactivationradiusdemon, ryanzombiesactivationradiusdemon, 0, false]
_trg setTriggerActivation ["GUER", "PRESENT", false]
~3 + random 3
if (triggeractivated _trg) then {deletevehicle _trg; goto format["%1next", typeof _logic]}
deletevehicle _trg
goto "activationindepdemon"



#Ryanzombieslogicspawnfast1opfor
~0.5 + random 1
if (isnil "ryanzombiesstart") then {ryanzombiesstart = 5}
if (isnil "ryanzombiesdelay") then {ryanzombiesdelay = 0.5}
if (isnil "ryanzombiescurrentamount") then {ryanzombiescurrentamount = 0}
if (isnil "ryanzombiestotalamount") then {ryanzombiestotalamount = 10000}
if (isnil "ryanzombiesamount") then {ryanzombiesamount = 100}
if (isnil "ryanzombiesfrequency") then {ryanzombiesfrequency = 60}
if (isnil "ryanzombiesactivation") then {ryanzombiesactivation = 0.9}
if (isnil "ryanzombieshordesize") then {ryanzombieshordesize = 14}
_array = ["RyanZombieC_man_1", "RyanZombieC_man_polo_1_F", "RyanZombieC_man_polo_2_F", "RyanZombieC_man_polo_4_F", "RyanZombieC_man_polo_5_F", "RyanZombieC_man_polo_6_F", "RyanZombieC_man_p_fugitive_F", "RyanZombieC_man_w_worker_F", "RyanZombieC_scientist_F", "RyanZombieC_man_hunter_1_F", "RyanZombieC_man_pilot_F", "RyanZombieC_journalist_F", "RyanZombieC_Orestes", "RyanZombieC_Nikos"]
~ryanzombiesstart

#Ryanzombieslogicspawnfast1opforloop
if (ryanzombiesactivation == 0.7) then {goto "activationblufor"}
if (ryanzombiesactivation == 0.5) then {goto "activationopfor"}
if (ryanzombiesactivation == 0.3) then {goto "activationindep"}

#Ryanzombieslogicspawnfast1opfornext
_grp = creategroup east
_x = 0
~1
if (isnull _grp) then {goto "Ryanzombieslogicspawnfast1opforloop"}

#Ryanzombieslogicspawnfast1opfornextloop
_x = _x + 1
_random = _array select floor random count _array
if (ryanzombiescurrentamount > ryanzombiestotalamount) then {goto "end"}
if (ryanzombiescurrentamount < ryanzombiesamount) then {format ["%1",_random] createunit [position _logic, _grp, "this switchmove 'AmovPercMstpSnonWnonDnon_SaluteOut'; [this] exec '\ryanzombies\count.sqf'"]}
if (ryanzombiescurrentamount < ryanzombiesamount) then {ryanzombiescurrentamount = ryanzombiescurrentamount + 1}
~ryanzombiesdelay
if (_x < ryanzombieshordesize) then {goto "Ryanzombieslogicspawnfast1opfornextloop"}
deletegroup _grp
~ryanzombiesfrequency
goto "Ryanzombieslogicspawnfast1opforloop"



#Ryanzombieslogicspawnfast2opfor
~0.5 + random 1
if (isnil "ryanzombiesstart") then {ryanzombiesstart = 5}
if (isnil "ryanzombiesdelay") then {ryanzombiesdelay = 0.5}
if (isnil "ryanzombiescurrentamount") then {ryanzombiescurrentamount = 0}
if (isnil "ryanzombiestotalamount") then {ryanzombiestotalamount = 10000}
if (isnil "ryanzombiesamount") then {ryanzombiesamount = 100}
if (isnil "ryanzombiesfrequency") then {ryanzombiesfrequency = 60}
if (isnil "ryanzombiesactivation") then {ryanzombiesactivation = 0.9}
if (isnil "ryanzombieshordesize") then {ryanzombieshordesize = 14}
_array = ["RyanZombieB_Soldier_02_f", "RyanZombieB_Soldier_02_f_1", "RyanZombieB_Soldier_02_f_1_1", "RyanZombieB_Soldier_03_f", "RyanZombieB_Soldier_03_f_1", "RyanZombieB_Soldier_03_f_1_1", "RyanZombieB_Soldier_04_f", "RyanZombieB_Soldier_04_f_1", "RyanZombieB_Soldier_04_f_1_1", "RyanZombieB_Soldier_lite_F", "RyanZombieB_Soldier_lite_F_1"]
~ryanzombiesstart

#Ryanzombieslogicspawnfast2opforloop
if (ryanzombiesactivation == 0.7) then {goto "activationblufor"}
if (ryanzombiesactivation == 0.5) then {goto "activationopfor"}
if (ryanzombiesactivation == 0.3) then {goto "activationindep"}

#Ryanzombieslogicspawnfast2opfornext
_grp = creategroup east
_x = 0
~1
if (isnull _grp) then {goto "Ryanzombieslogicspawnfast2opfornextloop"}

#Ryanzombieslogicspawnfast2opfornextloop
_x = _x + 1
_random = _array select floor random count _array
if (ryanzombiescurrentamount > ryanzombiestotalamount) then {goto "end"}
if (ryanzombiescurrentamount < ryanzombiesamount) then {format ["%1",_random] createunit [position _logic, _grp, "this switchmove 'AmovPercMstpSnonWnonDnon_SaluteOut'; [this] exec '\ryanzombies\count.sqf'"]}
if (ryanzombiescurrentamount < ryanzombiesamount) then {ryanzombiescurrentamount = ryanzombiescurrentamount + 1}
~ryanzombiesdelay
if (_x < ryanzombieshordesize) then {goto "Ryanzombieslogicspawnfast2opfornextloop"}
deletegroup _grp
~ryanzombiesfrequency
goto "Ryanzombieslogicspawnfast2opforloop"



#Ryanzombieslogicspawnfast3opfor
~0.5 + random 1
if (isnil "ryanzombiesstart") then {ryanzombiesstart = 5}
if (isnil "ryanzombiesdelay") then {ryanzombiesdelay = 0.5}
if (isnil "ryanzombiescurrentamount") then {ryanzombiescurrentamount = 0}
if (isnil "ryanzombiestotalamount") then {ryanzombiestotalamount = 10000}
if (isnil "ryanzombiesamount") then {ryanzombiesamount = 100}
if (isnil "ryanzombiesfrequency") then {ryanzombiesfrequency = 60}
if (isnil "ryanzombiesactivation") then {ryanzombiesactivation = 0.9}
if (isnil "ryanzombieshordesize") then {ryanzombieshordesize = 14}
_array = ["RyanZombieC_man_1", "RyanZombieC_man_polo_1_F", "RyanZombieC_man_polo_2_F", "RyanZombieC_man_polo_4_F", "RyanZombieC_man_polo_5_F", "RyanZombieC_man_polo_6_F", "RyanZombieC_man_p_fugitive_F", "RyanZombieC_man_w_worker_F", "RyanZombieC_scientist_F", "RyanZombieC_man_hunter_1_F", "RyanZombieC_man_pilot_F", "RyanZombieC_journalist_F", "RyanZombieC_Orestes", "RyanZombieC_Nikos", "RyanZombieB_Soldier_02_f", "RyanZombieB_Soldier_02_f_1", "RyanZombieB_Soldier_02_f_1_1", "RyanZombieB_Soldier_03_f", "RyanZombieB_Soldier_03_f_1", "RyanZombieB_Soldier_03_f_1_1", "RyanZombieB_Soldier_04_f", "RyanZombieB_Soldier_04_f_1", "RyanZombieB_Soldier_04_f_1_1", "RyanZombieB_Soldier_lite_F", "RyanZombieB_Soldier_lite_F_1"]
~ryanzombiesstart

#Ryanzombieslogicspawnfast3opforloop
if (ryanzombiesactivation == 0.7) then {goto "activationblufor"}
if (ryanzombiesactivation == 0.5) then {goto "activationopfor"}
if (ryanzombiesactivation == 0.3) then {goto "activationindep"}

#Ryanzombieslogicspawnfast3opfornext
_grp = creategroup east
_x = 0
~1
if (isnull _grp) then {goto "Ryanzombieslogicspawnfast3opfornextloop"}

#Ryanzombieslogicspawnfast3opfornextloop
_x = _x + 1
_random = _array select floor random count _array
if (ryanzombiescurrentamount > ryanzombiestotalamount) then {goto "end"}
if (ryanzombiescurrentamount < ryanzombiesamount) then {format ["%1",_random] createunit [position _logic, _grp, "this switchmove 'AmovPercMstpSnonWnonDnon_SaluteOut'; [this] exec '\ryanzombies\count.sqf'"]}
if (ryanzombiescurrentamount < ryanzombiesamount) then {ryanzombiescurrentamount = ryanzombiescurrentamount + 1}
~ryanzombiesdelay
if (_x < ryanzombieshordesize) then {goto "Ryanzombieslogicspawnfast3opfornextloop"}
deletegroup _grp
~ryanzombiesfrequency
goto "Ryanzombieslogicspawnfast3opforloop"



#Ryanzombieslogicspawnmedium1opfor
~0.5 + random 1
if (isnil "ryanzombiesstart") then {ryanzombiesstart = 5}
if (isnil "ryanzombiesdelay") then {ryanzombiesdelay = 0.5}
if (isnil "ryanzombiescurrentamount") then {ryanzombiescurrentamount = 0}
if (isnil "ryanzombiestotalamount") then {ryanzombiestotalamount = 10000}
if (isnil "ryanzombiesamount") then {ryanzombiesamount = 100}
if (isnil "ryanzombiesfrequency") then {ryanzombiesfrequency = 60}
if (isnil "ryanzombiesactivation") then {ryanzombiesactivation = 0.9}
if (isnil "ryanzombieshordesize") then {ryanzombieshordesize = 14}
_array = ["RyanZombieC_man_1medium", "RyanZombieC_man_polo_1_Fmedium", "RyanZombieC_man_polo_2_Fmedium", "RyanZombieC_man_polo_4_Fmedium", "RyanZombieC_man_polo_5_Fmedium", "RyanZombieC_man_polo_6_Fmedium", "RyanZombieC_man_p_fugitive_Fmedium", "RyanZombieC_man_w_worker_Fmedium", "RyanZombieC_scientist_Fmedium", "RyanZombieC_man_hunter_1_Fmedium", "RyanZombieC_man_pilot_Fmedium", "RyanZombieC_journalist_Fmedium", "RyanZombieC_Orestesmedium", "RyanZombieC_Nikosmedium"]
~ryanzombiesstart

#Ryanzombieslogicspawnmedium1opforloop
if (ryanzombiesactivation == 0.7) then {goto "activationblufor"}
if (ryanzombiesactivation == 0.5) then {goto "activationopfor"}
if (ryanzombiesactivation == 0.3) then {goto "activationindep"}

#Ryanzombieslogicspawnmedium1opfornext
_grp = creategroup east
_x = 0
~1
if (isnull _grp) then {goto "Ryanzombieslogicspawnmedium1opforloop"}

#Ryanzombieslogicspawnmedium1opfornextloop
_x = _x + 1
_random = _array select floor random count _array
if (ryanzombiescurrentamount > ryanzombiestotalamount) then {goto "end"}
if (ryanzombiescurrentamount < ryanzombiesamount) then {format ["%1",_random] createunit [position _logic, _grp, "this switchmove 'AmovPercMstpSnonWnonDnon_SaluteOut'; [this] exec '\ryanzombies\count.sqf'"]}
if (ryanzombiescurrentamount < ryanzombiesamount) then {ryanzombiescurrentamount = ryanzombiescurrentamount + 1}
~ryanzombiesdelay
if (_x < ryanzombieshordesize) then {goto "Ryanzombieslogicspawnmedium1opfornextloop"}
deletegroup _grp
~ryanzombiesfrequency
goto "Ryanzombieslogicspawnmedium1opforloop"



#Ryanzombieslogicspawnmedium2opfor
~0.5 + random 1
if (isnil "ryanzombiesstart") then {ryanzombiesstart = 5}
if (isnil "ryanzombiesdelay") then {ryanzombiesdelay = 0.5}
if (isnil "ryanzombiescurrentamount") then {ryanzombiescurrentamount = 0}
if (isnil "ryanzombiestotalamount") then {ryanzombiestotalamount = 10000}
if (isnil "ryanzombiesamount") then {ryanzombiesamount = 100}
if (isnil "ryanzombiesfrequency") then {ryanzombiesfrequency = 60}
if (isnil "ryanzombiesactivation") then {ryanzombiesactivation = 0.9}
if (isnil "ryanzombieshordesize") then {ryanzombieshordesize = 14}
_array = ["RyanZombieB_Soldier_02_fmedium", "RyanZombieB_Soldier_02_f_1medium", "RyanZombieB_Soldier_02_f_1_1medium", "RyanZombieB_Soldier_03_fmedium", "RyanZombieB_Soldier_03_f_1medium", "RyanZombieB_Soldier_03_f_1_1medium", "RyanZombieB_Soldier_04_fmedium", "RyanZombieB_Soldier_04_f_1medium", "RyanZombieB_Soldier_04_f_1_1medium", "RyanZombieB_Soldier_lite_Fmedium", "RyanZombieB_Soldier_lite_F_1medium"]
~ryanzombiesstart

#Ryanzombieslogicspawnmedium2opforloop
if (ryanzombiesactivation == 0.7) then {goto "activationblufor"}
if (ryanzombiesactivation == 0.5) then {goto "activationopfor"}
if (ryanzombiesactivation == 0.3) then {goto "activationindep"}

#Ryanzombieslogicspawnmedium2opfornext
_grp = creategroup east
_x = 0
~1
if (isnull _grp) then {goto "Ryanzombieslogicspawnmedium2opforloop"}

#Ryanzombieslogicspawnmedium2opfornextloop
_x = _x + 1
_random = _array select floor random count _array
if (ryanzombiescurrentamount > ryanzombiestotalamount) then {goto "end"}
if (ryanzombiescurrentamount < ryanzombiesamount) then {format ["%1",_random] createunit [position _logic, _grp, "this switchmove 'AmovPercMstpSnonWnonDnon_SaluteOut'; [this] exec '\ryanzombies\count.sqf'"]}
if (ryanzombiescurrentamount < ryanzombiesamount) then {ryanzombiescurrentamount = ryanzombiescurrentamount + 1}
~ryanzombiesdelay
if (_x < ryanzombieshordesize) then {goto "Ryanzombieslogicspawnmedium2opfornextloop"}
deletegroup _grp
~ryanzombiesfrequency
goto "Ryanzombieslogicspawnmedium2opforloop"



#Ryanzombieslogicspawnmedium3opfor
~0.5 + random 1
if (isnil "ryanzombiesstart") then {ryanzombiesstart = 5}
if (isnil "ryanzombiesdelay") then {ryanzombiesdelay = 0.5}
if (isnil "ryanzombiescurrentamount") then {ryanzombiescurrentamount = 0}
if (isnil "ryanzombiestotalamount") then {ryanzombiestotalamount = 10000}
if (isnil "ryanzombiesamount") then {ryanzombiesamount = 100}
if (isnil "ryanzombiesfrequency") then {ryanzombiesfrequency = 60}
if (isnil "ryanzombiesactivation") then {ryanzombiesactivation = 0.9}
if (isnil "ryanzombieshordesize") then {ryanzombieshordesize = 14}
_array = ["RyanZombieC_man_1medium", "RyanZombieC_man_polo_1_Fmedium", "RyanZombieC_man_polo_2_Fmedium", "RyanZombieC_man_polo_4_Fmedium", "RyanZombieC_man_polo_5_Fmedium", "RyanZombieC_man_polo_6_Fmedium", "RyanZombieC_man_p_fugitive_Fmedium", "RyanZombieC_man_w_worker_Fmedium", "RyanZombieC_scientist_Fmedium", "RyanZombieC_man_hunter_1_Fmedium", "RyanZombieC_man_pilot_Fmedium", "RyanZombieC_journalist_Fmedium", "RyanZombieC_Orestesmedium", "RyanZombieC_Nikosmedium", "RyanZombieB_Soldier_02_fmedium", "RyanZombieB_Soldier_02_f_1medium", "RyanZombieB_Soldier_02_f_1_1medium", "RyanZombieB_Soldier_03_fmedium", "RyanZombieB_Soldier_03_f_1medium", "RyanZombieB_Soldier_03_f_1_1medium", "RyanZombieB_Soldier_04_fmedium", "RyanZombieB_Soldier_04_f_1medium", "RyanZombieB_Soldier_04_f_1_1medium", "RyanZombieB_Soldier_lite_Fmedium", "RyanZombieB_Soldier_lite_F_1medium"]
~ryanzombiesstart

#Ryanzombieslogicspawnmedium3opforloop
if (ryanzombiesactivation == 0.7) then {goto "activationblufor"}
if (ryanzombiesactivation == 0.5) then {goto "activationopfor"}
if (ryanzombiesactivation == 0.3) then {goto "activationindep"}

#Ryanzombieslogicspawnmedium3opfornext
_grp = creategroup east
_x = 0
~1
if (isnull _grp) then {goto "Ryanzombieslogicspawnmedium3opforloop"}

#Ryanzombieslogicspawnmedium3opfornextloop
_x = _x + 1
_random = _array select floor random count _array
if (ryanzombiescurrentamount > ryanzombiestotalamount) then {goto "end"}
if (ryanzombiescurrentamount < ryanzombiesamount) then {format ["%1",_random] createunit [position _logic, _grp, "this switchmove 'AmovPercMstpSnonWnonDnon_SaluteOut'; [this] exec '\ryanzombies\count.sqf'"]}
if (ryanzombiescurrentamount < ryanzombiesamount) then {ryanzombiescurrentamount = ryanzombiescurrentamount + 1}
~ryanzombiesdelay
if (_x < ryanzombieshordesize) then {goto "Ryanzombieslogicspawnmedium3opfornextloop"}
deletegroup _grp
~ryanzombiesfrequency
goto "Ryanzombieslogicspawnmedium3opforloop"



#Ryanzombieslogicspawnslow1opfor
~0.5 + random 1
if (isnil "ryanzombiesstart") then {ryanzombiesstart = 5}
if (isnil "ryanzombiesdelay") then {ryanzombiesdelay = 0.5}
if (isnil "ryanzombiescurrentamount") then {ryanzombiescurrentamount = 0}
if (isnil "ryanzombiestotalamount") then {ryanzombiestotalamount = 10000}
if (isnil "ryanzombiesamount") then {ryanzombiesamount = 100}
if (isnil "ryanzombiesfrequency") then {ryanzombiesfrequency = 60}
if (isnil "ryanzombiesactivation") then {ryanzombiesactivation = 0.9}
if (isnil "ryanzombieshordesize") then {ryanzombieshordesize = 14}
_array = ["RyanZombieC_man_1slow", "RyanZombieC_man_polo_1_Fslow", "RyanZombieC_man_polo_2_Fslow", "RyanZombieC_man_polo_4_Fslow", "RyanZombieC_man_polo_5_Fslow", "RyanZombieC_man_polo_6_Fslow", "RyanZombieC_man_p_fugitive_Fslow", "RyanZombieC_man_w_worker_Fslow", "RyanZombieC_scientist_Fslow", "RyanZombieC_man_hunter_1_Fslow", "RyanZombieC_man_pilot_Fslow", "RyanZombieC_journalist_Fslow", "RyanZombieC_Orestesslow", "RyanZombieC_Nikosslow"]
~ryanzombiesstart

#Ryanzombieslogicspawnslow1opforloop
if (ryanzombiesactivation == 0.7) then {goto "activationblufor"}
if (ryanzombiesactivation == 0.5) then {goto "activationopfor"}
if (ryanzombiesactivation == 0.3) then {goto "activationindep"}

#Ryanzombieslogicspawnslow1opfornext
_grp = creategroup east
_x = 0
~1
if (isnull _grp) then {goto "Ryanzombieslogicspawnslow1opforloop"}

#Ryanzombieslogicspawnslow1opfornextloop
_x = _x + 1
_random = _array select floor random count _array
if (ryanzombiescurrentamount > ryanzombiestotalamount) then {goto "end"}
if (ryanzombiescurrentamount < ryanzombiesamount) then {format ["%1",_random] createunit [position _logic, _grp, "this switchmove 'AmovPercMstpSnonWnonDnon_SaluteOut'; [this] exec '\ryanzombies\count.sqf'"]}
if (ryanzombiescurrentamount < ryanzombiesamount) then {ryanzombiescurrentamount = ryanzombiescurrentamount + 1}
~ryanzombiesdelay
if (_x < ryanzombieshordesize) then {goto "Ryanzombieslogicspawnslow1opfornextloop"}
deletegroup _grp
~ryanzombiesfrequency
goto "Ryanzombieslogicspawnslow1opforloop"



#Ryanzombieslogicspawnslow2opfor
~0.5 + random 1
if (isnil "ryanzombiesstart") then {ryanzombiesstart = 5}
if (isnil "ryanzombiesdelay") then {ryanzombiesdelay = 0.5}
if (isnil "ryanzombiescurrentamount") then {ryanzombiescurrentamount = 0}
if (isnil "ryanzombiestotalamount") then {ryanzombiestotalamount = 10000}
if (isnil "ryanzombiesamount") then {ryanzombiesamount = 100}
if (isnil "ryanzombiesfrequency") then {ryanzombiesfrequency = 60}
if (isnil "ryanzombiesactivation") then {ryanzombiesactivation = 0.9}
if (isnil "ryanzombieshordesize") then {ryanzombieshordesize = 14}
_array = ["RyanZombieB_Soldier_02_fslow", "RyanZombieB_Soldier_02_f_1slow", "RyanZombieB_Soldier_02_f_1_1slow", "RyanZombieB_Soldier_03_fslow", "RyanZombieB_Soldier_03_f_1slow", "RyanZombieB_Soldier_03_f_1_1slow", "RyanZombieB_Soldier_04_fslow", "RyanZombieB_Soldier_04_f_1slow", "RyanZombieB_Soldier_04_f_1_1slow", "RyanZombieB_Soldier_lite_Fslow", "RyanZombieB_Soldier_lite_F_1slow"]
~ryanzombiesstart

#Ryanzombieslogicspawnslow2opforloop
if (ryanzombiesactivation == 0.7) then {goto "activationblufor"}
if (ryanzombiesactivation == 0.5) then {goto "activationopfor"}
if (ryanzombiesactivation == 0.3) then {goto "activationindep"}

#Ryanzombieslogicspawnslow2opfornext
_grp = creategroup east
_x = 0
~1
if (isnull _grp) then {goto "Ryanzombieslogicspawnslow2opforloop"}

#Ryanzombieslogicspawnslow2opfornextloop
_x = _x + 1
_random = _array select floor random count _array
if (ryanzombiescurrentamount > ryanzombiestotalamount) then {goto "end"}
if (ryanzombiescurrentamount < ryanzombiesamount) then {format ["%1",_random] createunit [position _logic, _grp, "this switchmove 'AmovPercMstpSnonWnonDnon_SaluteOut'; [this] exec '\ryanzombies\count.sqf'"]}
if (ryanzombiescurrentamount < ryanzombiesamount) then {ryanzombiescurrentamount = ryanzombiescurrentamount + 1}
~ryanzombiesdelay
if (_x < ryanzombieshordesize) then {goto "Ryanzombieslogicspawnslow2opfornextloop"}
deletegroup _grp
~ryanzombiesfrequency
goto "Ryanzombieslogicspawnslow2opforloop"



#Ryanzombieslogicspawnslow3opfor
~0.5 + random 1
if (isnil "ryanzombiesstart") then {ryanzombiesstart = 5}
if (isnil "ryanzombiesdelay") then {ryanzombiesdelay = 0.5}
if (isnil "ryanzombiescurrentamount") then {ryanzombiescurrentamount = 0}
if (isnil "ryanzombiestotalamount") then {ryanzombiestotalamount = 10000}
if (isnil "ryanzombiesamount") then {ryanzombiesamount = 100}
if (isnil "ryanzombiesfrequency") then {ryanzombiesfrequency = 60}
if (isnil "ryanzombiesactivation") then {ryanzombiesactivation = 0.9}
if (isnil "ryanzombieshordesize") then {ryanzombieshordesize = 14}
_array = ["RyanZombieC_man_1slow", "RyanZombieC_man_polo_1_Fslow", "RyanZombieC_man_polo_2_Fslow", "RyanZombieC_man_polo_4_Fslow", "RyanZombieC_man_polo_5_Fslow", "RyanZombieC_man_polo_6_Fslow", "RyanZombieC_man_p_fugitive_Fslow", "RyanZombieC_man_w_worker_Fslow", "RyanZombieC_scientist_Fslow", "RyanZombieC_man_hunter_1_Fslow", "RyanZombieC_man_pilot_Fslow", "RyanZombieC_journalist_Fslow", "RyanZombieC_Orestesslow", "RyanZombieC_Nikosslow", "RyanZombieB_Soldier_02_fslow", "RyanZombieB_Soldier_02_f_1slow", "RyanZombieB_Soldier_02_f_1_1slow", "RyanZombieB_Soldier_03_fslow", "RyanZombieB_Soldier_03_f_1slow", "RyanZombieB_Soldier_03_f_1_1slow", "RyanZombieB_Soldier_04_fslow", "RyanZombieB_Soldier_04_f_1slow", "RyanZombieB_Soldier_04_f_1_1slow", "RyanZombieB_Soldier_lite_Fslow", "RyanZombieB_Soldier_lite_F_1slow"]
~ryanzombiesstart

#Ryanzombieslogicspawnslow3opforloop
if (ryanzombiesactivation == 0.7) then {goto "activationblufor"}
if (ryanzombiesactivation == 0.5) then {goto "activationopfor"}
if (ryanzombiesactivation == 0.3) then {goto "activationindep"}

#Ryanzombieslogicspawnslow3opfornext
_grp = creategroup east
_x = 0
~1
if (isnull _grp) then {goto "Ryanzombieslogicspawnslow3opforloop"}

#Ryanzombieslogicspawnslow3opfornextloop
_x = _x + 1
_random = _array select floor random count _array
if (ryanzombiescurrentamount > ryanzombiestotalamount) then {goto "end"}
if (ryanzombiescurrentamount < ryanzombiesamount) then {format ["%1",_random] createunit [position _logic, _grp, "this switchmove 'AmovPercMstpSnonWnonDnon_SaluteOut'; [this] exec '\ryanzombies\count.sqf'"]}
if (ryanzombiescurrentamount < ryanzombiesamount) then {ryanzombiescurrentamount = ryanzombiescurrentamount + 1}
~ryanzombiesdelay
if (_x < ryanzombieshordesize) then {goto "Ryanzombieslogicspawnslow3opfornextloop"}
deletegroup _grp
~ryanzombiesfrequency
goto "Ryanzombieslogicspawnslow3opforloop"



#Ryanzombieslogicspawndemonsopfor
~0.5 + random 1
if (isnil "ryanzombiesstartdemon") then {ryanzombiesstartdemon = 5}
if (isnil "ryanzombiesdelaydemon") then {ryanzombiesdelaydemon = 0.5}
if (isnil "ryanzombiescurrentamountdemon") then {ryanzombiescurrentamountdemon = 0}
if (isnil "ryanzombiestotalamountdemon") then {ryanzombiestotalamountdemon = 10000}
if (isnil "ryanzombiesamountdemon") then {ryanzombiesamountdemon = 100}
if (isnil "ryanzombiesfrequencydemon") then {ryanzombiesfrequencydemon = 60}
if (isnil "ryanzombiesactivationdemon") then {ryanzombiesactivationdemon = 0.9}
if (isnil "ryanzombieshordesizedemon") then {ryanzombieshordesizedemon = 14}
_array = ["RyanZombieboss1", "RyanZombieboss2", "RyanZombieboss3", "RyanZombieboss4", "RyanZombieboss5", "RyanZombieboss6", "RyanZombieboss7", "RyanZombieboss8", "RyanZombieboss9", "RyanZombieboss10", "RyanZombieboss11", "RyanZombieboss12", "RyanZombieboss13", "RyanZombieboss14"]
~ryanzombiesstartdemon

#Ryanzombieslogicspawndemonsopforloop
if (ryanzombiesactivationdemon == 0.7) then {goto "activationblufordemon"}
if (ryanzombiesactivationdemon == 0.5) then {goto "activationopfordemon"}
if (ryanzombiesactivationdemon == 0.3) then {goto "activationindepdemon"}

#Ryanzombieslogicspawndemonsopfornext
_grp = creategroup east
_x = 0
~1
if (isnull _grp) then {goto "Ryanzombieslogicspawndemonsopforloop"}

#Ryanzombieslogicspawndemonsopfornextloop
_x = _x + 1
_random = _array select floor random count _array
if (ryanzombiescurrentamountdemon > ryanzombiestotalamountdemon) then {goto "end"}
if (ryanzombiescurrentamountdemon < ryanzombiesamountdemon) then {format ["%1",_random] createunit [position _logic, _grp, "this switchmove 'AmovPercMstpSnonWnonDnon_SaluteOut'; [this] exec '\ryanzombies\countdemon.sqf'"]}
if (ryanzombiescurrentamountdemon < ryanzombiesamountdemon) then {ryanzombiescurrentamountdemon = ryanzombiescurrentamountdemon + 1}
~ryanzombiesdelaydemon
if (_x < ryanzombieshordesizedemon) then {goto "Ryanzombieslogicspawndemonsopfornextloop"}
deletegroup _grp
~ryanzombiesfrequencydemon
goto "Ryanzombieslogicspawndemonsopforloop"



#Ryanzombieslogicspawnspidersopfor
~0.5 + random 1
if (isnil "ryanzombiesstart") then {ryanzombiesstart = 5}
if (isnil "ryanzombiesdelay") then {ryanzombiesdelay = 0.5}
if (isnil "ryanzombiescurrentamount") then {ryanzombiescurrentamount = 0}
if (isnil "ryanzombiestotalamount") then {ryanzombiestotalamount = 10000}
if (isnil "ryanzombiesamount") then {ryanzombiesamount = 100}
if (isnil "ryanzombiesfrequency") then {ryanzombiesfrequency = 60}
if (isnil "ryanzombiesactivation") then {ryanzombiesactivation = 0.9}
if (isnil "ryanzombieshordesize") then {ryanzombieshordesize = 14}
_array = ["RyanZombieSpider1", "RyanZombieSpider2", "RyanZombieSpider3", "RyanZombieSpider4", "RyanZombieSpider5", "RyanZombieSpider6", "RyanZombieSpider7", "RyanZombieSpider8", "RyanZombieSpider9", "RyanZombieSpider10", "RyanZombieSpider11", "RyanZombieSpider12", "RyanZombieSpider13", "RyanZombieSpider14"]
~ryanzombiesstart

#Ryanzombieslogicspawnspidersopforloop
if (ryanzombiesactivation == 0.7) then {goto "activationblufor"}
if (ryanzombiesactivation == 0.5) then {goto "activationopfor"}
if (ryanzombiesactivation == 0.3) then {goto "activationindep"}

#Ryanzombieslogicspawnspidersopfornext
_grp = creategroup east
_x = 0
~1
if (isnull _grp) then {goto "Ryanzombieslogicspawnspidersopforloop"}

#Ryanzombieslogicspawnspidersopfornextloop
_x = _x + 1
_random = _array select floor random count _array
if (ryanzombiescurrentamount > ryanzombiestotalamount) then {goto "end"}
if (ryanzombiescurrentamount < ryanzombiesamount) then {format ["%1",_random] createunit [position _logic, _grp, "this switchmove 'AmovPercMstpSnonWnonDnon_SaluteOut'; [this] exec '\ryanzombies\count.sqf'"]}
if (ryanzombiescurrentamount < ryanzombiesamount) then {ryanzombiescurrentamount = ryanzombiescurrentamount + 1}
~ryanzombiesdelay
if (_x < ryanzombieshordesize) then {goto "Ryanzombieslogicspawnspidersopfornextloop"}
deletegroup _grp
~ryanzombiesfrequency
goto "Ryanzombieslogicspawnspidersopforloop"



#Ryanzombieslogicspawnmixedopfor
~0.5 + random 1
if (isnil "ryanzombiesstart") then {ryanzombiesstart = 5}
if (isnil "ryanzombiesdelay") then {ryanzombiesdelay = 0.5}
if (isnil "ryanzombiescurrentamount") then {ryanzombiescurrentamount = 0}
if (isnil "ryanzombiestotalamount") then {ryanzombiestotalamount = 10000}
if (isnil "ryanzombiesamount") then {ryanzombiesamount = 100}
if (isnil "ryanzombiesfrequency") then {ryanzombiesfrequency = 60}
if (isnil "ryanzombiesactivation") then {ryanzombiesactivation = 0.9}
if (isnil "ryanzombieshordesize") then {ryanzombieshordesize = 14}
_array = ["RyanZombieC_man_1", "RyanZombieC_man_polo_1_F", "RyanZombieC_man_polo_2_F", "RyanZombieC_man_polo_4_F", "RyanZombieC_man_polo_5_F", "RyanZombieC_man_polo_6_F", "RyanZombieC_man_p_fugitive_F", "RyanZombieC_man_w_worker_F", "RyanZombieC_scientist_F", "RyanZombieC_man_hunter_1_F", "RyanZombieC_man_pilot_F", "RyanZombieC_journalist_F", "RyanZombieC_Orestes", "RyanZombieC_Nikos", "RyanZombieB_Soldier_02_f", "RyanZombieB_Soldier_02_f_1", "RyanZombieB_Soldier_02_f_1_1", "RyanZombieB_Soldier_03_f", "RyanZombieB_Soldier_03_f_1", "RyanZombieB_Soldier_03_f_1_1", "RyanZombieB_Soldier_04_f", "RyanZombieB_Soldier_04_f_1", "RyanZombieB_Soldier_04_f_1_1", "RyanZombieB_Soldier_lite_F", "RyanZombieB_Soldier_lite_F_1", "RyanZombieC_man_1medium", "RyanZombieC_man_polo_1_Fmedium", "RyanZombieC_man_polo_2_Fmedium", "RyanZombieC_man_polo_4_Fmedium", "RyanZombieC_man_polo_5_Fmedium", "RyanZombieC_man_polo_6_Fmedium", "RyanZombieC_man_p_fugitive_Fmedium", "RyanZombieC_man_w_worker_Fmedium", "RyanZombieC_scientist_Fmedium", "RyanZombieC_man_hunter_1_Fmedium", "RyanZombieC_man_pilot_Fmedium", "RyanZombieC_journalist_Fmedium", "RyanZombieC_Orestesmedium", "RyanZombieC_Nikosmedium", "RyanZombieB_Soldier_02_fmedium", "RyanZombieB_Soldier_02_f_1medium", "RyanZombieB_Soldier_02_f_1_1medium", "RyanZombieB_Soldier_03_fmedium", "RyanZombieB_Soldier_03_f_1medium", "RyanZombieB_Soldier_03_f_1_1medium", "RyanZombieB_Soldier_04_fmedium", "RyanZombieB_Soldier_04_f_1medium", "RyanZombieB_Soldier_04_f_1_1medium", "RyanZombieB_Soldier_lite_Fmedium", "RyanZombieB_Soldier_lite_F_1medium", "RyanZombieC_man_1slow", "RyanZombieC_man_polo_1_Fslow", "RyanZombieC_man_polo_2_Fslow", "RyanZombieC_man_polo_4_Fslow", "RyanZombieC_man_polo_5_Fslow", "RyanZombieC_man_polo_6_Fslow", "RyanZombieC_man_p_fugitive_Fslow", "RyanZombieC_man_w_worker_Fslow", "RyanZombieC_scientist_Fslow", "RyanZombieC_man_hunter_1_Fslow", "RyanZombieC_man_pilot_Fslow", "RyanZombieC_journalist_Fslow", "RyanZombieC_Orestesslow", "RyanZombieC_Nikosslow", "RyanZombieB_Soldier_02_fslow", "RyanZombieB_Soldier_02_f_1slow", "RyanZombieB_Soldier_02_f_1_1slow", "RyanZombieB_Soldier_03_fslow", "RyanZombieB_Soldier_03_f_1slow", "RyanZombieB_Soldier_03_f_1_1slow", "RyanZombieB_Soldier_04_fslow", "RyanZombieB_Soldier_04_f_1slow", "RyanZombieB_Soldier_04_f_1_1slow", "RyanZombieB_Soldier_lite_Fslow", "RyanZombieB_Soldier_lite_F_1slow", "RyanZombieSpider1", "RyanZombieSpider2", "RyanZombieSpider3", "RyanZombieSpider4", "RyanZombieSpider5", "RyanZombieSpider6", "RyanZombieSpider7", "RyanZombieSpider8", "RyanZombieSpider9", "RyanZombieSpider10", "RyanZombieSpider11", "RyanZombieSpider12", "RyanZombieSpider13", "RyanZombieSpider14"]
~ryanzombiesstart

#Ryanzombieslogicspawnmixedopforloop
if (ryanzombiesactivation == 0.7) then {goto "activationblufor"}
if (ryanzombiesactivation == 0.5) then {goto "activationopfor"}
if (ryanzombiesactivation == 0.3) then {goto "activationindep"}

#Ryanzombieslogicspawnmixedopfornext
_grp = creategroup east
_x = 0
~1
if (isnull _grp) then {goto "Ryanzombieslogicspawnmixedopforloop"}

#Ryanzombieslogicspawnmixedopfornextloop
_x = _x + 1
_random = _array select floor random count _array
if (ryanzombiescurrentamount > ryanzombiestotalamount) then {goto "end"}
if (ryanzombiescurrentamount < ryanzombiesamount) then {format ["%1",_random] createunit [position _logic, _grp, "this switchmove 'AmovPercMstpSnonWnonDnon_SaluteOut'; [this] exec '\ryanzombies\count.sqf'"]}
if (ryanzombiescurrentamount < ryanzombiesamount) then {ryanzombiescurrentamount = ryanzombiescurrentamount + 1}
~ryanzombiesdelay
if (_x < ryanzombieshordesize) then {goto "Ryanzombieslogicspawnmixedopfornextloop"}
deletegroup _grp
~ryanzombiesfrequency
goto "Ryanzombieslogicspawnmixedopforloop"



#end