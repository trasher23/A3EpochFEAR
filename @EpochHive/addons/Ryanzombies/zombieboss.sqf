_zombie = _this select 0

_zombie setdammage 0.7
_zombie setspeaker "NoVoice"
_zombie enableFatigue false
_zombie setbehaviour "CARELESS"
_zombie setunitpos "UP"
_zombie setmimic "dead"

_group = group _zombie
_group setCombatMode "BLUE"
_group allowFleeing 0
_group enableAttack false

~1 + random 1

if !(isServer) then {goto "end"}
if (isnil "Ryanzombieslimit") then {Ryanzombieslimit = 99999}
if (isnil "Ryanzombieshealthdemon") then {Ryanzombieshealthdemon = 0.7}
_zombie setdammage Ryanzombieshealthdemon

if !(isnil "Ryanzombiesinvincibledemon") then {_zombie allowdammage false}
if !(isnil "ryanzombiesdeletion") then {[_zombie] exec "\ryanzombies\deldemons.sqf"}

_sound = 0
_attackarray = ["ryanzombies\sounds\ryanzombiesattack1boss.ogg", "ryanzombies\sounds\ryanzombiesattack2boss.ogg", "ryanzombies\sounds\ryanzombiesattack3boss.ogg", "ryanzombies\sounds\ryanzombiesattack4boss.ogg", "ryanzombies\sounds\ryanzombiesattack5boss.ogg"]
_jumparray = ["ryanzombies\sounds\ryanzombiesleap1.ogg", "ryanzombies\sounds\ryanzombiesleap2.ogg", "ryanzombies\sounds\ryanzombiesleap3.ogg", "ryanzombies\sounds\ryanzombiesleap4.ogg", "ryanzombies\sounds\ryanzombiesleap5.ogg", "ryanzombies\sounds\ryanzombiesleap6.ogg"]
_collisionarray = ["ryanzombies\sounds\collision1.ogg", "ryanzombies\sounds\collision2.ogg", "ryanzombies\sounds\collision3.ogg", "ryanzombies\sounds\collision4.ogg"]
_throwarray = ["ryanzombies\sounds\vehicle_collision.wss", "ryanzombies\sounds\vehicle_drag_end.wss"]
_eathitarray = ["ryanzombies\sounds\ryanzombieseathitboss1.ogg", "ryanzombies\sounds\ryanzombieseathitboss2.ogg"]



#start
_zombie setFormDir random 360
if !(isnil "Ryanzombieslogicroam") then {_zombie domove [(position _zombie select 0) + random 15 - random 15, (position _zombie select 1) + random 15 - random 15]}
if !(isnil "ryanzombieswaypointdemon") then {_zombie domove [(position ryanzombieslogicwaypointdemon select 0) + random 15 - random 15, (position ryanzombieslogicwaypointdemon select 1) + random 15 - random 15]}
_a = 0
_b = 5 + random 3



#findtarget
if !(alive _zombie) then {goto "dead"}
_civilian = nearestobjects [_zombie, ["CIVILIAN"], 100]
{if !(alive _x) then {_civilian = _civilian - [_x]}} foreach _civilian
_target = _zombie findNearestEnemy _zombie
if (count _civilian != 0) then {goto "civilian"}
if !(isnull _target) then {goto "move"}
~1
_a = _a + 1
if (_a < _b) then {goto "findtarget"}
goto "start"



#wait
~2
goto "findtarget"



#civilian
_civiliantarget = _civilian select 0
if (!(isnull _target) AND ((_target distance _zombie) < (_civiliantarget distance _zombie))) then {goto "move"}
if (_zombie knowsabout _civiliantarget > 0.5) then {_target = _civiliantarget}
if !(isnull _target) then {goto "move"}
~1
goto "findtarget"



#move
if ((((getPosASL _target) select 2) - ((getPosASL _zombie) select 2)) > 25 AND _target iskindof "AIR") then {goto "wait"}
if (_zombie distance _target > Ryanzombieslimit) then {goto "wait"}

_zombie domove getposATL _target
_zombie dowatch _target
_target setsuppression 1
_target allowfleeing 1

if ((vehicle _target iskindof "man") && _zombie distance _target < 4) then {goto "attack"}
if ((vehicle _target iskindof "car") && _zombie distance _target < 7) then {goto "attackcar"}
if ((vehicle _target iskindof "tank") && _zombie distance _target < 8) then {goto "attacktank"}
if ((vehicle _target iskindof "air") && _zombie distance _target < 10) then {goto "attackair"}
if ((vehicle _target iskindof "staticweapon" OR vehicle _target iskindof "ship") && _zombie distance _target < 5) then {goto "attackother"}

