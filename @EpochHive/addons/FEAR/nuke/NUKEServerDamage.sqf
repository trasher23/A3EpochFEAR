// -----------------------
//	NUKE damage - Server
// -----------------------

if (isDedicated) then {
	private["_x","_coords","_isCar","_direction"];

	_coords = _this select 0;

	// Entity damage
	{
		// Kill everything within groundZero (half of nukeRadius)
		_x setDamage 1;
		sleep 0.125;
	} forEach (_coords nearEntities [["All"],groundZero]);

	// Object damage
	{	
		// Flip vehicles
		_isCar = _x isKindOf "Car";
		if (_isCar) then {
			// Select random direction for flip
			// 0 = no flip
			// 90 = side
			// 180 = roof
			_direction = [0,90,180] call BIS_fnc_selectRandom;
			[_x,0,_direction] call BIS_fnc_setPitchBank;
		};
		
		// % of objects that will be completely destroyed within nukeRadius, currently 80%
		if (round(random 100) <= 80) then {    
			_x setDamage 1;
		} else {
			// The rest are set on fire
			[_x,10,time,false,true] spawn BIS_Effects_Burn;
		};
		
		sleep 0.125;
	} forEach (nearestObjects [_coords,["house","Building","LandVehicle","Air","Ship"],nukeRadius]);
};
