/*
	Nuke Client Functions
*/

FEAR_fnc_nukeBlast = {
	_Cone = "#particlesource" createVehicleLocal getpos nukeCoords;
	_Cone setParticleParams [["A3\Data_F\ParticleEffects\Universal\universal.p3d", 16, 7, 48], "", "Billboard", 1, 10, [0, 0, 0],
					[0, 0, 0], 0, 1.275, 1, 0, [40,80], [[0.25, 0.25, 0.25, 0], [0.25, 0.25, 0.25, 0.5], 
					[0.25, 0.25, 0.25, 0.5], [0.25, 0.25, 0.25, 0.05], [0.25, 0.25, 0.25, 0]], [0.25], 0.1, 1, "", "", nukeCoords];
	_Cone setParticleRandom [2, [1, 1, 30], [1, 1, 30], 0, 0, [0, 0, 0, 0.1], 0, 0];
	_Cone setParticleCircle [10, [-10, -10, 20]];
	_Cone setDropInterval 0.005;

	_top = "#particlesource" createVehicleLocal getpos nukeCoords;
	_top setParticleParams [["A3\Data_F\ParticleEffects\Universal\universal.p3d", 16, 3, 48, 0], "", "Billboard", 1, 20, [0, 0, 0],
					[0, 0, 60], 0, 1.7, 1, 0, [60,80,100], [[1, 1, 1, -10],[1, 1, 1, -7],[1, 1, 1, -4],[1, 1, 1, -0.5],[1, 1, 1, 0]], [0.05], 1, 1, "", "", nukeCoords];
	_top setParticleRandom [0, [75, 75, 15], [17, 17, 10], 0, 0, [0, 0, 0, 0], 0, 0, 360];
	_top setDropInterval 0.002;

	_top2 = "#particlesource" createVehicleLocal getpos nukeCoords;
	_top2 setParticleParams [["A3\Data_F\ParticleEffects\Universal\universal.p3d", 16, 3, 112, 0], "", "Billboard", 1, 20, [0, 0, 0],
					[0, 0, 60], 0, 1.7, 1, 0, [60,80,100], [[1, 1, 1, 0.5],[1, 1, 1, 0]], [0.07], 1, 1, "", "", nukeCoords];
	_top2 setParticleRandom [0, [75, 75, 15], [17, 17, 10], 0, 0, [0, 0, 0, 0], 0, 0, 360];
	_top2 setDropInterval 0.002;

	_smoke = "#particlesource" createVehicleLocal getpos nukeCoords;
	_smoke setParticleParams [["A3\Data_F\ParticleEffects\Universal\universal.p3d", 16, 7, 48, 1], "", "Billboard", 1, 25, [0, 0, 0],
					[0, 0, 60], 0, 1.7, 1, 0, [40,15,120], 
					[[1, 1, 1, 0.4],[1, 1, 1, 0.7],[1, 1, 1, 0.7],[1, 1, 1, 0.7],[1, 1, 1, 0.7],[1, 1, 1, 0.7],[1, 1, 1, 0.7],[1, 1, 1, 0]]
					, [0.5, 0.1], 1, 1, "", "", nukeCoords];
	_smoke setParticleRandom [0, [10, 10, 15], [15, 15, 7], 0, 0, [0, 0, 0, 0], 0, 0, 360];
	_smoke setDropInterval 0.002;

	_Wave = "#particlesource" createVehicleLocal getpos nukeCoords;
	_Wave setParticleParams [["A3\Data_F\ParticleEffects\Universal\universal.p3d", 16, 7, 48], "", "Billboard", 1, 20, [0, 0, 0],
					[0, 0, 0], 0, 1.5, 1, 0, [50, 100], [[0.1, 0.1, 0.1, 0.5], 
					[0.5, 0.5, 0.5, 0.5], [1, 1, 1, 0.3], [1, 1, 1, 0]], [1,0.5], 0.1, 1, "", "", nukeCoords];
	_Wave setParticleRandom [2, [20, 20, 20], [5, 5, 0], 0, 0, [0, 0, 0, 0.1], 0, 0];
	_Wave setParticleCircle [50, [-80, -80, 2.5]];
	_Wave setDropInterval 0.0002;


	_light = "#lightpoint" createVehicleLocal [((getpos nukeCoords select 0)),(getpos nukeCoords select 1),((getpos nukeCoords select 2)+500)];
	_light setLightAmbient[1500, 1200, 1000];
	_light setLightColor[1500, 1200, 1000];
	_light setLightBrightness 100000.0;

	//*******************************************************************

	if (mdh_nuke_colorcorrection > 0) then
	{
		// COLORCORRECTION
		execVM "nuke\colorcorrection.sqf";
	}
	else
	{
		// FLASH
		execVM "nuke\flash.sqf";
	};

	// EARTHQUAKE
	execVM "nuke\earthquake.sqf";

	// ASH
	execVM "nuke\ash.sqf";

	// NUKE DESTRUCTION ZONE, USE ZERO/0 AS PARAMETER TO DEACTIVATE DESTRUCTION
	call compile preprocessfilelinenumbers "nuke\nuke_damage.sqf";

	_Wave setDropInterval 0.001;
	deletevehicle _top;
	deletevehicle _top2;

	sleep 4.5;

	_i = 0;
	while {_i < 100} do
	{
		_light setLightBrightness 100.0 - _i;
		_i = _i + 1;
		sleep 0.1;
	};
	deleteVehicle _light;

	sleep 2;

	_smoke setParticleParams [["A3\Data_F\ParticleEffects\Universal\universal.p3d", 16, 7, 48, 1], "", "Billboard", 1, 25, [0, 0, 0],
					[0, 0, 45], 0, 1.7, 1, 0, [40,25,80], 
					[[1, 1, 1, 0.2],[1, 1, 1, 0.3],[1, 1, 1, 0.3],[1, 1, 1, 0.3],[1, 1, 1, 0.3],[1, 1, 1, 0.3],[1, 1, 1, 0.3],[1, 1, 1, 0]]
					, [0.5, 0.1], 1, 1, "", "", nukeCoords];

	_Cone setDropInterval 0.01;
	_smoke setDropInterval 0.006;
	_Wave setDropInterval 0.001;

	sleep 2;

	_smoke setParticleParams [["A3\Data_F\ParticleEffects\Universal\universal.p3d", 16, 7, 48, 1], "", "Billboard", 1, 25, [0, 0, 0],
					[0, 0, 30], 0, 1.7, 1, 0, [40,25,80], 
					[[1, 1, 1, 0.2],[1, 1, 1, 0.3],[1, 1, 1, 0.3],[1, 1, 1, 0.3],[1, 1, 1, 0.3],[1, 1, 1, 0.3],[1, 1, 1, 0.3],[1, 1, 1, 0]]
					, [0.5, 0.1], 1, 1, "", "", nukeCoords];
	_smoke setDropInterval 0.012;
	_Cone setDropInterval 0.02;
	_Wave setDropInterval 0.01;

	sleep 15;
	deleteVehicle _Wave;
	deleteVehicle _cone;
	deleteVehicle _smoke;
};

