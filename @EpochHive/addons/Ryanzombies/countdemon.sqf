_zombie = _this select 0

_zombie allowdammage false

if (isnil "ryanzombiesdensitydemon") then {goto "start"}

_zombie setpos [(getpos _zombie select 0) + random ryanzombiesdensitydemon - random ryanzombiesdensitydemon, (getpos _zombie select 1) + random ryanzombiesdensitydemon - random ryanzombiesdensitydemon]

#start
_zombie setdir random 360
~3
if (isnil "Ryanzombiesinvincibledemon") then {_zombie allowdammage true}

#loop
if !(alive _zombie) then {goto "next"}
~10
goto "loop"

#next
ryanzombiesamountdemon = ryanzombiesamountdemon + 1