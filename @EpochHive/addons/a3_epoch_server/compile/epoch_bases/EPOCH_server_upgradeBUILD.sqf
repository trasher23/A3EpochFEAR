/*
Building Upgrades

Epoch Mod - EpochMod.com
All Rights Reserved.
*/
private["_worldspace", "_class", "_newObj", "_objHiveKey", "_VAL", "_return", "_upgrade", "_objSlot", "_objType", "_object", "_player"];

_object = _this select 0;
_player = _this select 1;

if (isNull _object) exitWith{};
if !([_player, _this select 2] call EPOCH_server_getPToken) exitWith{};

_objSlot = _object getVariable["BUILD_SLOT", -1];
if (_objSlot != -1) then {
	_upgrade = getArray(configFile >> "CfgVehicles" >> (typeOf _object) >> "upgradeBuilding");
	if !(_upgrade isEqualTo []) then {
		
		_objectPos = getposATL _object;
		_worldspace = [(_objectPos call EPOCH_precisionPos), vectordir _object, vectorup _object];

		deleteVehicle _object;
		_class = _upgrade select 0;

		_newObj = createVehicle [_class, _objectPos, [], 0, "CAN_COLLIDE"];
		_newObj setVariable ["BUILD_SLOT",_objSlot,true];
		_newObj call EPOCH_server_buildingInit;
		_newObj setVectorDirAndUp [(_worldspace select 1),(_worldspace select 2)];
		_newObj setposATL _objectPos;

		_objHiveKey = format ["%1:%2", (call EPOCH_fn_InstanceID),_objSlot];
		_VAL = [_class,_worldspace];
		_return = ["Building", _objHiveKey, EPOCH_expiresBuilding, _VAL] call EPOCH_server_hiveSETEX;
		//_return = ["Building", _objHiveKey, _VAL] call EPOCH_server_hiveSET;
	};
} else {
	_objType = typeOf _object;
	// ToDo make this config based
	if (_objType == "FirePlace_EPOCH") then {
		_upgrade = getArray(configFile >> "CfgVehicles" >> (typeOf _object) >> "upgradeBuilding");
		if !(_upgrade isEqualTo[]) then {

			_worldspace = [getposATL _object, vectordir _object, vectorup _object];
			deleteVehicle _object;
			_class = _upgrade select 0;

			_newObj = createVehicle[_class, (_worldspace select 0), [], 0, "CAN_COLLIDE"];
			_newObj setVectorDirAndUp[(_worldspace select 1), (_worldspace select 2)];
			_newObj setposATL(_worldspace select 0);
		};
	} else {
		diag_log format["DEBUG upgrade BUILD : %1 slot %2", _object, _objSlot];
	};
};