if ((_sound < 1) && (isnil "ryanzombiesdisableaggressive")) then {[_zombie] exec "\ryanzombies\soundscloseboss.sqf"}
_sound = _sound + 1
if (_sound > 5) then {_sound = 0}

~0.5 + (_zombie distance _target)/100 min 4

if (isnil "Ryanzombiescanthrow") then {goto "move2"}
_objectcar = nearestObject [_zombie, "car"]
if ((_objectcar iskindof "car") && (_zombie distance _objectcar < _zombie distance _target) && (_objectcar distance _target < _zombie distance _target) && (_objectcar distance _target < Ryanzombiescanthrowdistance) && (random 7 < 1)) then {goto "throwcar"}

#move2
if (isnil "Ryanzombiescanthrowtank") then {goto "move3"}
_objecttank = nearestObject [_zombie, "tank"]
if ((_objecttank iskindof "tank") && (_zombie distance _objecttank < _zombie distance _target) && (_objecttank distance _target < _zombie distance _target) && (_objecttank distance _target < Ryanzombiescanthrowtankdistance) && (random 7 < 1)) then {goto "throwtank"}

#move3
if (isnil "Ryanzombiesjump") then {goto "findtarget"}
if ((_zombie distance _target > 45) && (alive _zombie) && (alive _target) && (!surfaceIsWater position _zombie) && (random 10 < 1)) then {goto "jump"}
goto "findtarget"



#throwcar
if !(alive _zombie) then {goto "dead"}
if !(alive _target) then {goto "findtarget"}
_target = _zombie findNearestEnemy _zombie
if (isnull _target) then {goto "findtarget"}

if ((_objectcar distance _target > Ryanzombiescanthrowdistance) OR (_zombie distance _objectcar > _zombie distance _target) OR (_objectcar distance _target > _zombie distance _target)) then {goto "move"}
if (_zombie distance _objectcar < 7) then {goto "throwcar2"}
_zombie domove position _objectcar
~0.5 + (_zombie distance _objectcar)/50 min 4
goto "throwcar"

#throwcar2
[[_zombie, "AwopPercMstpSgthWnonDnon_throw"], "switchmove"] call BIS_fnc_MP
_zombie setdir ([_zombie, _objectcar] call BIS_fnc_dirTo)

_pos = position _objectcar
_dir = ((_pos select 0) - (getpos _zombie select 0)) atan2 ((_pos select 1) - (getpos _zombie select 1))
_zombie setpos [(_pos select 0) - 4*sin _dir, (_pos select 1) - 4*cos _dir]

_attackrandom = _attackarray select floor random count _attackarray
playsound3d [format ["%1",_attackrandom], _zombie]
~0.3
if !(alive _zombie) then {goto "dead"}
_speed = 20 + random 25
_dir = ((getpos _target select 0) - (getpos _objectcar select 0)) atan2 ((getpos _target select 1) - (getpos _objectcar select 1))
_range = _objectcar distance _target
_objectcar setvelocity [_speed * (sin _dir), _speed * (cos _dir), 5 * (_range / _speed)]

_throwrandom = _throwarray select floor random count _throwarray
playsound3d [format ["%1",_throwrandom], _objectcar]

_objectcar setfuel 0
[_objectcar] exec "\ryanzombies\carland.sqf"
~0.25
goto "findtarget"



#throwtank
if !(alive _zombie) then {goto "dead"}
if !(alive _target) then {goto "findtarget"}
_target = _zombie findNearestEnemy _zombie
if (isnull _target) then {goto "findtarget"}

if ((_objecttank distance _target > Ryanzombiescanthrowtankdistance) OR (_zombie distance _objecttank > _zombie distance _target) OR (_objecttank distance _target > _zombie distance _target)) then {goto "move"}
if (_zombie distance _objecttank < 8) then {goto "throwtank2"}
_zombie domove position _objecttank
~0.5 + (_zombie distance _objecttank)/50 min 4
goto "throwtank"

#throwtank2
[[_zombie, "AwopPercMstpSgthWnonDnon_throw"], "switchmove"] call BIS_fnc_MP
_zombie setdir ([_zombie, _objecttank] call BIS_fnc_dirTo)

