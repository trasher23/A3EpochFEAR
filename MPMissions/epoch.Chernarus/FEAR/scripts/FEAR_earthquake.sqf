_sound = MISSION_directory + "FEAR\fx\earthquake.ogg";
playSound3D [_sound, player];

for "_i" from 0 to 300 do {
	_vx = vectorUp _this select 0;
	_vy = vectorUp _this select 1;
	_vz = vectorUp _this select 2;
	_coe = 0.03 - (0.0001 * _i);
	_this setVectorUp [
		_vx+(-_coe+random (2*_coe)),
		_vy+(-_coe+random (2*_coe)),
		_vz+(-_coe+random (2*_coe))
	];
	sleep (0.01 + random 0.01);
};
sleep 1;
[player, 0, 0] call BIS_fnc_setPitchBank;
