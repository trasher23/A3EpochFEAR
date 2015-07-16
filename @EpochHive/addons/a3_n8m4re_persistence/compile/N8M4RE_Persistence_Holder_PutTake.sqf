private ["_ply","_plyVar","_holder","_movItem","_holderPos","_holderCargo","_holderEveryCargo","_holderID","_store","_expire","_dataTable","_indexTable","_instance","_instanceKey"];
if (N8M4RE_PersistenceHolder) then {

if((count N8M4RE_PersistenceHolderIndex) >= N8M4RE_PersistenceHolderLimit)exitWith{diag_log format ["[N8M4RE PERSISTENCE]: Holder Limit reached. (%1)",N8M4RE_PersistenceHolderLimit];true};

_ply = _this select 0;
_plyVar = _ply getVariable "PERSIST_HOLDER_PLY";
_holder = _this select 1;
//_movItem = _this select 2;
_holderPos = getPosATL _holder;
_holderID = _holder getVariable "PERSIST_HOLDER_ID";
_expire = N8M4RE_PersistenceHolderExpires;
_dataTable = format["%1_%2",N8M4RE_PersistenceTablePrefix,"HOLDERS"];
_indexTable = format["%1_%2",N8M4RE_PersistenceTablePrefix,"HOLDERS_INDEX"];
_instance = format["%1",(call EPOCH_fn_InstanceID)];
	
// hint format["%1 - find=%2",(typeOf _holder),(str(_holder) find "dummyweapon.p3d")];
// hint format["%1 - find=%2",(typeOf _holder),str(_holder)];

if ( ((typeOf _holder) == "GroundWeaponHolder")) then {
			
			if (isNil "_holderID") then {	
				N8M4RE_PersistenceHolderIndex pushback 1;
				_holderID = (count N8M4RE_PersistenceHolderIndex) -1;
				_holder setVariable["PERSIST_HOLDER_ID",_holderID,true];
				[_indexTable,_instance,N8M4RE_PersistenceHolderIndex] call EPOCH_server_hiveSET;
			};			
			// hint format["%1",_holderID];
			
			_instanceKey = format["%1:%2",(call EPOCH_fn_InstanceID),_holderID];
			_holderCargo = _holder call N8M4RE_Persistence_GetCargo;
			_holderEveryCargo = _holder call N8M4RE_Persistence_GetEveryContainerCargo;
			_holderEveryCargo = [];
			// diag_log format["%1",_holderCargo]; 	
			if ( _holderCargo isEqualTo [[],[[],[]],[[],[]],[[],[]]] ) then {
				_holder setVariable ["LAST_CHECK", (diag_tickTime + 1260)];	
				_holder setVariable ["PERSIST_HOLDER_ID",nil];	
				_ply setVariable ["PERSIST_HOLDER_PLY",nil];	
				N8M4RE_PersistenceHolderIndex  set [_holderID,0];
				[_indexTable,_instance,N8M4RE_PersistenceHolderIndex] call EPOCH_server_hiveSET;
				N8M4RE_PersistenceHolderIndex deleteAt _holderID;
				// [_dataTable,_instanceKey] call EPOCH_server_hiveDEL;
				// deleteVehicle _holder;
			} else {
				_ply setVariable ["PERSIST_HOLDER_PLY",[_holderID,_holder,_instanceKey]];
				_holder setVariable ["LAST_CHECK",999999];
				_store = [_holderPos,_holderCargo,_holderEveryCargo];
				if (N8M4RE_PersistenceHolderCanExpire) then {
					[_dataTable,_instanceKey,_expire,_store] call EPOCH_server_hiveSETEX;
				} else {
					[_dataTable,_instanceKey,_store] call EPOCH_server_hiveSET;
				};
			};
			
} else {
		if !(isNil "_plyVar") then {
			if ( (_plyVar select 0) == (_plyVar select 1) getVariable "PERSIST_HOLDER_ID" ) then {
				_holderCargo = (_plyVar select 1) call N8M4RE_Persistence_GetCargo;
				_holderEveryCargo = (_plyVar select 1) call N8M4RE_Persistence_GetEveryContainerCargo;
				_holderEveryCargo = [];
				_holderPos = getPosATL( _plyVar select 1);
				_store = [_holderPos,_holderCargo,_holderEveryCargo];
				if (N8M4RE_PersistenceHolderCanExpire) then {
					[_dataTable,(_plyVar select 2),_expire,_store] call EPOCH_server_hiveSETEX;
				} else {
					[_dataTable,(_plyVar select 2),_store] call EPOCH_server_hiveSET;
				};
			};
		};
	};
};

true
