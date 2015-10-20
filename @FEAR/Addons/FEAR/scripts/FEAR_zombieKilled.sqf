/*
Params:
_this select 0: OBJECT - the killed Zombie
_this select 1: OBJECT - killer
*/
private["_target","_killer","_dist","_kMsg","_sent","_curWeapon","_index"];
_target = [_this, 0, objNull, [objNull]] call BIS_fnc_param;
_killer = [_this, 1, objNull, [objNull]] call BIS_fnc_param;
if not isNull _killer then{
	_dist = _target distance _killer;
	if (_dist > -1) then{
		if (isPlayer _killer) then{ // Should prevent Error:NoUnit
			_curWeapon = currentWeapon _killer;
			_kMsg = format["%1: zombie kill from %2m with %3",name _killer,round _dist,getText(configFile >> "CfgWeapons" >> _curWeapon >> "DisplayName")];
			_sent = [_kMsg, "sys"] call VEMFr_fnc_broadCast;
		};
	};
};
if not isNull _target then{
	// Remove zombie from array
	_index = FEARZombies find _target;
	if (_index > -1) then
	{
		FEARZombies deleteAt _index;
		publicVariableServer "FEARZombies";
	};
	
	diag_log format["[FEAR] remaining zombies: %1",count FEARZombies];
	
	uiSleep 300; // Wait 3 minutes, then delete
	_target hideObjectGlobal true;
	deleteVehicle _target;
};