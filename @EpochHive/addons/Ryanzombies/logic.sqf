_logic = _this select 0

~0.1

if !(isServer) then {goto "end"}

goto format["%1", typeof _logic]

#Ryanzombieslogiceasy
Ryanzombiesattackspeed = 1.2
Ryanzombiesattackdistance = 2.15
Ryanzombiesattackstrenth = 0.5 + random 2
Ryanzombiesdamage = 0.05
Ryanzombiesdamagecar = 0.01
Ryanzombiesdamageair = 0.002
Ryanzombiesdamagetank = 0.0001
Ryanzombiesdamagecarstrenth = 1 + random 0.5
Ryanzombiesdamageairstrenth = 0.5 + random 0.5
Ryanzombiesdamagetankstrenth = 0.1 + random 0.2
goto "end"

#Ryanzombieslogichard
Ryanzombiesattackspeed = 0.2
Ryanzombiesattackdistance = 2.45
Ryanzombiesattackstrenth = 3 + random 2
Ryanzombiesdamage = 0.4
Ryanzombiesdamagecar = 0.05
Ryanzombiesdamageair = 0.04
Ryanzombiesdamagetank = 0.02
Ryanzombiesdamagecarstrenth = 4 + random 2
Ryanzombiesdamageairstrenth = 3.5 + random 2
Ryanzombiesdamagetankstrenth = 3 + random 2
goto "end"

#Ryanzombieslogicthrow
Ryanzombiescanthrow = 1
Ryanzombiescanthrowdistance = 99999
goto "end"

#Ryanzombieslogicthrow25
Ryanzombiescanthrow = 1
if (isnil "Ryanzombiescanthrowdistance") then {Ryanzombiescanthrowdistance = 1}
~1 + random 2
Ryanzombiescanthrowdistance = Ryanzombiescanthrowdistance + 25
goto "end"

#Ryanzombieslogicthrowtank
Ryanzombiescanthrowtank = 1
Ryanzombiescanthrowtankdistance = 99999
goto "end"

#Ryanzombieslogicthrowtank25
Ryanzombiescanthrowtank = 1
if (isnil "Ryanzombiescanthrowtankdistance") then {Ryanzombiescanthrowtankdistance = 1}
~1 + random 2
Ryanzombiescanthrowtankdistance = Ryanzombiescanthrowtankdistance + 25
goto "end"

#Ryanzombieslogicsounds
[_logic] exec "\ryanzombies\sounds.sqf"
goto "end"

#Ryanzombieslogicsoundsaggressive
[_logic] exec "\ryanzombies\soundsclose.sqf"
~1.5
goto "Ryanzombieslogicsoundsaggressive"

#Ryanzombieslogicinvincible
Ryanzombiesinvincible = 1
goto "end"

#Ryanzombieslogicinvincibledemon
Ryanzombiesinvincibledemon = 1
goto "end"

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



#Ryanzombieslogicspawnfast1
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

#Ryanzombieslogicspawnfast1loop
if (ryanzombiesactivation == 0.7) then {goto "activationblufor"}
if (ryanzombiesactivation == 0.5) then {goto "activationopfor"}
if (ryanzombiesactivation == 0.3) then {goto "activationindep"}

#Ryanzombieslogicspawnfast1next
_grp = creategroup resistance
_x = 0
~1
if (isnull _grp) then {goto "Ryanzombieslogicspawnfast1loop"}

#Ryanzombieslogicspawnfast1nextloop
_x = _x + 1
_random = _array select floor random count _array
if (ryanzombiescurrentamount > ryanzombiestotalamount) then {goto "end"}
if (ryanzombiescurrentamount < ryanzombiesamount) then {format ["%1",_random] createunit [position _logic, _grp, "this switchmove 'AmovPercMstpSnonWnonDnon_SaluteOut'; [this] exec '\ryanzombies\count.sqf'"]}
if (ryanzombiescurrentamount < ryanzombiesamount) then {ryanzombiescurrentamount = ryanzombiescurrentamount + 1}
~ryanzombiesdelay
if (_x < ryanzombieshordesize) then {goto "Ryanzombieslogicspawnfast1nextloop"}
deletegroup _grp
~ryanzombiesfrequency
goto "Ryanzombieslogicspawnfast1loop"



#Ryanzombieslogicspawnfast2
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

