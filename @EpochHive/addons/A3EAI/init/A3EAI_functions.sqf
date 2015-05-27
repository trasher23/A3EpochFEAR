/*
	A3EAI Functions

*/

diag_log "[A3EAI] Compiling A3EAI functions.";

if (isNil "SHK_pos_getPos") then {call compile preprocessFile format ["%1\compile\SHK_pos\shk_pos_init.sqf",A3EAI_directory];};

BIS_fnc_selectRandom2 = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_utilities\fn_selectRandom.sqf",A3EAI_directory];
A3EAI_checkClassname = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_utilities\A3EAI_check_classname.sqf",A3EAI_directory];
A3EAI_posInBuilding = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_utilities\A3EAI_insideBuildingCheck.sqf",A3EAI_directory];
A3EAI_clearMissileWeapons = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_utilities\A3EAI_removeMissiles.sqf",A3EAI_directory];
A3EAI_createCustomInfantryQueue = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_utilities\A3EAI_customInfantryQueue.sqf",A3EAI_directory];
A3EAI_createCustomInfantrySpawnQueue = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_utilities\A3EAI_customInfantrySpawnQueue.sqf",A3EAI_directory];
A3EAI_createCustomVehicleQueue = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_utilities\A3EAI_customVehicleQueue.sqf",A3EAI_directory];
A3EAI_createBlacklistAreaQueue = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_utilities\A3EAI_customBlacklistQueue.sqf",A3EAI_directory];
A3EAI_findSpawnPos = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_utilities\A3EAI_find_spawnposition.sqf",A3EAI_directory];
A3EAI_hasLOS = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_utilities\A3EAI_hasLOS.sqf",A3EAI_directory];
A3EAI_getSpawnParams = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_utilities\A3EAI_getSpawnParams.sqf",A3EAI_directory];
A3EAI_createInfantryQueue = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_utilities\A3EAI_staticInfantrySpawnQueue.sqf",A3EAI_directory];
A3EAI_createRandomInfantrySpawnQueue = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_utilities\A3EAI_randomInfantrySpawnQueue.sqf",A3EAI_directory];
A3EAI_addVehicleGroup = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_utilities\A3EAI_addVehicleGroup.sqf",A3EAI_directory];
A3EAI_respawnAIVehicle = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_utilities\A3EAI_respawnAIVehicle.sqf",A3EAI_directory];
A3EAI_staticSpawn_init = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_utilities\A3EAI_init_static.sqf",A3EAI_directory];
A3EAI_initializeTrigger = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_utilities\A3EAI_initialize_trigger.sqf",A3EAI_directory];
A3EAI_reloadVehicleTurrets = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_utilities\A3EAI_reloadVehicleTurrets.sqf",A3EAI_directory];
A3EAI_checkIsWeapon = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_utilities\A3EAI_checkIsWeapon.sqf",A3EAI_directory];
A3EAI_addUnitEH = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_utilities\A3EAI_addUnitEH.sqf",A3EAI_directory];
A3EAI_addVehAirEH = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_utilities\A3EAI_addVehAirEH.sqf",A3EAI_directory];
A3EAI_addLandVehEH = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_utilities\A3EAI_addLandVehEH.sqf",A3EAI_directory];
A3EAI_getWeapon = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_utilities\A3EAI_getWeapon.sqf",A3EAI_directory];
A3EAI_deleteCustomSpawn = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_utilities\A3EAI_deleteCustomSpawn.sqf",A3EAI_directory];
A3EAI_clearVehicleCargo = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_utilities\A3EAI_clearVehicleCargo.sqf",A3EAI_directory];
A3EAI_fixStuckGroup = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_utilities\A3EAI_fixStuckGroup.sqf",A3EAI_directory];
A3EAI_cleanupReinforcementGroup = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_utilities\A3EAI_cleanupReinforcementGroup.sqf",A3EAI_directory];
A3EAI_createUnit = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_unit_spawning\A3EAI_setup_unit.sqf",A3EAI_directory];
A3EAI_spawnGroup = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_unit_spawning\A3EAI_setup_group.sqf",A3EAI_directory];
A3EAI_spawnBandits_custom = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_unit_spawning\A3EAI_spawn_custom.sqf",A3EAI_directory];
A3EAI_spawnVehicle_custom = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_unit_spawning\A3EAI_spawn_vehiclecustom.sqf",A3EAI_directory];
A3EAI_createCustomSpawn = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_unit_spawning\A3EAI_setup_customspawn.sqf",A3EAI_directory];
A3EAI_respawnGroup = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_unit_spawning\A3EAI_respawnGroup.sqf",A3EAI_directory];
A3EAI_addRespawnQueue = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_unit_spawning\A3EAI_add_respawn.sqf",A3EAI_directory];
A3EAI_processRespawn = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_unit_spawning\A3EAI_process_respawn.sqf",A3EAI_directory];
A3EAI_despawn_static = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_unit_spawning\A3EAI_despawn_static.sqf",A3EAI_directory];
A3EAI_spawnUnits_static = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_unit_spawning\A3EAI_spawn_static.sqf",A3EAI_directory];
A3EAI_setupStaticSpawn = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_unit_spawning\A3EAI_setup_staticspawn.sqf",A3EAI_directory];
A3EAI_cancelDynamicSpawn = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_unit_spawning\A3EAI_cancel_dynamicspawn.sqf",A3EAI_directory];
A3EAI_spawnUnits_dynamic = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_unit_spawning\A3EAI_spawn_dynamic.sqf",A3EAI_directory];
A3EAI_despawn_dynamic = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_unit_spawning\A3EAI_despawn_dynamic.sqf",A3EAI_directory];
A3EAI_setup_randomspawns =  compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_unit_spawning\A3EAI_setup_randomspawns.sqf",A3EAI_directory];
A3EAI_cancelRandomSpawn = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_unit_spawning\A3EAI_cancel_randomspawn.sqf",A3EAI_directory];
A3EAI_spawnUnits_random = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_unit_spawning\A3EAI_spawn_random.sqf",A3EAI_directory];
A3EAI_despawn_random = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_unit_spawning\A3EAI_despawn_random.sqf",A3EAI_directory];
A3EAI_spawnVehiclePatrol = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_unit_spawning\A3EAI_spawn_vehiclepatrol.sqf",A3EAI_directory];
A3EAI_addParaGroup = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_unit_spawning\A3EAI_addParaGroup.sqf",A3EAI_directory];
A3EAI_addVehicleGunners = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_unit_spawning\A3EAI_addVehicleGunners.sqf",A3EAI_directory];
A3EAI_spawn_reinforcement = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_unit_spawning\A3EAI_spawn_reinforcement.sqf",A3EAI_directory];
A3EAI_generateLoadout = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_unit_scripts\A3EAI_generate_loadout.sqf",A3EAI_directory];
A3EAI_generateLoot = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_unit_scripts\A3EAI_generate_loot.sqf",A3EAI_directory];
A3EAI_addGroupManager = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_unit_scripts\A3EAI_group_manager.sqf",A3EAI_directory];
A3EAI_generateLootPool = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_unit_scripts\A3EAI_generateLootPool.sqf",A3EAI_directory];
A3EAI_handleDamageUnit = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_unit_events\A3EAI_handleDamage_unit.sqf",A3EAI_directory];
A3EAI_handleDamageHeli = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_unit_events\A3EAI_handleDamage_heli.sqf",A3EAI_directory];
A3EAI_handleDamageVeh = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_unit_events\A3EAI_handleDamage_veh.sqf",A3EAI_directory];
A3EAI_handleDeathEvent = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_unit_events\A3EAI_handle_death.sqf",A3EAI_directory];
A3EAI_heliLanded = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_unit_events\A3EAI_heli_landed.sqf",A3EAI_directory];
A3EAI_heliEvacuated = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_unit_events\A3EAI_heli_evacuated.sqf",A3EAI_directory];
A3EAI_heliDestroyed = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_unit_events\A3EAI_heli_destroyed.sqf",A3EAI_directory];
A3EAI_heliParaDrop = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_unit_events\A3EAI_heli_paradrop.sqf",A3EAI_directory];
A3EAI_vehDestroyed = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_unit_events\A3EAI_veh_destroyed.sqf",A3EAI_directory];
A3EAI_handleDeath_generic = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_unit_events\A3EAI_handleDeath_generic.sqf",A3EAI_directory];
A3EAI_handleDeath_static = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_unit_events\A3EAI_handleDeath_static.sqf",A3EAI_directory];
A3EAI_handleDeath_staticcustom = A3EAI_handleDeath_static;
A3EAI_handleDeath_vehiclecrew = A3EAI_handleDeath_static;
A3EAI_handleDeath_air = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_unit_events\A3EAI_handleDeath_air.sqf",A3EAI_directory];
A3EAI_handleDeath_aircustom = A3EAI_handleDeath_air;
A3EAI_handleDeath_air_reinforce = A3EAI_handleDeath_air;
A3EAI_handleDeath_land = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_unit_events\A3EAI_handleDeath_land.sqf",A3EAI_directory];
A3EAI_handleDeath_landcustom = A3EAI_handleDeath_land;
A3EAI_handleDeath_dynamic = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_unit_events\A3EAI_handleDeath_dynamic.sqf",A3EAI_directory];
A3EAI_handleDeath_random = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_unit_events\A3EAI_handleDeath_random.sqf",A3EAI_directory];
A3EAI_handleDeath_aircrashed = {};
A3EAI_huntKiller = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_behavior\A3EAI_hunt_killer.sqf",A3EAI_directory];
A3EAI_BIN_taskPatrol = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_behavior\BIN_taskPatrol.sqf",A3EAI_directory];
A3EAI_customHeliDetect = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_behavior\A3EAI_customheli_detect.sqf",A3EAI_directory];
A3EAI_vehCrewRegroup = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_behavior\A3EAI_vehicle_crew_regroup.sqf",A3EAI_directory];
A3EAI_dynamicHunting = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_behavior\A3EAI_dynamic_hunting.sqf",A3EAI_directory];
A3EAI_heliDetection = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_behavior\A3EAI_heli_detect.sqf",A3EAI_directory];
A3EAI_heliStartPatrol = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_behavior\A3EAI_heli_patrolling.sqf",A3EAI_directory];
A3EAI_heliReinforce = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_behavior\A3EAI_reinforce_location.sqf",A3EAI_directory];
A3EAI_vehStartPatrol = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_behavior\A3EAI_vehicle_patrolling.sqf",A3EAI_directory];
A3EAI_startHunting = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_behavior\A3EAI_startHunting.sqf",A3EAI_directory];
A3EAI_hunterLocate = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_behavior\A3EAI_hunterLocate.sqf",A3EAI_directory];
A3EAI_reinforce_begin = compileFinal preprocessFileLineNumbers format ["%1\compile\A3EAI_behavior\A3EAI_reinforce_begin.sqf",A3EAI_directory];