_pos = position _objecttank
_dir = ((_pos select 0) - (getpos _zombie select 0)) atan2 ((_pos select 1) - (getpos _zombie select 1))
_zombie setpos [(_pos select 0) - 4*sin _dir, (_pos select 1) - 4*cos _dir]

_attackrandom = _attackarray select floor random count _attackarray
playsound3d [format ["%1",_attackrandom], _zombie]
~0.3
if !(alive _zombie) then {goto "dead"}
_speed = 20 + random 25
_dir = ((getpos _target select 0) - (getpos _objecttank select 0)) atan2 ((getpos _target select 1) - (getpos _objecttank select 1))
_range = _objecttank distance _target
_objecttank setvelocity [_speed * (sin _dir), _speed * (cos _dir), 5 * (_range / _speed)]

_throwrandom = _throwarray select floor random count _throwarray
playsound3d [format ["%1",_throwrandom], _objecttank]

[_objecttank] exec "\ryanzombies\tankland.sqf"
~0.25
goto "findtarget"



#jump
_heightzombie = getTerrainHeightASL (position _zombie)
_heighttarget = getTerrainHeightASL (position _target)
_highzombie = _heightzombie + 20
_hightarget = _heighttarget + 40

if (_highzombie < _heighttarget) then {goto "findtarget"}
if (_hightarget < _heightzombie) then {goto "findtarget"}

_zombie disableAI "MOVE"

_basespeed = 8 + random 2
_extraspeed = (_zombie distance _target)/8 min 60

_jumprandom = _jumparray select floor random count _jumparray
playsound3d [format ["%1",_jumprandom], _zombie]
~0.15
_zombie setdir ([_zombie, _target] call BIS_fnc_dirTo)
_dir = ((getpos _target select 0) - (getpos _zombie select 0)) atan2 ((getpos _target select 1) - (getpos _zombie select 1))
_zombie setvelocity [(_basespeed + _extraspeed) * (sin _dir), (_basespeed + _extraspeed) * (cos _dir), 12 + random 6]

~1

_zombie allowdammage false
@if ((getpos _zombie select 2) < 1) then {goto "jump2"}

#jump2
_zombie enableAI "MOVE"
~1
if (isnil "Ryanzombiesinvincibledemon") then {_zombie allowdammage true}
goto "findtarget"



#attack
_zombie setdir ([_zombie, _target] call BIS_fnc_dirTo)
[[_zombie, "AwopPercMstpSgthWnonDnon_throw"], "switchmove"] call BIS_fnc_MP

_attackrandom = _attackarray select floor random count _attackarray
playsound3d [format ["%1",_attackrandom], _zombie]
~0.3
if (_zombie distance _target < 4 && (alive _target) && (alive _zombie)) then {goto "damage"}
~0.25
goto "findtarget"

#damage
if (isClass(configFile >> "CfgPatches" >> "ace_main")) then {[_target] execVM "\ryanzombies\acedamage.sqf"} else {_target setdamage (damage _target + 0.3)}
if !(alive _target) then {[_target, _zombie] exec "\ryanzombies\infection.sqf"}
[_target] exec "\ryanzombies\scream.sqf"

_eathitrandom = _eathitarray select floor random count _eathitarray
playsound3d [format ["%1",_eathitrandom], _target]

_vel = velocity _target
_dir = direction _zombie
_target setvelocity [(_vel select 0) + (sin _dir * 3 + random 2), (_vel select 1) + (cos _dir * 3 + random 2), (_vel select 2) + 1 + random 2]
~0.25
goto "findtarget"



#attackcar
_zombie setdir ([_zombie, _target] call BIS_fnc_dirTo)
[[_zombie, "AwopPercMstpSgthWnonDnon_throw"], "switchmove"] call BIS_fnc_MP

_pos = position _target
_dir = ((_pos select 0) - (getpos _zombie select 0)) atan2 ((_pos select 1) - (getpos _zombie select 1))
if (speed _target < 5) then {_zombie setpos [(_pos select 0) - 4*sin _dir, (_pos select 1) - 4*cos _dir]}

_attackrandom = _attackarray select floor random count _attackarray
playsound3d [format ["%1",_attackrandom], _zombie]
~0.3
if (_zombie distance _target < 7 && (alive _zombie)) then {goto "damagecar"}
~0.4
goto "findtarget"

#damagecar
_target setdamage (damage _target + 0.1)

_collisionrandom = _collisionarray select floor random count _collisionarray
playsound3d [format ["%1",_collisionrandom], _target]

