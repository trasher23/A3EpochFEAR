private["_FEAR_30","_tickTime","_index"];

_FEAR_30 = diag_tickTime;

while {true} do {
	
	_tickTime = diag_tickTime;
	
	// Every 30 seconds
	if ((_tickTime - _FEAR_30) > 30) then {
		
		_FEAR_30 = _tickTime;
		
		// If no players near zombie, delete zombie
		{
			_nrPlyrs = nearestObjects [getPos _x, ["Epoch_Female_base_F","Epoch_Man_base_F"],200];
			if (count _nrPlyrs < 1) then {
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
		
		diag_log format["[FEAR] serverLoop _nrPlyrs: %1 FEARZombies: %2",count _nrPlyrs,FEARZombies];
	};	
	uiSleep 0.1;
};