//Miscellaneous functions 
//------------------------------------------------------------------------------------------------------------------------


A3EAI_radioSend = compileFinal '
	A3EAI_SMS = (_this select 1);
	
	if (isDedicated) then {
		(owner (_this select 0)) publicVariableClient "A3EAI_SMS";
	} else {
		A3EAI_SMS_PVS = [(_this select 0),A3EAI_SMS];
		publicVariableServer "A3EAI_SMS_PVS";
	};
	
	true
';

A3EAI_sendKillMessage = compileFinal '
	private ["_killer","_victim"];
	_killer = _this select 0;
	_victim = _this select 1;
	
	if (isDedicated) then {
		_victimName = _victim getVariable ["bodyName","Bandit"];
		{
			if (isPlayer _x) then {
				A3EAI_killMSG = _victimName;
				(owner _x) publicVariableClient "A3EAI_killMSG";
			};
		} count (crew _killer);
	} else {
		A3EAI_killMsg_PVS = [_killer,_victim];
		publicVariableServer "A3EAI_killMsg_PVS";
	};
';


A3EAI_updGroupCount = compileFinal '
	private ["_unitGroup","_isNewGroup"];
	_unitGroup = _this select 0;
	_isNewGroup = _this select 1;
	
	if (isNull _unitGroup) exitWith {false};
	
	if (_isNewGroup) then {
		A3EAI_activeGroups pushBack _unitGroup;
	} else {
		A3EAI_activeGroups = A3EAI_activeGroups - [_unitGroup,grpNull];
	};

	true
