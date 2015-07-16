private ["_index","_res","_arr","_hld","_car","_pos","_diag","_id"];
if (N8M4RE_PersistenceHolder) then {
_diag = diag_tickTime;
_index = [format["%1_%2",N8M4RE_PersistenceTablePrefix,"HOLDERS_INDEX"],format["%1",(call EPOCH_fn_InstanceID)]] call EPOCH_server_hiveGET;
if ((_index select 0)==1 && typeName(_index select 1)=="ARRAY") then {
	if !((_index select 1) isEqualTo []) then {	
		_id=0;
		{		
			if (_x == 1) then {
				_res = [format["%1_%2",N8M4RE_PersistenceTablePrefix,"HOLDERS"],format["%1:%2",(call EPOCH_fn_InstanceID),_forEachIndex]] call EPOCH_server_hiveGET;
				if ((_res select 0) == 1 && typeName(_res select 1) == "ARRAY") then {
					if !((_res select 1) isEqualTo []) then {						
						_arr= _res select 1;
						_pos= _arr select 0;
						_car= _arr select 1;	 
						
						if !(_car isEqualTo[[],[[],[]],[[],[]],[[],[]]] || (_arr select 0)isEqualTo[]) then {
							N8M4RE_PersistenceHolderIndex pushback 1;	
							_hld = createVehicle ["GroundWeaponHolder",(_arr select 0),[],0,"CAN_COLLIDE"];
							_hld setVariable["PERSIST_HOLDER_ID",_id,true];
							_hld setVariable["LAST_CHECK",999999];
							_hld setVariable["BIS_enableRandomization",false];
							_hld setdir (random 360);		
							if (surfaceIsWater _pos)then{_hld setposASL _pos;}else{_hld setposATL _pos;};	
							[_hld,(_car select 0)] call N8M4RE_Persistence_AddWeaponCargo;	
							[_hld,(_car select 1)] call N8M4RE_Persistence_AddItemCargo;	
							[_hld,(_car select 2)] call N8M4RE_Persistence_AddMagazinesCargo;
							[_hld,(_car select 3)] call N8M4RE_Persistence_AddBackpackCargo;
							_hld enableSimulationGlobal true;
							_id = _id + 1;
						};
					};
				};
			};	
		} forEach (_index select 1);
	};
};
diag_log format["[N8M4RE PERSISTENCE]: HOLDER SPAWN TIME: %1",diag_tickTime-_diag];
diag_log format["[N8M4RE PERSISTENCE]: HOLDER SPAWNED: %1",(count N8M4RE_PersistenceHolderIndex)];
};
true