#Ryanzombieslogicspawnfast2loop
if (ryanzombiesactivation == 0.7) then {goto "activationblufor"}
if (ryanzombiesactivation == 0.5) then {goto "activationopfor"}
if (ryanzombiesactivation == 0.3) then {goto "activationindep"}

#Ryanzombieslogicspawnfast2next
_grp = creategroup resistance
_x = 0
~1
if (isnull _grp) then {goto "Ryanzombieslogicspawnfast2nextloop"}

#Ryanzombieslogicspawnfast2nextloop
_x = _x + 1
_random = _array select floor random count _array
if (ryanzombiescurrentamount > ryanzombiestotalamount) then {goto "end"}
if (ryanzombiescurrentamount < ryanzombiesamount) then {format ["%1",_random] createunit [position _logic, _grp, "this switchmove 'AmovPercMstpSnonWnonDnon_SaluteOut'; [this] exec '\ryanzombies\count.sqf'"]}
if (ryanzombiescurrentamount < ryanzombiesamount) then {ryanzombiescurrentamount = ryanzombiescurrentamount + 1}
~ryanzombiesdelay
if (_x < ryanzombieshordesize) then {goto "Ryanzombieslogicspawnfast2nextloop"}
deletegroup _grp
~ryanzombiesfrequency
goto "Ryanzombieslogicspawnfast2loop"



#Ryanzombieslogicspawnfast3
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

#Ryanzombieslogicspawnfast3loop
if (ryanzombiesactivation == 0.7) then {goto "activationblufor"}
if (ryanzombiesactivation == 0.5) then {goto "activationopfor"}
if (ryanzombiesactivation == 0.3) then {goto "activationindep"}

#Ryanzombieslogicspawnfast3next
_grp = creategroup resistance
_x = 0
~1
if (isnull _grp) then {goto "Ryanzombieslogicspawnfast3nextloop"}

#Ryanzombieslogicspawnfast3nextloop
_x = _x + 1
_random = _array select floor random count _array
if (ryanzombiescurrentamount > ryanzombiestotalamount) then {goto "end"}
if (ryanzombiescurrentamount < ryanzombiesamount) then {format ["%1",_random] createunit [position _logic, _grp, "this switchmove 'AmovPercMstpSnonWnonDnon_SaluteOut'; [this] exec '\ryanzombies\count.sqf'"]}
if (ryanzombiescurrentamount < ryanzombiesamount) then {ryanzombiescurrentamount = ryanzombiescurrentamount + 1}
~ryanzombiesdelay
if (_x < ryanzombieshordesize) then {goto "Ryanzombieslogicspawnfast3nextloop"}
deletegroup _grp
~ryanzombiesfrequency
goto "Ryanzombieslogicspawnfast3loop"



#Ryanzombieslogicspawnmedium1
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

#Ryanzombieslogicspawnmedium1loop
if (ryanzombiesactivation == 0.7) then {goto "activationblufor"}
if (ryanzombiesactivation == 0.5) then {goto "activationopfor"}
if (ryanzombiesactivation == 0.3) then {goto "activationindep"}

#Ryanzombieslogicspawnmedium1next
_grp = creategroup resistance
_x = 0
~1
if (isnull _grp) then {goto "Ryanzombieslogicspawnmedium1loop"}

#Ryanzombieslogicspawnmedium1nextloop
_x = _x + 1
_random = _array select floor random count _array
if (ryanzombiescurrentamount > ryanzombiestotalamount) then {goto "end"}
if (ryanzombiescurrentamount < ryanzombiesamount) then {format ["%1",_random] createunit [position _logic, _grp, "this switchmove 'AmovPercMstpSnonWnonDnon_SaluteOut'; [this] exec '\ryanzombies\count.sqf'"]}
if (ryanzombiescurrentamount < ryanzombiesamount) then {ryanzombiescurrentamount = ryanzombiescurrentamount + 1}
~ryanzombiesdelay
if (_x < ryanzombieshordesize) then {goto "Ryanzombieslogicspawnmedium1nextloop"}
deletegroup _grp
~ryanzombiesfrequency
goto "Ryanzombieslogicspawnmedium1loop"



#Ryanzombieslogicspawnmedium2
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

#Ryanzombieslogicspawnmedium2loop
if (ryanzombiesactivation == 0.7) then {goto "activationblufor"}
if (ryanzombiesactivation == 0.5) then {goto "activationopfor"}
if (ryanzombiesactivation == 0.3) then {goto "activationindep"}

