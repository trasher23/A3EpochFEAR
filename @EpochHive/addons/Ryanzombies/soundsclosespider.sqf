_zombie = _this select 0

~random 1

if !(alive _zombie) then {goto "end"}

_array = ["ryanzombies\sounds\ryanzombiesaggressivespider1.ogg", "ryanzombies\sounds\ryanzombiesaggressivespider2.ogg", "ryanzombies\sounds\ryanzombiesaggressivespider3.ogg", "ryanzombies\sounds\ryanzombiesaggressivespider4.ogg", "ryanzombies\sounds\ryanzombiesaggressivespider5.ogg", "ryanzombies\sounds\ryanzombiesaggressivespider6.ogg", "ryanzombies\sounds\ryanzombiesaggressivespider7.ogg", "ryanzombies\sounds\ryanzombiesaggressivespider8.ogg", "ryanzombies\sounds\ryanzombiesaggressivespider9.ogg", "ryanzombies\sounds\ryanzombiesaggressivespider10.ogg", "ryanzombies\sounds\ryanzombiesaggressivespider11.ogg", "ryanzombies\sounds\ryanzombiesaggressivespider12.ogg", "ryanzombies\sounds\ryanzombiesaggressivespider13.ogg", "ryanzombies\sounds\ryanzombiesaggressivespider14.ogg", "ryanzombies\sounds\ryanzombiesaggressivespider15.ogg", "ryanzombies\sounds\ryanzombiesaggressivespider16.ogg", "ryanzombies\sounds\ryanzombiesaggressivespider17.ogg", "ryanzombies\sounds\ryanzombiesaggressivespider18.ogg", "ryanzombies\sounds\ryanzombiesaggressivespider19.ogg", "ryanzombies\sounds\ryanzombiesaggressivespider20.ogg", "ryanzombies\sounds\ryanzombiesaggressivespider21.ogg", "ryanzombies\sounds\ryanzombiesaggressivespider22.ogg", "ryanzombies\sounds\ryanzombiesaggressivespider23.ogg", "ryanzombies\sounds\ryanzombiesaggressivespider24.ogg", "ryanzombies\sounds\ryanzombiesaggressivespider25.ogg", "ryanzombies\sounds\ryanzombiesaggressivespider26.ogg", "ryanzombies\sounds\ryanzombiesaggressivespider27.ogg", "ryanzombies\sounds\ryanzombiesaggressivespider28.ogg", "ryanzombies\sounds\ryanzombiesaggressivespider29.ogg", "ryanzombies\sounds\ryanzombiesaggressivespider30.ogg", "ryanzombies\sounds\ryanzombiesaggressivespider31.ogg", "ryanzombies\sounds\ryanzombiesaggressivespider32.ogg"]

_random = _array select floor random count _array

playsound3d [format ["%1",_random], _zombie]

#end