if (isServer) then {

	private ["_wp1","_aitype","_aicskill","_wpnum","_radius","_gunner2","_gunner","_skillarray","_startingpos","_heli_class","_startPos","_helicopter","_unitGroup","_pilot","_skill","_position","_wp"];

	_position 			= _this select 0;
	_startingpos 		= _this select 1;
	_radius 			= _this select 2;
	_wpnum 				= _this select 3;
	_heli_class 		= _this select 4;
	_skill 				= _this select 5;
	_aisoldier			= _this select 6;
	_aitype				= _this select 7;
	
	if (count _this > 8) then {
		_mission 		= _this select 8;
	} else {
		_mission 		= nil;
	};
	
	_skillarray			= ["aimingAccuracy","aimingShake","aimingSpeed","endurance","spotDistance","spotTime","courage","reloadSpeed","commanding","general"];

	_unitGroup			= createGroup RESISTANCE;
	_unitGroup 			setVariable["LASTLOGOUT_EPOCH",1000000000000];
	_unitGroup 			setVariable["LAST_CHECK",1000000000000]; 
	_unitGroup 			setBehaviour "AWARE";
	_unitGroup 			setSpeedMode "FULL";
	_unitGroup			allowFleeing 0;

	if(debug_mode) then { diag_log("WAI: Spawning Heli patrol at " + str(mapGridPosition(_startingpos))); };
	if(debug_mode) then { diag_log("WAI: Flying to " + str(mapGridPosition(_position))); };
	
	_helicopter 		= createVehicle [_heli_class, [(_startingpos select 0),(_startingpos select 1), 200], [], 0, "FLY"];
	_helicopter 		setFuel 1;
	_helicopter 		engineOn true;
	_helicopter 		setVehicleAmmo 1;
	_helicopter 		flyInHeight 150;
	_helicopter 		lock true;
	_helicopter 		addEventHandler ["GetOut",{(_this select 0) setFuel 0;(_this select 0) setDamage 1;}];
	_helicopter			setVariable["LASTLOGOUT_EPOCH",1000000000000];
	_helicopter			setVariable["LAST_CHECK",1000000000000];
	_helicopter 		disableTIEquipment true; // Disable Thermal
	_helicopter 		call EPOCH_server_setVToken; 	// Set Token
	
	addToRemainsCollector [_helicopter]; 	// Cleanup
	
	// Set Vehicle Slot
	EPOCH_VehicleSlotsLimit = EPOCH_VehicleSlotsLimit + 1;
	EPOCH_VehicleSlots pushBack (str EPOCH_VehicleSlotsLimit);
	_helicopter setVariable ["VEHICLE_SLOT",(EPOCH_VehicleSlots select 0),true];
	EPOCH_VehicleSlots = EPOCH_VehicleSlots - [(EPOCH_VehicleSlots select 0)];
	EPOCH_VehicleSlotCount = count EPOCH_VehicleSlots;
	
	[_helicopter] spawn vehicle_monitor;	//will need changed for A3 Epoch
	
	if (!isNil "_mission") then {
			if(debug_mode) then { diag_log("WAI: mission nr " + str(_mission)); };
			_ainum = (wai_mission_data select _mission) select 0;
			wai_mission_data select _mission set [0, (_ainum + 1)];
			_helicopter setVariable ["missionclean","air"];
			_helicopter setVariable ["mission",_mission];
	};
	
	_pilot 				= [_unitGroup,_position,"unarmed",_skill,_aitype,_mission] call spawn_soldier;
	[_pilot] 			joinSilent _unitGroup;
	_pilot 				assignAsDriver _helicopter;
	_pilot 				moveInDriver _helicopter;
	ai_air_units 		= (ai_air_units +1);
	if(debug_mode) then { diag_log("WAI: Spawning Heli pilot " + str(_pilot)); };
	
	//Pilot is leader
	_unitGroup 			selectLeader _pilot;

	_gunner 			= [_unitGroup,_position,1,_skill,_aitype,_mission] call spawn_soldier;
	[_gunner] 			joinSilent _unitGroup;
	_gunner 			assignAsCargo _helicopter;
	_gunner 			moveInCargo [_helicopter,2];
	_gunner				enablePersonTurret [2,true];
	ai_air_units 		= (ai_air_units + 1);
	if(debug_mode) then { diag_log("WAI: Spawning Heli gunner 1 " + str(_gunner)); };

	_gunner2 			= [_unitGroup,_position,1,_skill,_aitype,_mission] call spawn_soldier;
	[_gunner] 			joinSilent _unitGroup;
	_gunner2			assignAsCargo _helicopter;
	_gunner2 			moveInCargo [_helicopter,4];
	_gunner2			enablePersonTurret [4,true];
	ai_air_units 		= (ai_air_units + 1);
	if(debug_mode) then { diag_log("WAI: Spawning Heli gunner 2 " + str(_gunner2)); };
	
	{
		_pilot setSkill [_x,1]
	} count _skillarray;

	{
		// Make it an AIR unit
		_x removeEventHandler ["killed", 0];
		_x addEventHandler ["Killed",{[_this select 0, _this select 1, "air"] call on_kill;}];
		_x setVariable ["missionclean", "air"];
	} forEach (units _unitgroup);

	if (!isNil "_mission") then {
		[_unitGroup, _mission] spawn bandit_behaviour;
	} else {
		[_unitGroup] spawn bandit_behaviour;
	};
	
	if(_wpnum > 0) then {

		for "_i" from 1 to _wpnum do {
			_wp = _unitGroup addWaypoint [[(_position select 0),(_position select 1),0],_radius];
			_wp setWaypointType "MOVE";
			_wp setWaypointCompletionRadius 200;
			_wp setWaypointStatements ["true",
			"
				(Vehicle this) flyinheight 50;
				(Vehicle this) limitSpeed 45;
				if(debug_mode) then {diag_log('WAI: Heli height ' + str((position Vehicle this) select 2) + '/ Heli speed ' + str(speed this)); };
			"];
			if(debug_mode) then { diag_log("WAI: Heli WP" + str(_i) + " / " + str(_wp)); };
		};
	};

	_wp = _unitGroup addWaypoint [[(_position select 0),(_position select 1),0],100];
	_wp setWaypointCompletionRadius 200;
	_wp setWaypointType "CYCLE";
	if(debug_mode) then { diag_log("WAI: Heli WP " + str(_wp)); };
	
	_unitGroup
};