_vel = velocity _target
_dir = direction _zombie
_target setvelocity [(_vel select 0) + (sin _dir * 4 + random 2), (_vel select 1) + (cos _dir * 4 + random 2), (_vel select 2) + 1 + random 2]
~0.4
goto "findtarget"



#attacktank
_zombie setdir ([_zombie, _target] call BIS_fnc_dirTo)
[[_zombie, "AwopPercMstpSgthWnonDnon_throw"], "switchmove"] call BIS_fnc_MP

_pos = position _target
_dir = ((_pos select 0) - (getpos _zombie select 0)) atan2 ((_pos select 1) - (getpos _zombie select 1))
if (speed _target < 5) then {_zombie setpos [(_pos select 0) - 4*sin _dir, (_pos select 1) - 4*cos _dir]}

_attackrandom = _attackarray select floor random count _attackarray
playsound3d [format ["%1",_attackrandom], _zombie]
~0.3
if (_zombie distance _target < 8 && (alive _zombie)) then {goto "damagetank"}
~0.5
goto "findtarget"

#damagetank
_target setdamage (damage _target + 0.06)

_collisionrandom = _collisionarray select floor random count _collisionarray
playsound3d [format ["%1",_collisionrandom], _target]

_vel = velocity _target
_dir = direction _zombie
_target setvelocity [(_vel select 0) + (sin _dir * 3 + random 2), (_vel select 1) + (cos _dir * 3 + random 2), (_vel select 2) + 1 + random 2]
~0.5
goto "findtarget"



#attackair
_zombie setdir ([_zombie, _target] call BIS_fnc_dirTo)
[[_zombie, "AwopPercMstpSgthWnonDnon_throw"], "switchmove"] call BIS_fnc_MP

_pos = position _target
_dir = ((_pos select 0) - (getpos _zombie select 0)) atan2 ((_pos select 1) - (getpos _zombie select 1))
_zombie setpos [(_pos select 0) - 4*sin _dir, (_pos select 1) - 4*cos _dir]

_attackrandom = _attackarray select floor random count _attackarray
playsound3d [format ["%1",_attackrandom], _zombie]
~0.3
if (_zombie distance _target < 10 && (alive _zombie)) then {goto "damageair"}
~0.45
goto "findtarget"

#damageair
_target setdamage (damage _target + 0.075)

_collisionrandom = _collisionarray select floor random count _collisionarray
playsound3d [format ["%1",_collisionrandom], _target]

_vel = velocity _target
_dir = direction _zombie
_target setvelocity [(_vel select 0) + (sin _dir * 3 + random 2), (_vel select 1) + (cos _dir * 3 + random 2), (_vel select 2) + 1 + random 2]
~0.45
goto "findtarget"



#attackother
_zombie setdir ([_zombie, _target] call BIS_fnc_dirTo)
[[_zombie, "AwopPercMstpSgthWnonDnon_throw"], "switchmove"] call BIS_fnc_MP

_pos = position _target
_dir = ((_pos select 0) - (getpos _zombie select 0)) atan2 ((_pos select 1) - (getpos _zombie select 1))
_zombie setpos [(_pos select 0) - 2*sin _dir, (_pos select 1) - 2*cos _dir]

_attackrandom = _attackarray select floor random count _attackarray
playsound3d [format ["%1",_attackrandom], _zombie]
~0.3
if (_zombie distance _target < 4.5 && (alive _zombie)) then {goto "damageother"}
~0.25
goto "findtarget"

#damageother
if (vehicle _target iskindof "staticweapon") then {_target setdamage (damage _target + 0.15)}
if (vehicle _target iskindof "ship") then {_target setdamage (damage _target + 0.1)}

_eathitrandom = _eathitarray select floor random count _eathitarray
playsound3d [format ["%1",_eathitrandom], _target]

_vel = velocity _target
_dir = direction _zombie
_target setvelocity [(_vel select 0) + (sin _dir * 3 + random 2), (_vel select 1) + (cos _dir * 3 + random 2), (_vel select 2) + 1 + random 2]
~0.25
goto "findtarget"



#dead
_newgroup = creategroup civilian
[_zombie] join _newgroup
~70 + random 40
deletegroup _newgroup
deletegroup _group
{if (count units _x == 0) then {deletegroup _x}} foreach allgroups
if !(isnil "Ryanzombiesdelete") then {deletevehicle _zombie}

#end