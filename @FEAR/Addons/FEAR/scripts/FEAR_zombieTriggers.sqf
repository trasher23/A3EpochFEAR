// ---------------------------------------
//	Spawn zombie hoard in random building
// ---------------------------------------

private["_fnc_getRandomBuildingPos","_fnc_createTriggers"];

_fnc_getRandomBuildingPos = {
	private["_buildings","_cnps","_triggerLocations","_triggerLocation"];
	
	// Array of buildings where zombies can spawn
	_buildings = [
		"Land_A_GeneralStore_01",
		"Land_A_GeneralStore_01a",
		"Land_A_Hospital",
		"Land_A_Office01",
		"Land_A_Office02",
		"Land_Ind_Workshop01_01",
		"Land_Ind_Workshop01_02",
		"Land_Mil_ControlTower",
		"Land_Mil_Barracks_i",
		"Land_SS_hangar",
		"Land_a_stationhouse",
		"Land_stodola_old_open",
		"Land_stodola_open",
		"Land_Church_03",
		"Land_Church_03_dam",
		"housev_1i4",
		"Land_Panelak2",
		"Land_Farm_Cowshed_b",
		"Land_HouseV2_02_Interier",
		"Land_HouseV2_04_interier",
		"Land_A_Pub_01",
		"Land_HouseV_1I4",
		"Land_i_House_Small_01_V3_dam_F",
		"Land_Barn_Metal",
		"Land_Barn_W_01",
		"Land_Barn_W_02",
		"Land_Farm_Cowshed_b",
		"Land_Shed_Ind02",
		"Land_Tovarna2",
		"Land_Hangar_2",
		"Land_A_Stationhouse_ep1",
		"Land_Hangar_F"
		];
	
	// Get array of possible locations
    _triggerLocations = nearestObjects[MapCentre,_buildings,MapRadius];
	
	// Select a random location from array
	_triggerLocation = getPosATL(_triggerLocations select(floor(random(count _triggerLocations))));
	_triggerLocation
};

_fnc_createTriggers = {
	private["_zombiePos","_zombieHordeSize","_triggerIndex","_trigName","_trig_cond","_trig_act_stmnt","_trig_deact_stmnt"];
	
	_triggerIndex = _this select 0;
	
	// Debug position - test in Zupres supermarket
	//_zombiePos = [2673, 4471, 0];
	_zombiePos = call _fnc_getRandomBuildingPos;
	_zombieHordeSize = 1 + random 7;
	
	// Create trigger to spawn patrol
	_trigName = format["herdTrig%1",_triggerIndex];
	_this = createTrigger["EmptyDetector",_zombiePos]; 
	_this setTriggerArea[5, 5, 0, false];
	_this setTriggerActivation["ANY", "PRESENT", false];
	
	// Assign trigger conditions
	_trig_cond = "{isPlayer _x} count thisList > 0"; // Trigger if any player is in range
	_trig_act_stmnt = format["[%1,%2] execVM ""%3\scripts\FEAR_spawnZombies.sqf""",_zombiePos,_zombieHordeSize,FEAR_directory];
	_trig_deact_stmnt = format["deleteVehicle %1",_trigName]; // Delete trigger once activated
	
	_this setTriggerStatements[_trig_cond,_trig_act_stmnt,_trig_deact_stmnt];
	
	diag_log format["[FEAR] zombie trigger created at %1",_zombiePos];
};

if (isDedicated) then {
	private "_numberOfTriggers";
	
	_numberOfTriggers = 10;
	
	for "_i" from 1 to _numberOfTriggers do{
		[_i] call _fnc_createTriggers;
	};
};