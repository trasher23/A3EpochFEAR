/*
	Nuke Client Functions
*/

FEAR_fnc_nukeSiren = {
	private ["_nukeSiren","_nukePos"];
	
	_nukeSiren = MISSION_directory + "FEAR\fx\" + "nukesiren.ogg";
	_nukePos = _this select 0;
	
	// 8 iterations is roughly 3 minutes
	for "_x" from 1 to 8 do {
		playSound3D [_nukeSiren, player, false, _nukePos];
		uisleep 23; // Length of siren sample to loop
	};
};

FEAR_fnc_nukeImpact = {
	private ["_nukePos","_nukeBlast","_isInside","_isInArmourVehicle","_Cone","_top","_top2","_smoke","_Wave","_light"];
	
	_nukePos = _this select 0;
	
	// Nuke blast sound fx
	_nukeBlast = MISSION_directory + "FEAR\fx\" + "nuke.ogg";
	playSound3D [_nukeBlast, player, false, _nukePos, 5];
	
	//////////////////////////////////////////////////////////////
	// MADE BY MOERDERHOSCHI
	// EDITED VERSION OF THE ARMA2 ORIGINAL SCRIPT
	// ARMED-ASSAULT.DE
	//////////////////////////////////////////////////////////////
	_Cone = "#particlesource" createVehicleLocal _nukePos;
	_Cone setParticleParams [["A3\Data_F\ParticleEffects\Universal\universal.p3d", 16, 7, 48], "", "Billboard", 1, 10, [0, 0, 0],
					[0, 0, 0], 0, 1.275, 1, 0, [40,80], [[0.25, 0.25, 0.25, 0], [0.25, 0.25, 0.25, 0.5], 
					[0.25, 0.25, 0.25, 0.5], [0.25, 0.25, 0.25, 0.05], [0.25, 0.25, 0.25, 0]], [0.25], 0.1, 1, "", "", _nukePos];
	_Cone setParticleRandom [2, [1, 1, 30], [1, 1, 30], 0, 0, [0, 0, 0, 0.1], 0, 0];
	_Cone setParticleCircle [10, [-10, -10, 20]];
	_Cone setDropInterval 0.005;
	_top = "#particlesource" createVehicleLocal _nukePos;
	_top setParticleParams [["A3\Data_F\ParticleEffects\Universal\universal.p3d", 16, 3, 48, 0], "", "Billboard", 1, 20, [0, 0, 0],
					[0, 0, 60], 0, 1.7, 1, 0, [60,80,100], [[1, 1, 1, -10],[1, 1, 1, -7],[1, 1, 1, -4],[1, 1, 1, -0.5],[1, 1, 1, 0]], [0.05], 1, 1, "", "", _nukePos];
	_top setParticleRandom [0, [75, 75, 15], [17, 17, 10], 0, 0, [0, 0, 0, 0], 0, 0, 360];
	_top setDropInterval 0.002;
	_top2 = "#particlesource" createVehicleLocal _nukePos;
	_top2 setParticleParams [["A3\Data_F\ParticleEffects\Universal\universal.p3d", 16, 3, 112, 0], "", "Billboard", 1, 20, [0, 0, 0],
					[0, 0, 60], 0, 1.7, 1, 0, [60,80,100], [[1, 1, 1, 0.5],[1, 1, 1, 0]], [0.07], 1, 1, "", "", _nukePos];
	_top2 setParticleRandom [0, [75, 75, 15], [17, 17, 10], 0, 0, [0, 0, 0, 0], 0, 0, 360];
	_top2 setDropInterval 0.002;
	_smoke = "#particlesource" createVehicleLocal _nukePos;
	_smoke setParticleParams [["A3\Data_F\ParticleEffects\Universal\universal.p3d", 16, 7, 48, 1], "", "Billboard", 1, 25, [0, 0, 0],
					[0, 0, 60], 0, 1.7, 1, 0, [40,15,120], 
					[[1, 1, 1, 0.4],[1, 1, 1, 0.7],[1, 1, 1, 0.7],[1, 1, 1, 0.7],[1, 1, 1, 0.7],[1, 1, 1, 0.7],[1, 1, 1, 0.7],[1, 1, 1, 0]]
					, [0.5, 0.1], 1, 1, "", "", _nukePos];
	_smoke setParticleRandom [0, [10, 10, 15], [15, 15, 7], 0, 0, [0, 0, 0, 0], 0, 0, 360];
	_smoke setDropInterval 0.002;
	_Wave = "#particlesource" createVehicleLocal _nukePos;
	_Wave setParticleParams [["A3\Data_F\ParticleEffects\Universal\universal.p3d", 16, 7, 48], "", "Billboard", 1, 20, [0, 0, 0],
					[0, 0, 0], 0, 1.5, 1, 0, [50, 100], [[0.1, 0.1, 0.1, 0.5], 
					[0.5, 0.5, 0.5, 0.5], [1, 1, 1, 0.3], [1, 1, 1, 0]], [1,0.5], 0.1, 1, "", "", _nukePos];
	_Wave setParticleRandom [2, [20, 20, 20], [5, 5, 0], 0, 0, [0, 0, 0, 0.1], 0, 0];
	_Wave setParticleCircle [50, [-80, -80, 2.5]];
	_Wave setDropInterval 0.0002;
	_light = "#lightpoint" createVehicleLocal [((_nukePos select 0)),(_nukePos select 1),((_nukePos select 2)+500)];
	_light setLightAmbient[1500, 1200, 1000];
	_light setLightColor[1500, 1200, 1000];
	_light setLightBrightness 100000.0;
	
	// Radiation effects
	_isInside = call EPOCH_fnc_isInsideBuilding;
	// Is player in armoured vehicle? APC?
	_isInArmourVehicle = [typeOf(vehicle player), "APC"] call KK_fnc_inString;
	// If false, then check for tank
	If(!_isInArmourVehicle) then {
		_isInArmourVehicle = [typeOf(vehicle player), "MBT"] call KK_fnc_inString;
	};
	
	if((isPlayer player) && (player distance _nukePos <= 2000) && (!_isInside || !_isInArmourVehicle)) then {
		EPOCH_playerToxicity = 85;
		EPOCH_playerSoiled = 85;
	};
	
	// Flash
	[] spawn FEAR_fnc_nukeFlash;

	// Earthquake
	[] spawn BIS_fnc_earthquake;

	// Ash
	[] spawn FEAR_fnc_nukeAsh;

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
					, [0.5, 0.1], 1, 1, "", "", _nukePos];

	_Cone setDropInterval 0.01;
	_smoke setDropInterval 0.006;
	_Wave setDropInterval 0.001;
	sleep 2;
	_smoke setParticleParams [["A3\Data_F\ParticleEffects\Universal\universal.p3d", 16, 7, 48, 1], "", "Billboard", 1, 25, [0, 0, 0],
					[0, 0, 30], 0, 1.7, 1, 0, [40,25,80], 
					[[1, 1, 1, 0.2],[1, 1, 1, 0.3],[1, 1, 1, 0.3],[1, 1, 1, 0.3],[1, 1, 1, 0.3],[1, 1, 1, 0.3],[1, 1, 1, 0.3],[1, 1, 1, 0]]
					, [0.5, 0.1], 1, 1, "", "", _nukePos];
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
	sleep 100; // time to reset colors
	"colorCorrections" ppEffectEnable false;
	"filmGrain" ppEffectEnable false; 
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