';

//A3EAI group side assignment function.
A3EAI_createGroup = compileFinal '
	private["_unitGroup","_protect","_unitType"];
	_unitType = _this select 0;

	_unitGroup = createGroup resistance;
	if ((count _this) > 1) then {_unitGroup call A3EAI_protectGroup};
	_unitGroup setVariable ["unitType",_unitType];
	[_unitGroup,true] call A3EAI_updGroupCount;
	
	_unitGroup
';

//Sets skills for unit based on their unitLevel value.
A3EAI_setSkills = compileFinal '
	private["_unit","_unitLevel","_skillArray"];
	_unit = _this select 0;
	_unitLevel = _this select 1;

	_skillArray = missionNamespace getVariable ["A3EAI_skill"+str(_unitLevel),A3EAI_skill3];
	{
		_unit setskill [_x select 0,(((_x select 1) + random ((_x select 2)-(_x select 1))) min 1)];
	} forEach _skillArray;
';

A3EAI_lootSearching = compileFinal '
	private ["_lootPiles","_lootPos","_unitGroup","_searchRange"];
	_unitGroup = _this select 0;
	_searchRange = _this select 1;
	
	_lootPiles = (getPosATL (leader _unitGroup)) nearObjects ["Animated_Loot",_searchRange];
	if ((count _lootPiles) > 0) then {
		_lootPos = getPosATL (_lootPiles call BIS_fnc_selectRandom2);
		if ((behaviour (leader _unitGroup)) != "AWARE") then {_unitGroup setBehaviour "AWARE"};
		(units _unitGroup) doMove _lootPos;
		{_x moveTo _lootPos} forEach (units _unitGroup);
		//diag_log format ["DEBUG :: AI group %1 is investigating a loot pile at %2.",_unitGroup,_lootPos];
	};
