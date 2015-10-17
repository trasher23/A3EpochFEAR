/*
	Called from client
	Spawns exploding barrels
*/
Barrel_BOOM = compileFinal '
	_ex = createVehicle [
		"R_TBG32V_F",
		_this modeltoworld [0,0,0],
		[],
		0,
		"CAN_COLLIDE"
	];
	_ex setVectorDirAndUp[[0,0,1],[0,-1,0]];
	_ex setVelocity[0,0,-1000];
	deleteVehicle _this;
';

_explodingBarrel = {
	private["_pos","_b","_direction"];
	
	_pos = ATLToASL(_this select 0);
		
	_b = createVehicle [
		"Land_MetalBarrel_F",
		[0,0,0],
		[],
		0,
		"NONE"
	];
	_b setDir(random 360);
	_b setPosASL _pos;
	_b setVariable["LAST_CHECK", (diag_tickTime + 600)]; // Epoch Server_Monitor, delete after 600s if no players near
	
	// Position barrel upright or on side
	_direction = [0,90] call BIS_fnc_selectRandom;
	[_b,0,_direction] call BIS_fnc_setPitchBank;
			
	_b setDamage 0.99;
	_b allowDamage false;
	_b addEventHandler ["Hit", {
		_b = _this select 0;
		if (alive _b) then {_b setDamage 0.99};
	}];
	
	uiSleep 0.1;
	
	_b setVariable["#PosASL", getPosASL _b];
	_b addEventHandler["EpeContact", {
		_b = _this select 0;
		if (
			(getPosASL _b) distance (_b getVariable "#PosASL") > 0.1
		) then {_b call Barrel_BOOM};
	}];
	_b addEventHandler["Killed", {_this select 0 call Barrel_BOOM}];
	_b allowDamage true;
};

private "_pos";
_pos = _this;
[_pos] spawn _explodingBarrel;
diag_log format["[FEAR] exploding barrel spawned at %1",_pos];