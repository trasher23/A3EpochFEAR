while {NukeWindActive} do {
	setwind [0.201112,0.204166,true];
	_ran = ceil random 2;
	_pos = position player;

	// Dust
	setwind [0.201112*2,0.204166*2,false];
	_velocity = [random 10,random 10,-1];
	_color = [1.0, 0.9, 0.8];
	_alpha = 0.02 + random 0.02;
	_ps = "#particlesource" createVehicleLocal _pos;  
	_ps setParticleParams [["\a3\data_f\ParticleEffects\Universal\universal.p3d", 16, 12, 8], "", "Billboard", 1, 3, [0, 0, -6], _velocity, 1, 1.275, 1, 0, [9], [_color + [0], _color + [_alpha], _color + [0]], [1000], 1, 0, "", "", _pos];
	_ps setParticleRandom [3, [30, 30, 0], [0, 0, 0], 1, 0, [0, 0, 0, 0.01], 0, 0];
	_ps setParticleCircle [0.1, [0, 0, 0]];
	_ps setDropInterval 0.01;

	sleep (random 1);
	_delay = 1 + random 5;
	sleep _delay;
	deletevehicle _ps;
};