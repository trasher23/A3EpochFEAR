// ----------------------------------------
//	NUKE Timer - based on EMS timer script
// ----------------------------------------

private["_timeVar"];

diag_log format ["[NUKE]: Commencing countdown clock!"];

// Calculate time variation
_timeVar = (NUKETimerMax - NUKETimerMin) + NUKETimerMin;

// Initialise loop
while {true} do
{
	// Wait for a random period
	sleep round(random _timeVar);
	
	// Initiate countdown
	execVM "\z\addons\dayz_server\FEAR\NUKE\NUKECountdown.sqf";
	diag_log format ["[NUKE]: Cruise Missile Launched!"];
	
	// Wait for NUKE script to complete
	waitUntil {nukeDetonate};
};