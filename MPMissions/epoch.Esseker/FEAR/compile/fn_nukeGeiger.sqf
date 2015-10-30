private ["_nukeGeiger","_nukePos"];
	
_nukePos = _this select 0;
_nukeGeiger = MISSION_directory + "FEAR\fx\" + "geiger.ogg";

playSound3D [_nukeGeiger,player,false,_nukePos,2];