_target = _this select 0

_array = ["ryanzombiesscream1", "ryanzombiesscream2", "ryanzombiesscream3", "ryanzombiesscream4", "ryanzombiesscream5"]
_random = _array select floor random count _array

[[_target, format ["%1",_random]], "say3d"] call BIS_fnc_MP