FEAR_fnc_nukeColorCorrection = {
	"colorCorrections" ppEffectAdjust [2, 30, 0, [0.0, 0.0, 0.0, 0.0], [0.8*2, 0.5*2, 0.0, 0.7], [0.9, 0.9, 0.9, 0.0]];
	"colorCorrections" ppEffectCommit 0;
	"colorCorrections" ppEffectAdjust [1, 0.8, -0.001, [0.0, 0.0, 0.0, 0.0], [0.8*2, 0.5*2, 0.0, 0.7], [0.9, 0.9, 0.9, 0.0]];  
	"colorCorrections" ppEffectCommit 3;
	"colorCorrections" ppEffectEnable true;
	"filmGrain" ppEffectEnable true; 
	"filmGrain" ppEffectAdjust [0.02, 1, 1, 0.1, 1, false];
	"filmGrain" ppEffectCommit 5;
};

FEAR_fnc_nukeFlash = {
	"dynamicBlur" ppEffectEnable true;
	"dynamicBlur" ppEffectAdjust [1];
	"dynamicBlur" ppEffectCommit 1;

	"colorCorrections" ppEffectEnable true;
	"colorCorrections" ppEffectAdjust [0.8, 15, 0, [0.5, 0.5, 0.5, 0], [0.0, 0.0, 0.6, 2],[0.3, 0.3, 0.3, 0.1]];"colorCorrections" ppEffectCommit 0.4;
	 
	"dynamicBlur" ppEffectAdjust [0.5];
	"dynamicBlur" ppEffectCommit 3;

	0 setOvercast 0;
	sleep 0.1;

	_xHandle = []spawn
	{
		Sleep 1;
		"colorCorrections" ppEffectAdjust [1.0, 0.5, 0, [0.5, 0.5, 0.5, 0], [1.0, 1.0, 0.8, 0.4],[0.3, 0.3, 0.3, 0.1]];
		"colorCorrections" ppEffectCommit 2;
	};


	"dynamicBlur" ppEffectAdjust [2];
	"dynamicBlur" ppEffectCommit 1;

	"dynamicBlur" ppEffectAdjust [0.5];
	"dynamicBlur" ppEffectCommit 4;

	_light setLightBrightness 100000.0;

	sleep 4.5;

	"colorCorrections" ppEffectAdjust [1, 1, 0, [0.5, 0.5, 0.5, 0], [1.0, 1.0, 0.8, 0.4],[0.3, 0.3, 0.3, 0.1]];"colorCorrections" ppEffectCommit 1; "colorCorrections" ppEffectEnable TRUE;
	"dynamicBlur" ppEffectAdjust [0];
	"dynamicBlur" ppEffectCommit 1;
};

