/*
Params:
_this select 0: OBJECT - the killed Zombie
_this select 1: OBJECT - killer
*/
private["_target","_killer","_ammo","_ammoAmount","_dist","_kMsg","_sent","_curWeapon","_index","_selectAmmo"];

_target = [_this,0,objNull,[objNull]] call BIS_fnc_param;
_killer = [_this,1,objNull,[objNull]] call BIS_fnc_param;

if not isNull _killer then {
	_dist = _target distance _killer;
	if (_dist > -1) then {
		if (isPlayer _killer) then { // Should prevent Error:NoUnit
			_curWeapon = currentWeapon _killer;
			_kMsg = format["%1: zombie kill from %2m with %3",name _killer,round _dist,getText(configFile >> "CfgWeapons" >> _curWeapon >> "DisplayName")];
			_sent = [_kMsg, "sys"] call VEMFr_fnc_broadCast;
			
			// Percentage chance of adding player weapon ammo to zombie vest
			if (40 > random 100) then {
				_ammo = _curWeapon call FEARGetAmmo;
				if (count _ammo > 0) then {
					_selectAmmo = _ammo select(floor(random(count _ammo))); // Select random ammo
					diag_log format["[FEAR] zombie ammo: %1",_selectAmmo];
					_ammoAmount = round(1 + ceil(random 3));
					for "_i" from 0 to _ammoAmount do {
						diag_log "[FEAR] ammo added to vest";
						_target addItemToVest format["%1",_selectAmmo]; 
					};
				};
			};
		};
	};
};

if not isNull _target then {
	// Remove zombie from array
	_index = FEARCleanup find _target;
	if (_index > -1) then {
		FEARCleanup deleteAt _index;
		publicVariableServer "FEARCleanup";
	};
	
	diag_log format["[FEAR] remaining zombies: %1",count FEARCleanup];
	
	uiSleep 300; // Wait 3 minutes, then delete body
	_target hideObjectGlobal true;
	deleteVehicle _target;
};