FEAR_fnc_nukeAsh = {
	sleep 20;
	//--- Ash
	[] spawn {
		private ["_pos","_parray","_snow"];
		_pos = position player;
		_parray = [["A3\Data_F\ParticleEffects\Universal\Universal", 16, 12, 8, 1],"","Billboard",1,4,[0,0,0],[0,0,0],1,0.000001,0,1.4,[0.05,0.05],[[0.1,0.1,0.1,1]],[0,1],0.2,1.2,"","",vehicle player];
		_snow = "#particlesource" createVehicleLocal _pos;  
		_snow setParticleParams _parray;
		_snow setParticleRandom [0, [10, 10, 7], [0, 0, 0], 0, 0.01, [0, 0, 0, 0.1], 0, 0];
		_snow setParticleCircle [0.0, [0, 0, 0]];
		_snow setDropInterval 0.01;
		// Delete Ash after 5 min
		sleep 300;
		deleteVehicle _snow;
	};
};

FEAR_fnc_nukeGeiger = {
	private ["_nukeGeiger"];
	
	_nukeGeiger = MISSION_directory + "FEAR\fx\" + "geiger.ogg";
	
	playSound3D [_nukeGeiger, player, false, getPosASL player, 1, 1, 0];
};

KK_fnc_inString = {
    /*
    Author: Killzone_Kid
    
    Description:
    Find a string within a string (case insensitive)
    
    Parameter(s):
    _this select 0: <string> string to be found
    _this select 1: <string> string to search in
    
    Returns:
    Boolean (true when string is found)
    
    How to use:
    _found = ["needle", "Needle in Haystack"] call KK_fnc_inString;
    */

    private ["_needle","_haystack","_needleLen","_hay","_found"];
    _needle = [_this, 0, "", [""]] call BIS_fnc_param;
    _haystack = toArray ([_this, 1, "", [""]] call BIS_fnc_param);
    _needleLen = count toArray _needle;
    _hay = +_haystack;
    _hay resize _needleLen;
    _found = false;
    for "_i" from _needleLen to count _haystack do {
        if (toString _hay == _needle) exitWith {_found = true};
        _hay set [_needleLen, _haystack select _i];
        _hay set [0, "x"];
        _hay = _hay - ["x"]
    };
    _found
};
