private ["_trigger", "_infantryQueue", "_continue","_triggerStatements"];

_trigger = _this select 1;
//diag_log format ["DEBUG: Started random spawn queue with args %1",_this];

if ((_trigger getVariable ["GroupArray",[]]) isEqualTo []) then {
	if (isNil "A3EAI_randomInfantrySpawnQueue") then {
		A3EAI_randomInfantrySpawnQueue = [_this];
		_infantryQueue = [] spawn {
			_continue = true;
			while {_continue} do {
				private ["_args","_trigger"];
				_args = (A3EAI_randomInfantrySpawnQueue select 0);
				_trigger = _args select 1;
				if (triggerActivated _trigger) then {
					_trigger setVariable ["isCleaning",false];
					_triggerStatements = (triggerStatements _trigger);
					_triggerStatements set [1,""];
					_trigger setTriggerStatements _triggerStatements;
					0 = _args call A3EAI_spawnUnits_random;
					if ((!isNil "A3EAI_debugMarkersEnabled") && {A3EAI_debugMarkersEnabled}) then {
						_marker = str(_trigger);
						_marker setMarkerColor "ColorOrange";
						_marker setMarkerAlpha 0.9;
					};
					uiSleep 3;
				};
				A3EAI_randomInfantrySpawnQueue deleteAt 0;
				_continue = !(A3EAI_randomInfantrySpawnQueue isEqualTo []);
			};
			A3EAI_randomInfantrySpawnQueue = nil;
		};
	} else {
		A3EAI_randomInfantrySpawnQueue pushBack _this;
	};
};

true