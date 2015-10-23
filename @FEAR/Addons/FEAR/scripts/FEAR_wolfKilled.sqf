/*
Params:
_this select 0: OBJECT - the killed wolf
_this select 1: OBJECT - killer
*/
private["_target","_killer","_dist","_kMsg","_sent","_curWeapon","_index"];

_target = [_this, 0, objNull, [objNull]] call BIS_fnc_param;
_killer = [_this, 1, objNull, [objNull]] call BIS_fnc_param;

if not isNull _killer then {
	_dist = _target distance _killer;
	if (_dist > -1) then {
		if (isPlayer _killer) then { // Should prevent Error:NoUnit
			_curWeapon = currentWeapon _killer;
			_kMsg = format["%1: wolf kill from %2m with %3",name _killer,round _dist,getText(configFile >> "CfgWeapons" >> _curWeapon >> "DisplayName")];
			_sent = [_kMsg, "sys"] call VEMFr_fnc_broadCast;
		};
	};
};

if not isNull _target then {
	// Remove wolf from array
	_index = FEARCleanup find _target;
	if (_index > -1) then {
		FEARCleanup deleteAt _index;
		publicVariableServer "FEARCleanup";
	};
	
	diag_log format["[FEAR] remaining wolfpack: %1",count FEARCleanup];
	
	uiSleep 300; // Wait 3 minutes, then delete body
	_target hideObjectGlobal true;
	deleteVehicle _target;
};