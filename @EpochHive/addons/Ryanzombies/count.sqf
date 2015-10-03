_zombie = _this select 0

_zombie allowdammage false

if (isnil "ryanzombiesdensity") then {goto "start"}

_zombie setpos [(getpos _zombie select 0) + random ryanzombiesdensity - random ryanzombiesdensity, (getpos _zombie select 1) + random ryanzombiesdensity - random ryanzombiesdensity]

#start
_zombie setdir random 360
~3.5
if (isnil "Ryanzombiesinvincible") then {_zombie allowdammage true}

#loop
if !(alive _zombie) then {goto "next"}
~10
goto "loop"

#next
ryanzombiesamount = ryanzombiesamount + 1