// ----------------------------------------
//	NUKE Timer - based on EMS timer script
// ----------------------------------------

private["_timeDiff"];

// Find the Min and Max time
_timeDiff = ((NUKETimerMax*60) - (NUKETimerMin*60));

diag_log "[NUKE]: Commencing countdown clock!";

// Initialise loop
while {true} do
{
	// Wait a Random Amount
	uiSleep ((floor(random(_timeDiff))) + (NUKETimerMin*60));
	
	// Initiate countdown
	[] ExecVM "\FEAR\NUKE\NUKECountdown.sqf";
	diag_log "[NUKE]: Cruise Missile Launched!";
	
	// Wait for NUKE script to complete
	waitUntil {nukeDetonate};
};
