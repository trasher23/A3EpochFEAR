_objectcar = _this select 0

~0.5

if (random 7 < 1) then {[_objectcar] exec "\ryanzombies\caralarm.sqf"}
@if ((getpos _objectcar select 2) < 1) then {goto "next"}

#next
_throwarray = ["ryanzombies\sounds\vehicle_collision.wss", "ryanzombies\sounds\vehicle_drag_end.wss"]

_throwrandom = _throwarray select floor random count _throwarray
playsound3d [format ["%1",_throwrandom], _objectcar]