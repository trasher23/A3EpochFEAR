private ["_timeDiff","_maxTime","_minTime"];

_minTime = 5; // minutes
_maxTime = 30; 

// Find the min and max time
_timeDiff = ((_maxTime*60) - (_minTime*60));

diag_log "[earthquake]: Commencing countdown clock!";

// Initialise loop
while {true} do
{
	// Wait a Random Amount
	uiSleep ((floor(random(_timeDiff))) + (_minTime*60));
	
	FEARQuake = true;
	{
		if (isPlayer _x) then {
			(owner (vehicle _x)) publicVariableClient "FEARQuake";
		};
	} forEach playableUnits;

};