FEAR_fnc_nukeBlast = {
	if (player distance nukeCoords < 4000) then {
		setAperture 2;

		"dynamicBlur" ppEffectEnable true;
		"dynamicBlur" ppEffectAdjust [0.5];
		"dynamicBlur" ppEffectCommit 3;

		uisleep 0.1;

		"dynamicBlur" ppEffectAdjust [2];
		"dynamicBlur" ppEffectCommit 1;

		"dynamicBlur" ppEffectAdjust [1];
		"dynamicBlur" ppEffectCommit 4;
	};

	uisleep 0.5;

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

	uisleep 0.5;

	_Wave setDropInterval 0.001;
	deleteVehicle _top;
	deleteVehicle _top2;

	uisleep 0.5;

	_nukeSound =  MISSION_Directory + "FEAR\fx\" + "nuke.ogg";
	playSound3D [_nukeSound,player,false,nukeCoords];

	player spawn FEAR_fnc_clientDamage;
	player spawn nukeQuake;

	uisleep 0.5;

	setAperture -1;

	uisleep 0.5;

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

nukeQuake = {
	for "_i" from 0 to 140 do {
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
		
		[player, 0, 0] call BIS_fnc_setPitchBank;
	};
};

nukeWind = {
	while {windv} do {
		waituntil {isplayer player};
		setwind [0.201112,0.204166,true];
		while {true} do {
			_ran = ceil random 5;
			playsound format ["wind_%1",_ran];
			_obj = vehicle player;
			_pos = position _obj;

			//--- Dust
			setwind [0.201112*2,0.204166*2,false];
			_velocity = [random 10,random 10,-1];
			_color = [1.0, 0.9, 0.8];
			_alpha = 0.02 + random 0.02;
			_ps = "#particlesource" createVehicleLocal _pos;  
			_ps setParticleParams [["A3\Data_F\ParticleEffects\Universal\universal.p3d", 16, 12, 8], "", "Billboard", 1, 3, [0, 0, -6], _velocity, 1, 1.275, 1, 0, [9], [_color + [0], _color + [_alpha], _color + [0]], [1000], 1, 0, "", "", _obj];
			_ps setParticleRandom [3, [30, 30, 0], [0, 0, 0], 1, 0, [0, 0, 0, 0.01], 0, 0];
			_ps setParticleCircle [0.1, [0, 0, 0]];
			_ps setDropInterval 0.01;

			sleep (random 1);
			deletevehicle _ps;
			_delay = 10 + random 20;
			sleep _delay;
		};
	};
};

nukeEnvironment = {
	if (viewDistance < 3500) then {setViewDistance 3500};
	_hndl = ppEffectCreate ["colorCorrections", 1501];
	// Flash
	_hndl ppEffectAdjust [2, 30, 0, [0.0, 0.0, 0.0, 0.0], [0.8*2, 0.5*2, 0.0, 0.7], [0.9, 0.9, 0.9, 0.0]];
	_hndl ppEffectCommit 0;
	// Wasteland filters
	_hndl ppEffectAdjust [1, 0.8, -0.001, [0.0, 0.0, 0.0, 0.0], [0.8*2, 0.5*2, 0.0, 0.7], [0.9, 0.9, 0.9, 0.0]];
	_hndl ppEffectCommit 3;
	_hndl ppEffectEnable true;

	"filmGrain" ppEffectEnable true; 
	"filmGrain" ppEffectAdjust [0.02, 1, 1, 0.1, 1, false];
	"filmGrain" ppEffectCommit 5;
	
	player spawn nukeAsh;
	windv=true;
	player spawn nukeWind;
	30 setOvercast 0.8;
};

defaultEnvironment = {
	_hndl = ppEffectCreate ["colorCorrections", 1501];
	_hndl ppEffectAdjust[1,1,0,[0,-0.12,0.05,0.03],[0,0,0,1.23],[-0.11,-0.11,-0.11,0]];
	_hndl ppEffectCommit 0;
	_hndl ppEffectEnable true;
	"filmGrain" ppEffectAdjust [0.0225, 1, 1, 0.1, 1, true];
	"filmGrain" ppEffectCommit 0;
	
	// broadcast nuke environment to account for JIP
	nukeEnvironActive = false;
	publicVariable "nukeEnvironActive";
	
	300 setOvercast 0;	
	windv=false;
	setWind [0,0,true];
};

nukeAsh = {
	waitUntil {isPlayer player};
    _pos = position player;
    _parray = [
    /* 00 */        ["A3\Data_F\ParticleEffects\Universal\universal.p3d", 16, 12, 8, 1],//"\Ca\Data\cl_water",
    /* 01 */        "",
    /* 02 */        "Billboard",
    /* 03 */        1,
    /* 04 */        4,
    /* 05 */        [0,0,0],
    /* 06 */        [0,0,0],
    /* 07 */        1,
    /* 08 */        0.000001,
    /* 09 */        0,
    /* 10 */        1.4,
    /* 11 */        [0.05,0.05],
    /* 12 */        [[0.1,0.1,0.1,1]],
    /* 13 */        [0,1],
    /* 14 */        0.2,
    /* 15 */        1.2,
    /* 16 */        "",
    /* 17 */        "",
    /* 18 */        vehicle player
    ];
	
	snow = "#particlesource" createVehicleLocal _pos;  
	snow setParticleParams _parray;
	snow setParticleRandom [0, [10, 10, 7], [0, 0, 0], 0, 0.01, [0, 0, 0, 0.1], 0, 0];
	snow setParticleCircle [0.0, [0, 0, 0]];
	snow setDropInterval 0.01;
	
	_oldPlayer = vehicle player;
	
	while {true} do {
	        waitUntil {vehicle player != _oldPlayer};
	        _parray set [18,vehicle player];
	        _snow setParticleParams _parray;
	        _oldPlayer = vehicle player;
    	};
};

FEAR_fnc_clientDamage = {
	private["_isinbuilding","_building"];
	
	_isinbuilding = false;
	_building = nearestObject [player, "Building"];
	
	if([player,_building] call fnc_isInsideBuilding) then {_isinbuilding = true};

	// If player is within nukeRadius and not in a building, then instant death
	if ((player distance nukeCoords < nukeRadius) && (!_isinbuilding)) then {
		player setDamage 1;
	};

	// If player is within nukeRadius and in a building, then incur heavy damage
	if ((player distance nukeCoords < nukeRadius) && (_isinbuilding)) then {
		r_player_timeout = 15;
		r_player_unconscious = true;
		r_player_injured = true;
		r_player_blood = 6000;
		player setVariable ["medForceUpdate",true,true];
		player setVariable ["unconsciousTime", r_player_timeout, true];
	};
};