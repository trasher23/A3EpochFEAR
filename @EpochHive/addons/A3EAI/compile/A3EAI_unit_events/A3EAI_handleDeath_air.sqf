private ["_vehicle","_victim","_unitGroup","_parachuted"];

_victim = _this select 0;
_unitGroup = _this select 1;

_vehicle = (_unitGroup getVariable ["assignedVehicle",objNull]);
if (alive _vehicle) then {
	if (_victim getVariable ["isDriver",false]) then {
		_unitGroup setVariable ["unitType","aircrashed"]; //prevent this case from being run for ejected non-pilot units
		_parachuted = [_vehicle,_unitGroup] call A3EAI_heliEvacuated;
		if (_parachuted) then {
			_nul = _vehicle spawn {
				_this setFuel 0;
				_this setVehicleAmmo 0;
				uiSleep 2.5;
				_this setDamage 1;
			};
			if (A3EAI_debugLevel > 0) then {diag_log format ["A3EAI Debug: AI %1 pilot unit %2 was killed, ejecting surviving crew.",(typeOf _vehicle),(typeOf _victim)];};
		};
	};
};

true