FEAR_fnc_nukeEarthquake = {
		player spawn {
		//playsound "eq";
		for "_i" from 0 to 200 do {
			_vx = vectorup _this select 0;
			_vy = vectorup _this select 1;
			_vz = vectorup _this select 2;
			_coef = 0.01 - (0.0001 * _i);
			_this setvectorup [
				_vx+(-_coef+random (2*_coef)),
				_vy+(-_coef+random (2*_coef)),
				_vz+(-_coef+random (2*_coef))
			];
			sleep (0.01 + random 0.01);
		};
		[player, 0, 0] call BIS_fnc_setPitchBank;
	};
};

FEAR_fnc_nukeAsh = {
	sleep 20;

	//--- Ash
	[] spawn {
		_pos = position player;
		_parray = [
		/* 00 */		["A3\Data_F\ParticleEffects\Universal\Universal", 16, 12, 8, 1],//"A3\Data_F\cl_water",
		/* 01 */		"",
		/* 02 */		"Billboard",
		/* 03 */		1,
		/* 04 */		4,
		/* 05 */		[0,0,0],
		/* 06 */		[0,0,0],
		/* 07 */		1,
		/* 08 */		0.000001,
		/* 09 */		0,
		/* 10 */		1.4,
		/* 11 */		[0.05,0.05],
		/* 12 */		[[0.1,0.1,0.1,1]],
		/* 13 */		[0,1],
		/* 14 */		0.2,
		/* 15 */		1.2,
		/* 16 */		"",
		/* 17 */		"",
		/* 18 */		vehicle player
		];
		_snow = "#particlesource" createVehicleLocal _pos;  
		_snow setParticleParams _parray;
		_snow setParticleRandom [0, [10, 10, 7], [0, 0, 0], 0, 0.01, [0, 0, 0, 0.1], 0, 0];
		_snow setParticleCircle [0.0, [0, 0, 0]];
		_snow setDropInterval 0.01;
	};
};