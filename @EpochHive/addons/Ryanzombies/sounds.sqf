_zombie = _this select 0

~1 + random 20
_array = ["ryanzombiesmoan1","ryanzombiesmoan2","ryanzombiesmoan3","ryanzombiesmoan4"]

#loop
if !(alive _zombie) then {goto "dead"}
if !(isnil "ryanzombiesdisablemoaning") then {goto "next"}

_random = _array select floor random count _array
_zombie say3d format ["%1",_random]

#next
~30 + random 10
goto "loop"

#dead