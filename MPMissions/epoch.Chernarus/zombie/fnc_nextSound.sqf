private ["_zombie", "_type"];
_zombie = _this select 0;
_type = _this select 1;

if (_type == "idle") then {
	_select = ["1","2","3","4","5"] call BIS_fnc_selectRandom;
	_say = format["zidle%1",_select];
	_zombie say3D _say;
};
if (_type == "hurt") then {
	_select = ["1","2","3"] call BIS_fnc_selectRandom;
	_say = format["zhurt%1",_select];
	_zombie say3D _say;
};
if (_type == "punch") then {
	_select = ["1","2","3","4"] call BIS_fnc_selectRandom;
	_say = format["zpunch%1",_select];
	_zombie say3D _say;
};