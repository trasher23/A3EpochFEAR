/*
	Spawn exploding barrels around buildings
*/

_explodingBarrel = {
	private["_pos"];
	_pos = ATLToASL (_this select 0);
	
	Barrel_BOOM = compileFinal '
		_ex = createVehicle [
			"R_TBG32V_F",
			_this modeltoworld [0,0,0],
			[],
			0,
			"CAN_COLLIDE"
		];
		_ex setVectorDirAndUp [[0,0,1],[0,-1,0]];
		_ex setVelocity [0,0,-1000];
		deleteVehicle _this;
	';
	
	_bars = [];
	{		
		_b = createVehicle [
			"Land_MetalBarrel_F",
			[0,0,0],
			[],
			0,
			"NONE"
		];
		_b setDir (random 360);
		_b setPosASL _pos;
		_b setDamage 0.99;
		_b allowDamage false;
		_b addEventHandler ["Hit", {
			_b = _this select 0;
			if (alive _b) then {_b setDamage 0.99};
		}];
		_bars set [_forEachIndex, _b];
	} forEach _this;
	
	sleep 0.25;
	
	{
		_x setVariable ["#PosASL", getPosASL _x];
		_x addEventHandler ["EpeContact", {
			_b = _this select 0;
			if (
				(getPosASL _b) distance (_b getVariable "#PosASL") > 0.1
			) then {_b call Barrel_BOOM};
		}];
		_x addEventHandler ["Killed", {_this select 0 call Barrel_BOOM}];
		_x allowDamage true;
	} count _bars;
	
	diag_log format["[FEAR] exploding barrel spawned at %1",_pos];
};

[[2661.84,4463.95,0]] spawn _explodingBarrel;