';

A3EAI_protectObject = compileFinal '
	private ["_objectMonitor","_object","_index"];
	_object = _this;
	
	_object call EPOCH_server_setVToken;
	_object setVariable["LOCK_OWNER", "-1"];
	_object setVariable["LOCKED_TILL", 3.4028235e38];
	_object setVehicleLock "LOCKEDPLAYER";
	_object enableCopilot false;
	
	_index = A3EAI_monitoredObjects pushBack _object;
	
	_index
';

A3EAI_getUnitLevel = compileFinal '
	private ["_indexWeighted","_unitLevelIndexTable"];
	_unitLevelIndexTable = _this;
	
	_indexWeighted = call {
		if (_unitLevelIndexTable isEqualTo "airvehicle") exitWith {A3EAI_levelIndicesAir};
		if (_unitLevelIndexTable isEqualTo "landvehicle") exitWith {A3EAI_levelIndicesLand};
		[0]
	};
		
	A3EAI_unitLevels select (_indexWeighted call BIS_fnc_selectRandom2)
';

A3EAI_protectGroup = compileFinal '
	private ["_dummy"]; //_this = group
	
	_dummy = _this createUnit ["Logic",[0,0,0],[],0,"FORM"];
	[_dummy] joinSilent _this;
	_this setVariable ["dummyUnit",_dummy];
	if !(isDedicated) then {
		A3EAI_protectGroup_PVS = [_unitGroup,_dummy];
		publicVariableServer "A3EAI_protectGroup_PVS";
	};
	
	if (A3EAI_debugLevel > 1) then {diag_log format["A3EAI Extended Debug: Spawned 1 dummy AI unit to preserve group %1.",_this];};
	
	_dummy
';

A3EAI_addTempNVG = compileFinal '
	if (_this hasWeapon "NVG_EPOCH") exitWith {false};
	_this addWeapon "NVGoggles";
	
	if (A3EAI_debugLevel > 1) then {diag_log format ["A3EAI Extended Debug: Generated temporary NVGs for AI %1.",_this];};
	
	true
';

A3EAI_updateSpawnCount = compileFinal '
	private ["_trigger","_arrayString","_triggerArray"];
	_trigger = _this select 0;
	_arrayString = _this select 1;
	
	_triggerArray = missionNamespace getVariable [_arrayString,[]];
	if (!isNull _trigger) then {
		if (_trigger in _triggerArray) then {
			_triggerArray = _triggerArray - [_trigger,objNull];
		} else {
			if ((triggerStatements _trigger select 1) isEqualTo "") then {
				_triggerArray pushBack _trigger;
			};
		};
	};
	
	_triggerArray = _triggerArray - [objNull];
	missionNamespace setVariable [_arrayString,_triggerArray];
';

A3EAI_deleteGroup = compileFinal '
	[_this,false] call A3EAI_updGroupCount;
	
	{
		if (alive _x) then {
			deleteVehicle _x;
		} else {
			[_x] joinSilent grpNull;
		};
	} count (units _this);
	deleteGroup _this;
	
	true
