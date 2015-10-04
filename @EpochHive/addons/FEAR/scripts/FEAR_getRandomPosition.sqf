/*
	Find random position from original_pos, within _min/_max range
*/
private["_arr","_player","_pos","_min","_max"];

_arr = _this;
_player = _arr select 0;
_pos = _arr select 1;
_min = _arr select 2;
_max = _arr select 3;
RandomPosition = nil;

RandomPosition = [_pos,[_min,_max],random 360] call A3EAI_SHK_pos;
(owner (vehicle _player)) publicVariableClient "RandomPosition";