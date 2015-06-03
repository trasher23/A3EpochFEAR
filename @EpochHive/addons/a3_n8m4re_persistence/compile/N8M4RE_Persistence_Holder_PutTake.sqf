private ["_ply","_plyVar","_holder","_movItem","_holderIndexCount","_holderPos","_holderCargo","_holderEveryCargo","_holderID","_store"];

_holderIndexCount = count N8M4RE_PersistenceHolderIndex;
if( _holderIndexCount >= N8M4RE_PersistenceHolderLimit)exitWith{true};
_ply = _this select 0;
_plyVar = _ply getVariable "PERSIST_HOLDER_PLY";	
_holder = _this select 1;
//_movItem = _this select 2;
_holderPos = getPosATL _holder;
_holderID = _holder getVariable "PERSIST_HOLDER_ID";	
_expire = N8M4RE_PersistenceHolderExpires;
_tbl = format["%1_%2",N8M4RE_PersistenceTablePrefix,"HOLDERS"];

//hint format["%1 - find=%2",(typeOf _holder),(str(_holder) find "dummyweapon.p3d")];

if ( ((typeOf _holder) == "GroundWeaponHolder")) then {
		
		if ( isNil "_holderID" ) then {
				N8M4RE_PersistenceHolderIndex sort true;
				reverse N8M4RE_PersistenceHolderIndex;
				_holderID = 1;
			if ( _holderIndexCount > 0 ) then {
				_holderID = N8M4RE_PersistenceHolderIndex select 0;
				_holderID = _holderID + 1;
			};
			N8M4RE_PersistenceHolderIndex pushback _holderID;
			_holder setVariable["PERSIST_HOLDER_ID",_holderID,true];
			[format["%1_%2",N8M4RE_PersistenceTablePrefix,"HOLDERS_INDEX"],format["%1",(call EPOCH_fn_InstanceID)],N8M4RE_PersistenceHolderIndex] call EPOCH_server_hiveSET;
		};			
		
		
		_key = format["%1:%2",(call EPOCH_fn_InstanceID),_holderID];
		_holderCargo = _holder call N8M4RE_Persistence_GetCargo;
		_holderEveryCargo = _holder call N8M4RE_Persistence_GetEveryContainerCargo;
		_holderEveryCargo = [];
		//diag_log format["%1",_holderCargo]; 
			
		if ( _holderCargo isEqualTo [[],[[],[]],[[],[]],[[],[]]] ) then {
		
			_holder setVariable ["LAST_CHECK",nil];	
			_holder setVariable ["PERSIST_HOLDER_ID",nil];	
			_ply setVariable ["PERSIST_HOLDER_PLY",nil];
			
			if (_holderID in N8M4RE_PersistenceHolderIndex) then {
				N8M4RE_PersistenceHolderIndex deleteAt (N8M4RE_PersistenceHolderIndex find _holderID);
				[format["%1_%2",N8M4RE_PersistenceTablePrefix,"HOLDERS_INDEX"],format["%1",(call EPOCH_fn_InstanceID)],N8M4RE_PersistenceHolderIndex] call EPOCH_server_hiveSET;
			};
			// deleteVehicle _holder;
			// [_tbl,_key] call EPOCH_server_hiveDEL;
		} else {
			_holder setVariable ["LAST_CHECK",1000000000000];
			_store = [_holderPos,_holderCargo,_holderEveryCargo];
			// hint format["%1",_holderEveryCargo];	
			[_tbl,_key,_expire,_store] call EPOCH_server_hiveSETEX;
			_ply setVariable ["PERSIST_HOLDER_PLY",[_holderID,_holder,_key]];
		};
		
} else {
		
		if !(isNil "_plyVar") then {
			if ( (_plyVar select 0) == (_plyVar select 1) getVariable "PERSIST_HOLDER_ID" ) then {
				_holderCargo = (_plyVar select 1) call N8M4RE_Persistence_GetCargo;
				_holderEveryCargo = (_plyVar select 1) call N8M4RE_Persistence_GetEveryContainerCargo;
				_holderEveryCargo = [];
				_holderPos = getPosATL( _plyVar select 1);
				_store = [_holderPos,_holderCargo,_holderEveryCargo];
				[_tbl,(_plyVar select 2),_expire,_store] call EPOCH_server_hiveSETEX;
			};
		};
};

true
