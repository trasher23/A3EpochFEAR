// ---------------
// earthquake.sqf
// ---------------

if (isServer) {exitWith};

earthQuake = {
	playSound "eq";
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
		
		[player, 0, 0] call BIS_fnc_setPitchBank;
	};
};

private ["_timeDiff","_maxTime","_minTime"];
	
_maxTime = 30; mins
_minTime = 5;

// Find the Min and Max time
_timeDiff = ((_maxTime*60) - (_minTime*60));
	
while {true} do {
	// Wait a Random Amount
	uiSleep ((floor(random(_timeDiff))) + (_minTime*60));
	
	player spawn earthQuake;
};
