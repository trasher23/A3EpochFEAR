_objecttank = _this select 0

~0.5

@if ((getpos _objecttank select 2) < 1) then {goto "next"}

#next
_throwarray = ["ryanzombies\sounds\vehicle_collision.wss", "ryanzombies\sounds\vehicle_drag_end.wss"]

_throwrandom = _throwarray select floor random count _throwarray
playsound3d [format ["%1",_throwrandom], _objectcar]