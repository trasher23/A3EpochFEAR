private ["_key","_res","_arr","_hld","_car","_pos","_diag","_tbl"];
_diag = diag_tickTime;
for "_i" from 1 to N8M4RE_PersistenceLimit do {
	_key = format["%1:%2", call EPOCH_fn_InstanceID,_i];
	_tbl = format["%2_%1",(worldname),N8M4RE_PersistenceTablePrefix];
	_res = [_tbl,_key] call EPOCH_server_hiveGET;  //EPOCH_server_hiveGETTTL _ttl = _res select 2;
	if((_res select 0) == 1 && typeName(_res select 1) isEqualTo"ARRAY" && !((_res select 1) isEqualTo[])) then {	
		_arr = _res select 1;
		_pos = _arr select 0;
		_car = _arr select 1;
		if ((_car isEqualTo [[],[[],[]],[[],[]],[[],[]]]) || (_pos isEqualTo [])) then {
			[_tbl,_key] call EPOCH_server_hiveDEL;
		} else {
			N8M4RE_PersistenceIndex = N8M4RE_PersistenceIndex + 1;
			_hld = createVehicle ["GroundWeaponHolder",_pos,[],0,"CAN_COLLIDE"];
			_hld setdir (random 360);
			_hld setVariable["BIS_enableRandomization",false];
			_hld setVariable["PERSIST_ID",N8M4RE_PersistenceIndex,true];

			if(surfaceIsWater _pos)then{
			_hld setposASL _pos;
			} else {
			_hld setposATL _pos;
			};
			/*
				[
				[],
				[["U_B_CombatUniform_mcam"],[1]],
				[[],[]],
				[[],[]]],
				[[[[],[[],[]],[["Chemlight_green"],[1]],[[],[]]]]]
			*/
			[_hld,(_car select 0)] call N8M4RE_Persistence_AddWeaponCargo;	
			[_hld,(_car select 1)] call N8M4RE_Persistence_AddItemCargo;	
			[_hld,(_car select 2)] call N8M4RE_Persistence_AddMagazinesCargo;
			[_hld,(_car select 3)] call N8M4RE_Persistence_AddBackpackCargo;
			_hld enableSimulationGlobal true;
		};
	};
};
diag_log format["[N8M4RE PERSISTENCE]: SPAWN TIME: %1",diag_tickTime-_diag];
diag_log format["[N8M4RE PERSISTENCE]: HOLDER SPAWNED: %1",N8M4RE_PersistenceIndex];
true
