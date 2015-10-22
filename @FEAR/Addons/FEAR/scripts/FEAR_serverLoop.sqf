private["_FEAR_30","_tickTime","_plyrCount","_index"];

_FEAR_30 = diag_tickTime;
_plyrCount = 0;

while {true} do {
	
	_tickTime = diag_tickTime;
	
	// Every 30 seconds
	if ((_tickTime - _FEAR_30) > 30) then {
		
		_FEAR_30 = _tickTime;
		
		// If no players near zombie, delete zombie
		{	
			_plyrCount = count((getPosWorld _x) nearEntities[["Epoch_Female_base_F","Epoch_Man_base_F"],200]);
			if (_plyrCount == 0) then {
				_x hideObjectGlobal true;
				deleteVehicle _x;
				
				// Remove zombie from array
				_index = FEARZombies find _x;
				if (_index > -1) then {
					FEARZombies deleteAt _index;
					publicVariableServer "FEARZombies";
				};
			};
		}forEach FEARZombies;

		diag_log format["[FEAR] serverLoop _nrPlyrs: %1 FEARZombies: %2",_plyrCount,count FEARZombies];
	};	
	uiSleep 0.1;
};