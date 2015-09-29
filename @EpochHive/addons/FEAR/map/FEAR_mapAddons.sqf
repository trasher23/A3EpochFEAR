/*
	FEAR_mapAddons.sqf
*/

if (isServer) then {
	
	// Air wreck at airport
	_this = createVehicle["C130J_wreck_EP1",[9739.43, 4899.64, 0],[],0,"CAN_COLLIDE"];
	_this setDir 87.1285;
	_this setPos [9739.43, 4899.64, 0];
	
};