#Ryanzombieslogicspawnmedium2next
_grp = creategroup resistance
_x = 0
~1
if (isnull _grp) then {goto "Ryanzombieslogicspawnmedium2loop"}

#Ryanzombieslogicspawnmedium2nextloop
_x = _x + 1
_random = _array select floor random count _array
if (ryanzombiescurrentamount > ryanzombiestotalamount) then {goto "end"}
if (ryanzombiescurrentamount < ryanzombiesamount) then {format ["%1",_random] createunit [position _logic, _grp, "this switchmove 'AmovPercMstpSnonWnonDnon_SaluteOut'; [this] exec '\ryanzombies\count.sqf'"]}
if (ryanzombiescurrentamount < ryanzombiesamount) then {ryanzombiescurrentamount = ryanzombiescurrentamount + 1}
~ryanzombiesdelay
if (_x < ryanzombieshordesize) then {goto "Ryanzombieslogicspawnmedium2nextloop"}
deletegroup _grp
~ryanzombiesfrequency
goto "Ryanzombieslogicspawnmedium2loop"



#Ryanzombieslogicspawnmedium3
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

#Ryanzombieslogicspawnmedium3loop
if (ryanzombiesactivation == 0.7) then {goto "activationblufor"}
if (ryanzombiesactivation == 0.5) then {goto "activationopfor"}
if (ryanzombiesactivation == 0.3) then {goto "activationindep"}

#Ryanzombieslogicspawnmedium3next
_grp = creategroup resistance
_x = 0
~1
if (isnull _grp) then {goto "Ryanzombieslogicspawnmedium3loop"}

#Ryanzombieslogicspawnmedium3nextloop
_x = _x + 1
_random = _array select floor random count _array
if (ryanzombiescurrentamount > ryanzombiestotalamount) then {goto "end"}
if (ryanzombiescurrentamount < ryanzombiesamount) then {format ["%1",_random] createunit [position _logic, _grp, "this switchmove 'AmovPercMstpSnonWnonDnon_SaluteOut'; [this] exec '\ryanzombies\count.sqf'"]}
if (ryanzombiescurrentamount < ryanzombiesamount) then {ryanzombiescurrentamount = ryanzombiescurrentamount + 1}
~ryanzombiesdelay
if (_x < ryanzombieshordesize) then {goto "Ryanzombieslogicspawnmedium3nextloop"}
deletegroup _grp
~ryanzombiesfrequency
goto "Ryanzombieslogicspawnmedium3loop"



#Ryanzombieslogicspawnslow1
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

#Ryanzombieslogicspawnslow1loop
if (ryanzombiesactivation == 0.7) then {goto "activationblufor"}
if (ryanzombiesactivation == 0.5) then {goto "activationopfor"}
if (ryanzombiesactivation == 0.3) then {goto "activationindep"}

#Ryanzombieslogicspawnslow1next
_grp = creategroup resistance
_x = 0
~1
if (isnull _grp) then {goto "Ryanzombieslogicspawnslow1loop"}

#Ryanzombieslogicspawnslow1nextloop
_x = _x + 1
_random = _array select floor random count _array
if (ryanzombiescurrentamount > ryanzombiestotalamount) then {goto "end"}
if (ryanzombiescurrentamount < ryanzombiesamount) then {format ["%1",_random] createunit [position _logic, _grp, "this switchmove 'AmovPercMstpSnonWnonDnon_SaluteOut'; [this] exec '\ryanzombies\count.sqf'"]}
if (ryanzombiescurrentamount < ryanzombiesamount) then {ryanzombiescurrentamount = ryanzombiescurrentamount + 1}
~ryanzombiesdelay
if (_x < ryanzombieshordesize) then {goto "Ryanzombieslogicspawnslow1nextloop"}
deletegroup _grp
~ryanzombiesfrequency
goto "Ryanzombieslogicspawnslow1loop"



#Ryanzombieslogicspawnslow2
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

#Ryanzombieslogicspawnslow2loop
if (ryanzombiesactivation == 0.7) then {goto "activationblufor"}
if (ryanzombiesactivation == 0.5) then {goto "activationopfor"}
if (ryanzombiesactivation == 0.3) then {goto "activationindep"}

#Ryanzombieslogicspawnslow2next
_grp = creategroup resistance
_x = 0
~1
if (isnull _grp) then {goto "Ryanzombieslogicspawnslow2loop"}

