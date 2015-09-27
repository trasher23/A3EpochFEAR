private ["_timeDiff"];

// Find the min and max time
_timeDiff = ((EqTimerMax*60) - (EqTimerMin*60));

diag_log "[FEAR] starting earthquake timer";

// Initialise loop
while {true} do
{
	// Wait a Random Amount
	uiSleep ((floor(random(_timeDiff))) + (EqTimerMin*60));
	
	NUKEQuake = true;
	{
		if (isPlayer _x) then {
			(owner (vehicle _x)) publicVariableClient "NUKEQuake";
		};
	} forEach playableUnits;

};
