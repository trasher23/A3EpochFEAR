_zombie = _this select 0

~random 1

if !(alive _zombie) then {goto "end"}

_array = ["ryanzombies\sounds\ryanzombiesaggressiveboss1.ogg", "ryanzombies\sounds\ryanzombiesaggressiveboss2.ogg", "ryanzombies\sounds\ryanzombiesaggressiveboss3.ogg", "ryanzombies\sounds\ryanzombiesaggressiveboss4.ogg", "ryanzombies\sounds\ryanzombiesaggressiveboss5.ogg", "ryanzombies\sounds\ryanzombiesaggressiveboss6.ogg", "ryanzombies\sounds\ryanzombiesaggressiveboss7.ogg", "ryanzombies\sounds\ryanzombiesaggressiveboss8.ogg"]

_random = _array select floor random count _array

playsound3d [format ["%1",_random], _zombie]

#end