#Ryanzombieslogicspawnslow2nextloop
_x = _x + 1
_random = _array select floor random count _array
if (ryanzombiescurrentamount > ryanzombiestotalamount) then {goto "end"}
if (ryanzombiescurrentamount < ryanzombiesamount) then {format ["%1",_random] createunit [position _logic, _grp, "this switchmove 'AmovPercMstpSnonWnonDnon_SaluteOut'; [this] exec '\ryanzombies\count.sqf'"]}
if (ryanzombiescurrentamount < ryanzombiesamount) then {ryanzombiescurrentamount = ryanzombiescurrentamount + 1}
~ryanzombiesdelay
if (_x < ryanzombieshordesize) then {goto "Ryanzombieslogicspawnslow2nextloop"}
deletegroup _grp
~ryanzombiesfrequency
goto "Ryanzombieslogicspawnslow2loop"



#Ryanzombieslogicspawnslow3
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

#Ryanzombieslogicspawnslow3loop
if (ryanzombiesactivation == 0.7) then {goto "activationblufor"}
if (ryanzombiesactivation == 0.5) then {goto "activationopfor"}
if (ryanzombiesactivation == 0.3) then {goto "activationindep"}

#Ryanzombieslogicspawnslow3next
_grp = creategroup resistance
_x = 0
~1
if (isnull _grp) then {goto "Ryanzombieslogicspawnslow3loop"}

#Ryanzombieslogicspawnslow3nextloop
_x = _x + 1
_random = _array select floor random count _array
if (ryanzombiescurrentamount > ryanzombiestotalamount) then {goto "end"}
if (ryanzombiescurrentamount < ryanzombiesamount) then {format ["%1",_random] createunit [position _logic, _grp, "this switchmove 'AmovPercMstpSnonWnonDnon_SaluteOut'; [this] exec '\ryanzombies\count.sqf'"]}
if (ryanzombiescurrentamount < ryanzombiesamount) then {ryanzombiescurrentamount = ryanzombiescurrentamount + 1}
~ryanzombiesdelay
if (_x < ryanzombieshordesize) then {goto "Ryanzombieslogicspawnslow3nextloop"}
deletegroup _grp
~ryanzombiesfrequency
goto "Ryanzombieslogicspawnslow3loop"



#Ryanzombieslogicspawndemons
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

#Ryanzombieslogicspawndemonsloop
if (ryanzombiesactivationdemon == 0.7) then {goto "activationblufordemon"}
if (ryanzombiesactivationdemon == 0.5) then {goto "activationopfordemon"}
if (ryanzombiesactivationdemon == 0.3) then {goto "activationindepdemon"}

#Ryanzombieslogicspawndemonsnext
_grp = creategroup resistance
_x = 0
~1
if (isnull _grp) then {goto "Ryanzombieslogicspawndemonsloop"}

#Ryanzombieslogicspawndemonsnextloop
_x = _x + 1
_random = _array select floor random count _array
if (ryanzombiescurrentamountdemon > ryanzombiestotalamountdemon) then {goto "end"}
if (ryanzombiescurrentamountdemon < ryanzombiesamountdemon) then {format ["%1",_random] createunit [position _logic, _grp, "this switchmove 'AmovPercMstpSnonWnonDnon_SaluteOut'; [this] exec '\ryanzombies\countdemon.sqf'"]}
if (ryanzombiescurrentamountdemon < ryanzombiesamountdemon) then {ryanzombiescurrentamountdemon = ryanzombiescurrentamountdemon + 1}
~ryanzombiesdelaydemon
if (_x < ryanzombieshordesizedemon) then {goto "Ryanzombieslogicspawndemonsnextloop"}
deletegroup _grp
~ryanzombiesfrequencydemon
goto "Ryanzombieslogicspawndemonsloop"



#Ryanzombieslogicspawnspiders
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

#Ryanzombieslogicspawnspidersloop
if (ryanzombiesactivation == 0.7) then {goto "activationblufor"}
if (ryanzombiesactivation == 0.5) then {goto "activationopfor"}
if (ryanzombiesactivation == 0.3) then {goto "activationindep"}

#Ryanzombieslogicspawnspidersnext
_grp = creategroup resistance
_x = 0
~1
if (isnull _grp) then {goto "Ryanzombieslogicspawnspidersloop"}

