private["_timeDiff"];

// Find the Min and Max time
_timeDiff = ((nukeTimerMax*60) - (nukeTimerMin*60));

diag_log "[nuke]: Commencing countdown clock!";

// Initialise loop
while {true} do
{
	// Wait a Random Amount
	uiSleep ((floor(random(_timeDiff))) + (nukeTimerMin*60));
	
	// Initiate countdown
	[] ExecVM "\FEAR\nuke\FEAR_nuke_countDown.sqf";
	diag_log "[nuke]: Cruise Missile Launched!";
	
	// Wait for nuke script to complete
	waitUntil {nukeDetonate};
};
