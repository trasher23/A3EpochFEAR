private ["_ply","_con","_movItem","_conPos","_conCargo","_conEveryCargo","_conId","_store"];
if(N8M4RE_PersistenceIndex >= N8M4RE_PersistenceLimit)exitWith{true};
_ply = _this select 0;
_plyVar = _ply getVariable "PERSIST_PLY";	
_con = _this select 1;
_movItem = _this select 2;
_conPos = getPosATL _con;
_conId = _con getVariable "PERSIST_ID";	
_tbl = format["%2_%1",(worldname),N8M4RE_PersistenceTablePrefix];
_expire = N8M4RE_PersistenceExpires;
//hint format["%1 - find=%2",(typeOf _con),(str(_con) find "dummyweapon.p3d")];
if ( ((typeOf _con) == "GroundWeaponHolder")) then {

		if ( isNil "_conId" ) then {
			N8M4RE_PersistenceIndex = N8M4RE_PersistenceIndex + 1;	
			_con setVariable["PERSIST_ID",N8M4RE_PersistenceIndex,true];
		} else { 
			N8M4RE_PersistenceIndex = _conId; 
		};			
			_key = format["%1:%2",(call EPOCH_fn_InstanceID),N8M4RE_PersistenceIndex];
			_conCargo = _con call N8M4RE_Persistence_GetCargo;
			_conEveryCargo = _con call N8M4RE_Persistence_GetEveryContainerCargo;
			_conEveryCargo = [];
			//diag_log format["%1",_conCargo]; 
		if ( _conCargo isEqualTo [[],[[],[]],[[],[]],[[],[]]] ) then {
			[_tbl,format["%1:%2",(call EPOCH_fn_InstanceID),N8M4RE_PersistenceIndex]] call EPOCH_server_hiveDEL;
			deleteVehicle _con;
			N8M4RE_PersistenceIndex = N8M4RE_PersistenceIndex - 1;
			_ply setVariable ["PERSIST_PLY",nil];
		
		} else {
			_store = [_conPos,_conCargo,_conEveryCargo];
			hint format["%1",_conEveryCargo];	
			[_tbl,_key,_expire,_store] call EPOCH_server_hiveSETEX;
			_ply setVariable ["PERSIST_PLY",[N8M4RE_PersistenceIndex,_con,_key]];
		};
			
} else {
		
		if !(isNil "_plyVar") then {
			if ( (_plyVar select 0) == (_plyVar select 1) getVariable "PERSIST_ID" ) then {
				_conCargo = (_plyVar select 1) call N8M4RE_Persistence_GetCargo;
				_conEveryCargo = (_plyVar select 1) call N8M4RE_Persistence_GetEveryContainerCargo;
				_conEveryCargo = [];
				_conPos = getPosATL( _plyVar select 1);
				_store = [_conPos,_conCargo,_conEveryCargo];
				[_tbl,(_plyVar select 2),_expire,_store] call EPOCH_server_hiveSETEX;
			};
		};
};
true
