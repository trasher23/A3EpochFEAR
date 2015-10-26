private["_FEAR_60","_tickTime","_plyrCount","_index"];

_FEAR_60 = diag_tickTime;
_plyrCount = 0;

while {true} do {
	
	_tickTime = diag_tickTime;
	
	// Every 60 seconds
	if ((_tickTime - _FEAR_60) > 60) then {
		
		_FEAR_60 = _tickTime;
		
		// If no players near zombie, delete zombie
		{	
			_plyrCount = count((getPosWorld _x) nearEntities[["Epoch_Female_base_F","Epoch_Man_base_F"],500]);
			if (_plyrCount < 1) then {
				_x hideObjectGlobal true;
				deleteVehicle _x;
				
				// Remove zombie from array
				_index = FEARCleanup find _x;
				if (_index > -1) then {
					FEARCleanup deleteAt _index;
					publicVariableServer "FEARCleanup";
				};
			};
		}forEach FEARCleanup;
		
		//diag_log format["[FEAR] serverLoop nearPlayers: %1,  FEARCleanup: %2",_plyrCount,count FEARCleanup];
		
		// Earthquake timer - 10% chance
		if (10 > random 100) then {
			{
				// Send quake to all players
				if (isPlayer _x) then {
					NUKEQuake = true;
					(owner (vehicle _x)) publicVariableClient "NUKEQuake";
				};
			}forEach playableUnits;
		};
	};	
	uiSleep 0.1;
};