#Ryanzombieslogicspawnspidersnextloop
_x = _x + 1
_random = _array select floor random count _array
if (ryanzombiescurrentamount > ryanzombiestotalamount) then {goto "end"}
if (ryanzombiescurrentamount < ryanzombiesamount) then {format ["%1",_random] createunit [position _logic, _grp, "this switchmove 'AmovPercMstpSnonWnonDnon_SaluteOut'; [this] exec '\ryanzombies\count.sqf'"]}
if (ryanzombiescurrentamount < ryanzombiesamount) then {ryanzombiescurrentamount = ryanzombiescurrentamount + 1}
~ryanzombiesdelay
if (_x < ryanzombieshordesize) then {goto "Ryanzombieslogicspawnspidersnextloop"}
deletegroup _grp
~ryanzombiesfrequency
goto "Ryanzombieslogicspawnspidersloop"



#Ryanzombieslogicspawnmixed
~0.5 + random 1
/*
if (isnil "ryanzombiesstart") then {ryanzombiesstart = 5}
if (isnil "ryanzombiesdelay") then {ryanzombiesdelay = 0.5}
if (isnil "ryanzombiescurrentamount") then {ryanzombiescurrentamount = 0}
if (isnil "ryanzombiestotalamount") then {ryanzombiestotalamount = 10000}
if (isnil "ryanzombiesamount") then {ryanzombiesamount = 100}
if (isnil "ryanzombiesfrequency") then {ryanzombiesfrequency = 60}
if (isnil "ryanzombiesactivation") then {ryanzombiesactivation = 0.9}
if (isnil "ryanzombieshordesize") then {ryanzombieshordesize = 14}
*/
if (isnil "ryanzombiesstart") then {ryanzombiesstart = 5}
if (isnil "ryanzombiesdelay") then {ryanzombiesdelay = 0.5}
if (isnil "ryanzombiescurrentamount") then {ryanzombiescurrentamount = 0}
if (isnil "ryanzombiestotalamount") then {ryanzombiestotalamount = 20}
if (isnil "ryanzombiesamount") then {ryanzombiesamount = 20}
if (isnil "ryanzombiesfrequency") then {ryanzombiesfrequency = 60}
if (isnil "ryanzombiesactivation") then {ryanzombiesactivation = 0.9}
if (isnil "ryanzombieshordesize") then {ryanzombieshordesize = 10}
_array = ["RyanZombieC_man_1", "RyanZombieC_man_polo_1_F", "RyanZombieC_man_polo_2_F", "RyanZombieC_man_polo_4_F", "RyanZombieC_man_polo_5_F", "RyanZombieC_man_polo_6_F", "RyanZombieC_man_p_fugitive_F", "RyanZombieC_man_w_worker_F", "RyanZombieC_scientist_F", "RyanZombieC_man_hunter_1_F", "RyanZombieC_man_pilot_F", "RyanZombieC_journalist_F", "RyanZombieC_Orestes", "RyanZombieC_Nikos", "RyanZombieB_Soldier_02_f", "RyanZombieB_Soldier_02_f_1", "RyanZombieB_Soldier_02_f_1_1", "RyanZombieB_Soldier_03_f", "RyanZombieB_Soldier_03_f_1", "RyanZombieB_Soldier_03_f_1_1", "RyanZombieB_Soldier_04_f", "RyanZombieB_Soldier_04_f_1", "RyanZombieB_Soldier_04_f_1_1", "RyanZombieB_Soldier_lite_F", "RyanZombieB_Soldier_lite_F_1", "RyanZombieC_man_1medium", "RyanZombieC_man_polo_1_Fmedium", "RyanZombieC_man_polo_2_Fmedium", "RyanZombieC_man_polo_4_Fmedium", "RyanZombieC_man_polo_5_Fmedium", "RyanZombieC_man_polo_6_Fmedium", "RyanZombieC_man_p_fugitive_Fmedium", "RyanZombieC_man_w_worker_Fmedium", "RyanZombieC_scientist_Fmedium", "RyanZombieC_man_hunter_1_Fmedium", "RyanZombieC_man_pilot_Fmedium", "RyanZombieC_journalist_Fmedium", "RyanZombieC_Orestesmedium", "RyanZombieC_Nikosmedium", "RyanZombieB_Soldier_02_fmedium", "RyanZombieB_Soldier_02_f_1medium", "RyanZombieB_Soldier_02_f_1_1medium", "RyanZombieB_Soldier_03_fmedium", "RyanZombieB_Soldier_03_f_1medium", "RyanZombieB_Soldier_03_f_1_1medium", "RyanZombieB_Soldier_04_fmedium", "RyanZombieB_Soldier_04_f_1medium", "RyanZombieB_Soldier_04_f_1_1medium", "RyanZombieB_Soldier_lite_Fmedium", "RyanZombieB_Soldier_lite_F_1medium", "RyanZombieC_man_1slow", "RyanZombieC_man_polo_1_Fslow", "RyanZombieC_man_polo_2_Fslow", "RyanZombieC_man_polo_4_Fslow", "RyanZombieC_man_polo_5_Fslow", "RyanZombieC_man_polo_6_Fslow", "RyanZombieC_man_p_fugitive_Fslow", "RyanZombieC_man_w_worker_Fslow", "RyanZombieC_scientist_Fslow", "RyanZombieC_man_hunter_1_Fslow", "RyanZombieC_man_pilot_Fslow", "RyanZombieC_journalist_Fslow", "RyanZombieC_Orestesslow", "RyanZombieC_Nikosslow", "RyanZombieB_Soldier_02_fslow", "RyanZombieB_Soldier_02_f_1slow", "RyanZombieB_Soldier_02_f_1_1slow", "RyanZombieB_Soldier_03_fslow", "RyanZombieB_Soldier_03_f_1slow", "RyanZombieB_Soldier_03_f_1_1slow", "RyanZombieB_Soldier_04_fslow", "RyanZombieB_Soldier_04_f_1slow", "RyanZombieB_Soldier_04_f_1_1slow", "RyanZombieB_Soldier_lite_Fslow", "RyanZombieB_Soldier_lite_F_1slow", "RyanZombieSpider1", "RyanZombieSpider2", "RyanZombieSpider3", "RyanZombieSpider4", "RyanZombieSpider5", "RyanZombieSpider6", "RyanZombieSpider7", "RyanZombieSpider8", "RyanZombieSpider9", "RyanZombieSpider10", "RyanZombieSpider11", "RyanZombieSpider12", "RyanZombieSpider13", "RyanZombieSpider14"]
~ryanzombiesstart

