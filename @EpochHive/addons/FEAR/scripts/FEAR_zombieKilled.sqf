/*
Params:
_this select 0: OBJECT - the killed Zombie
_this select 1: OBJECT - killer
*/
private["_target","_killer","_dist","_kMsg","_sent"];
_target = [_this, 0, objNull, [objNull]] call BIS_fnc_param;
_killer = [_this, 1, objNull, [objNull]] call BIS_fnc_param;
if not isNull _killer then{
	_dist = _target distance _killer;
	if (_dist > -1) then{
		if (isPlayer _killer) then{ // Should prevent Error:NoUnit
			_kMsg = format["%1: zombie kill from %2m",name _killer,round _dist];
			_sent = [_kMsg, "sys"] call VEMF_fnc_broadCast;
		};
	};
};
if not isNull _target then{
	// Decrement global zombie counter
	ZombieTotal = ZombieTotal - 1;
	publicVariableServer "ZombieTotal";
	
	diag_log format["[FEAR] remaining zombies: %1",ZombieTotal];
	
	uiSleep 300; // Wait 3 minutes, then delete
	_target hideObjectGlobal true;
	deleteVehicle _target;
};