// ------------
//	NUKE Blast
// ------------

while {(!isServer) && (true)} do {

    nukeDetonate = false;
    sleep 1;
      
    waitUntil {nukeDetonate};
	
	if (player distance nukeCoords < 4000) then {
		setAperture 2;

		"dynamicBlur" ppEffectEnable true;
		"dynamicBlur" ppEffectAdjust [0.5];
		"dynamicBlur" ppEffectCommit 3;

		sleep 0.1;

		"dynamicBlur" ppEffectAdjust [2];
		"dynamicBlur" ppEffectCommit 1;

		"dynamicBlur" ppEffectAdjust [1];
		"dynamicBlur" ppEffectCommit 4;
	};
	
	sleep 1;
	
	// -------------------------------------------------------------------------

	_Cone = "#particlesource" createVehicleLocal getPos nukeCoords;
	_Cone setParticleParams [["A3\Data_F\ParticleEffects\Universal\universal.p3d", 16, 7, 48], "", "Billboard", 1, 10, [0, 0, 0],
					[0, 0, 0], 0, 1.275, 1, 0, [40,80], [[0.25, 0.25, 0.25, 0], [0.25, 0.25, 0.25, 0.5], 
					[0.25, 0.25, 0.25, 0.5], [0.25, 0.25, 0.25, 0.05], [0.25, 0.25, 0.25, 0]], [0.25], 0.1, 1, "", "", nukeCoords];
	_Cone setParticleRandom [2, [1, 1, 30], [1, 1, 30], 0, 0, [0, 0, 0, 0.1], 0, 0];
	_Cone setParticleCircle [10, [-10, -10, 20]];
	_Cone setDropInterval 0.005;

	_top = "#particlesource" createVehicleLocal getPos nukeCoords;
	_top setParticleParams [["A3\Data_F\ParticleEffects\Universal\universal.p3d", 16, 3, 48, 0], "", "Billboard", 1, 21, [0, 0, 0],
					[0, 0, 65], 0, 1.7, 1, 0, [100,80,110], [[1, 1, 1, -10],[1, 1, 1, -7],[1, 1, 1, -4],[1, 1, 1, -0.5],[1, 1, 1, 0]], [0.05], 1, 1, "", "", nukeCoords];
	_top setParticleRandom [0, [75, 75, 15], [17, 17, 10], 0, 0, [0, 0, 0, 0], 0, 0, 360];
	_top setDropInterval 0.002;

	_top2 = "#particlesource" createVehicleLocal getPos nukeCoords;
	_top2 setParticleParams [["A3\Data_F\ParticleEffects\Universal\universal.p3d", 16, 3, 112, 0], "", "Billboard", 1, 22, [0, 0, 0],
					[0, 0, 60], 0, 1.7, 1, 0, [100,80,100], [[1, 1, 1, 0.5],[1, 1, 1, 0]], [0.07], 1, 1, "", "", nukeCoords];
	_top2 setParticleRandom [0, [75, 75, 15], [17, 17, 10], 0, 0, [0, 0, 0, 0], 0, 0, 360];
	_top2 setDropInterval 0.002;

	_smoke = "#particlesource" createVehicleLocal getPos nukeCoords;
	_smoke setParticleParams [["A3\Data_F\ParticleEffects\Universal\universal.p3d", 16, 7, 48, 1], "", "Billboard", 1, 25, [0, 0, 0],
					[0, 0, 70], 0, 1.7, 1, 0, [50,20,120], 
					[[1, 1, 1, 0.4],[1, 1, 1, 0.7],[1, 1, 1, 0.7],[1, 1, 1, 0.7],[1, 1, 1, 0.7],[1, 1, 1, 0.7],[1, 1, 1, 0.7],[1, 1, 1, 0]]
					, [0.5, 0.1], 1, 1, "", "", nukeCoords];
	_smoke setParticleRandom [0, [10, 10, 15], [15, 15, 7], 0, 0, [0, 0, 0, 0], 0, 0, 360];
	_smoke setDropInterval 0.002;

	_Wave = "#particlesource" createVehicleLocal getPos nukeCoords;
	_Wave setParticleParams [["A3\Data_F\ParticleEffects\Universal\universal.p3d", 16, 7, 48], "", "Billboard", 1, 20/2, [0, 0, 0],
					[0, 0, 0], 0, 1.5, 1, 0, [50, 100], [[0.1, 0.1, 0.1, 0.5], 
					[0.5, 0.5, 0.5, 0.5], [1, 1, 1, 0.3], [1, 1, 1, 0]], [1,0.5], 0.1, 1, "", "", nukeCoords];
	_Wave setParticleRandom [2, [20, 20, 20], [5, 5, 0], 0, 0, [0, 0, 0, 0.1], 0, 0];
	_Wave setParticleCircle [50, [-80, -80, 2.5]];
	_Wave setDropInterval 0.0002;

	_light = "#lightpoint" createVehicleLocal [((getPos nukeCoords select 0)),(getPos nukeCoords select 1),((getPos nukeCoords select 2)+800)];
	_light setLightAmbient[1500, 1200, 1000];
	_light setLightColor[1500, 1200, 1000];
	_light setLightBrightness 1000000.0;

	// -------------------------------------------------------------------------

	sleep 1;

	_Wave setDropInterval 0.001;
	deleteVehicle _top;
	deleteVehicle _top2;

	sleep 1;
	
	[] ExecVM "FEAR\NUKE\NUKEClientDamage.sqf";
	if (player distance nukeCoords < 2000) then {player say "nukenear"};
	if (player distance nukeCoords > 2000) then {player say "nukefar"};
	
	player spawn nukeQuake;
	
	sleep 1;
	setAperture -1;
	
	sleep 1;
	
	_top3 = "#particlesource" createVehicleLocal getPos nukeCoords;
	_top3 setParticleParams [["A3\Data_F\ParticleEffects\Universal\universal.p3d", 16, 3, 48, 0], "", "Billboard", 1, 24, [0, 0, 450],
					[0, 0, 49], 0, 1.7, 1, 0, [120,130,150], [[1, 1, 1, -10],[1, 1, 1, -7],[1, 1, 1, -4],[1, 1, 1, -0.5],[1, 1, 1, 0]], [0.05], 1, 1, "", "", nukeCoords];
	_top3 setParticleRandom [0, [75, 75, 15], [17, 17, 10], 0, 0, [0, 0, 0, 0], 0, 0, 360];
	_top3 setDropInterval 0.002;
	
	sleep 4;
	
	deleteVehicle _top3;

	sleep 4;

	if (player distance nukeCoords < 4000) then {
		"dynamicBlur" ppEffectAdjust [0];
		"dynamicBlur" ppEffectCommit 1;
	};

	_top4 = "#particlesource" createVehicleLocal getPos nukeCoords;
	_top4 setParticleParams [["A3\Data_F\ParticleEffects\Universal\universal.p3d", 16, 3, 48, 0], "", "Billboard", 1, 22, [0, 0, 770],
					[0, 0, 30], 0, 1.7, 1, 0, [100,120,140], [[1, 1, 1, -10],[1, 1, 1, -7],[1, 1, 1, -4],[1, 1, 1, -0.5],[1, 1, 1, 0]], [0.05], 1, 1, "", "", nukeCoords];
	_top4 setParticleRandom [0, [75, 75, 15], [17, 17, 10], 0, 0, [0, 0, 0, 0], 0, 0, 360];
	_top4 setDropInterval 0.002;
	
	sleep 3;

	_top4 setParticleParams [["A3\Data_F\ParticleEffects\Universal\universal.p3d", 16, 3, 48, 0], "", "Billboard", 1, 25, [0, 0, 830],
					[0, 0, 30], 0, 1.7, 1, 0, [100,120,140], [[1, 1, 1, -10],[1, 1, 1, -7],[1, 1, 1, -4],[1, 1, 1, -0.5],[1, 1, 1, 0]], [0.05], 1, 1, "", "", nukeCoords];



	_Wave setDropInterval 0.001*10;
	_Wave setParticleParams [["A3\Data_F\ParticleEffects\Universal\universal.p3d", 16, 7, 48], "", "Billboard", 1, 20/2, [0, 0, 0],
					[0, 0, 0], 0, 1.5, 1, 0, [50, 100], [[0.1, 0.1, 0.1, 0.5], 
					[0.5, 0.5, 0.5, 0.5], [1, 1, 1, 0.3], [1, 1, 1, 0]], [1,0.5], 0.1, 1, "", "", nukeCoords];
	_Wave setParticleCircle [50, [-40, -40, 2.5]];
	
	deleteVehicle _light;

	60 setRain 1;

	sleep 4;
	
	deleteVehicle _top4;

	_i = 0;
	while {_i < 100} do {
		_light setLightBrightness (100.0 - _i)/100;
		_i = _i + 1;
		sleep 0.1;
	};

	for "_i" from 0 to 15 do {
		_smoke setParticleParams [["A3\Data_F\ParticleEffects\Universal\universal.p3d", 16, 7, 48, 1], "", "Billboard", 1, 25, [0, 0, 0],
						[0, 0, 60+_i], 0, 1.7, 1, 0, [40,15,120], 
						[[1, 1, 1, 0.4],[1, 1, 1, 0.7],[1, 1, 1, 0.7],[1, 1, 1, 0.7],[1, 1, 1, 0.7],[1, 1, 1, 0.7],[1, 1, 1, 0.7],[1, 1, 1, 0]]
						, [0.5, 0.1], 1, 1, "", "", nukeCoords];
	};
	
	// Set nuclear environment
	player spawn nukeEnvironment;
	
	_timeNow = time;
	waitUntil {(time - _timeNow) > 180};

	_smoke setParticleParams [["A3\Data_F\ParticleEffects\Universal\universal.p3d", 16, 7, 48, 1], "", "Billboard", 1, 25, [0, 0, 0],
					[0, 0, 30], 0, 1.7, 1, 0, [40,25+10,80], 
					[[1, 1, 1, 0.2],[1, 1, 1, 0.3],[1, 1, 1, 0.3],[1, 1, 1, 0.3],[1, 1, 1, 0.3],[1, 1, 1, 0.3],[1, 1, 1, 0.3],[1, 1, 1, 0]]
					, [0.5, 0.1], 1, 1, "", "", nukeCoords];

	_smoke setDropInterval 0.012;
	_Cone setDropInterval 0.02;
	_Wave setDropInterval 0.01;

	sleep 900;
	
	deleteVehicle _Wave;
	deleteVehicle _cone;
	deleteVehicle _smoke;
	deleteVehicle snow;

	// Reset default environment
	player spawn defaultEnvironment;
};