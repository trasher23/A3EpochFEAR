/*
	FEAR_mapAddons.sqf
*/

if(isDedicated)then{
	private["_posLamps","_lightObj"];
	
	// Air wreck at airport
	_addOn = createVehicle["C130J_wreck_EP1",[9739.43, 4899.64, 0],[],0,"CAN_COLLIDE"];
	_addOn setDir 87.1285;
	
	// Light sources at Debug_static_F (spawnbox); otherwise, it's totally dark at night
	_posLamps = [[248.5,1424.1,0],[248.5,1407.9,0],[279,1407.9,0],[278,1424.4,0]];
	{
		_addOn = createVehicle["Land_Lampa_koule",_x,[],0,"CAN COLLIDE"]; // Spawn lamp
	}forEach _posLamps;
};