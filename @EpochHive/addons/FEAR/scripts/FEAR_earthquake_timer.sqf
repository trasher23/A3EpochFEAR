private ["_timeDiff"];

// Find the min and max time
_timeDiff = ((EQMaxMissTime*60) - (EQMinMissTime*60));

diag_log "[earthquake]: Commencing countdown clock!";

// Initialise loop
while {true} do
{
	// Wait a Random Amount
	uiSleep ((floor(random(_timeDiff))) + (EQMinMissTime*60));
	
	FEARQuake = true;
	{
		if (isPlayer _x) then {
			(owner (vehicle _x)) publicVariableClient "FEARQuake";
		};
	} forEach playableUnits;

};