#Ryanzombieslogicspawnmixedloop
if (ryanzombiesactivation == 0.7) then {goto "activationblufor"}
if (ryanzombiesactivation == 0.5) then {goto "activationopfor"}
if (ryanzombiesactivation == 0.3) then {goto "activationindep"}

#Ryanzombieslogicspawnmixednext
_grp = creategroup resistance
_x = 0
~1
if (isnull _grp) then {goto "Ryanzombieslogicspawnmixedloop"}

#Ryanzombieslogicspawnmixednextloop
_x = _x + 1
_random = _array select floor random count _array
if (ryanzombiescurrentamount > ryanzombiestotalamount) then {goto "end"}
if (ryanzombiescurrentamount < ryanzombiesamount) then {format ["%1",_random] createunit [position _logic, _grp, "this switchmove 'AmovPercMstpSnonWnonDnon_SaluteOut'; [this] exec '\ryanzombies\count.sqf'"]}
if (ryanzombiescurrentamount < ryanzombiesamount) then {ryanzombiescurrentamount = ryanzombiescurrentamount + 1}
~ryanzombiesdelay
if (_x < ryanzombieshordesize) then {goto "Ryanzombieslogicspawnmixednextloop"}
deletegroup _grp
~ryanzombiesfrequency
goto "Ryanzombieslogicspawnmixedloop"



#Ryanzombieslogicroam
Ryanzombieslogicroam = 1
goto "end"

#Ryanzombieslogicdelete
Ryanzombiesdelete = 1
goto "end"

#Ryanzombieslimit
if (isnil "Ryanzombieslimit") then {Ryanzombieslimit = 1}
~1 + random 2
Ryanzombieslimit = Ryanzombieslimit + 50
goto "end"

#ryanzombieswaypoint
Ryanzombieswaypoint = 1
ryanzombieslogicwaypoint = createTrigger ["EmptyDetector", getpos _logic]
goto "end"

#ryanzombieswaypointdemon
Ryanzombieswaypointdemon = 1
ryanzombieslogicwaypointdemon = createTrigger ["EmptyDetector", getpos _logic]
goto "end"

#ryanzombiesjump
Ryanzombiesjump = 1
goto "end"

#ryanzombiesdisablemoaning
ryanzombiesdisablemoaning = 1
goto "end"

#ryanzombiesdisableaggressive
ryanzombiesdisableaggressive = 1
goto "end"

#end