';

A3EAI_chance = compileFinal '
	private ["_result"];
	_result = ((random 1) < _this);
	
	_result
';


A3EAI_addMapMarker = compileFinal '
	private ["_mapMarkerArray","_objectString"];
	_mapMarkerArray = missionNamespace getVariable ["A3EAI_mapMarkerArray",[]];
	_objectString = str (_this);
	if !(_objectString in _mapMarkerArray) then {	//Determine if marker is new
		if !(_objectString in allMapMarkers) then {
			private ["_marker"];
			_marker = createMarker [_objectString, (getPosASL _this)];
			_marker setMarkerType "mil_circle";
			_marker setMarkerBrush "Solid";
		};
		_mapMarkerArray pushBack _objectString;
		missionNamespace setVariable ["A3EAI_mapMarkerArray",_mapMarkerArray];
	};
	if (_this isKindOf "EmptyDetector") then {	//Set marker as active
		_objectString setMarkerText "STATIC TRIGGER (ACTIVE)";
		_objectString setMarkerColor "ColorRed";
	};
';

A3EAI_purgeUnitGear = compileFinal '
	//Commented lines: Need proper handling for adding these item types first.
	removeAllWeapons _this;
	removeAllItems _this;
	removeAllAssignedItems _this;
	removeGoggles _this;
	removeHeadgear _this;
	removeBackpack _this;
	removeUniform _this;
	removeVest _this;
';

A3EAI_addItem = compileFinal '
	_unit = (_this select 0);
	_item = (_this select 1);
	
	_slot = floor (random 3);
	if ((_slot isEqualTo 0) && {_unit canAddItemToUniform _item}) exitWith {_unit addItemToUniform _item; true};
	if ((_slot isEqualTo 1) && {_unit canAddItemToVest _item}) exitWith {_unit addItemToVest _item; true};
	if ((_slot isEqualTo 2) && {_unit canAddItemToBackpack _item}) exitWith {_unit addItemToBackpack _item; true};
	
	false
';

A3EAI_forceBehavior = compileFinal '
	_action = (_this select 1);
	if (_action isEqualTo "IgnoreEnemies") exitWith {
		_unitGroup = _this select 0;
		_unitGroup setBehaviour "CARELESS";
		{_x doWatch objNull} forEach (units _unitGroup);
		_unitGroup setVariable ["EnemiesIgnored",true];
		
		if (A3EAI_HCIsConnected) then {
			A3EAI_setBehavior_PVC = [_unitGroup,0];
			A3EAI_HCObjectOwnerID publicVariableClient "A3EAI_setBehavior_PVC";
		};
		
		true
	};
	if (_action isEqualTo "Behavior_Reset") exitWith {
		_unitGroup setBehaviour "AWARE";
		_unitGroup setVariable ["EnemiesIgnored",false];
		
		if (A3EAI_HCIsConnected) then {
			A3EAI_setBehavior_PVC = [_unitGroup,1];
			A3EAI_HCObjectOwnerID publicVariableClient "A3EAI_setBehavior_PVC";
		};
		
		true
	};
';

A3EAI_createBlackListArea = compileFinal '
	private ["_pos","_size"];

	_pos = _this select 0;
	_size = _this select 1;

	createLocation ["Strategic",_pos,_size,_size]	
';

A3EAI_setFirstWPPos = compileFinal '
	private ["_unitGroup","_position","_waypoint","_result"];
	_unitGroup = _this select 0;
	_position = _this select 1;
	_result = false;
	if !(surfaceIsWater _position) then {
		_waypoint = [_unitGroup,0];
		_waypoint setWaypointType "MOVE";
		_waypoint setWaypointCompletionRadius 40;
		_waypoint setWaypointTimeout [4,6,8];
		_waypoint setWPPos _position;
		_unitGroup setCurrentWaypoint _waypoint;
		_result = true;
	};
	
	_result
';

A3EAI_secureVehicle = compileFinal '
	_this addEventHandler ["GetIn",{
		if (isPlayer (_this select 2)) then {
			(_this select 2) action ["getOut",(_this select 0)]; 
			(_this select 0) setVehicleLock "LOCKEDPLAYER";
		};
	}];
';

diag_log "[A3EAI] A3EAI functions compiled.";
