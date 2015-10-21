private ["_nukeGeiger","_nukePos"];
	
_nukeGeiger = MISSION_directory + "FEAR\fx\" + "geiger.ogg";
_nukePos = _this select 0;

playSound3D [_nukeGeiger, player, false, _nukePos, 2];

NUKEGeiger = nil;