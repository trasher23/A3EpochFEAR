private ["_timeDiff"];

// Find the min and max time
_timeDiff = ((eqTimerMax*60) - (eqTimerMin*60));

diag_log "[earthquake]: Commencing countdown clock!";

// Initialise loop
while {true} do
{
	// Wait a Random Amount
	uiSleep ((floor(random(_timeDiff))) + (eqTimerMin*60));
	
	NUKEQuake = true;
	{
		if (isPlayer _x) then {
			(owner (vehicle _x)) publicVariableClient "NUKEQuake";
		};
	} forEach playableUnits;

};
