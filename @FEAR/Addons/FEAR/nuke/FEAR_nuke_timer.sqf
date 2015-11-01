/*
	FEAR_nuke_timer.sqf
*/

if (!isDedicated) exitWith {};

private["_timeDiff","_allPlayers"];

// Find the Min and Max time
_timeDiff = ((NukeTimerMax*60) - (NukeTimerMin*60));

// Default nukeMarkerCoords to nil
nukeMarkerCoords = nil;

diag_log "[FEAR] starting nuke timer";

// Initialise loop
while {true} do
{
	// Wait a Random Amount
	uiSleep ((floor(random(_timeDiff))) + (NukeTimerMin*60));
	
	// Get players
	_allPlayers = call FEARGetPlayers;
	
	// Initiate countdown if players on server
	if ((count _allPlayers) >= 1) then 
	{
		if (isNil "nukeMarkerCoords") then {
			[] execVM format ["%1\nuke\FEAR_nuke_launch.sqf",FEAR_directory];
			diag_log "[FEAR] nuke launch";
		};
	};
};
