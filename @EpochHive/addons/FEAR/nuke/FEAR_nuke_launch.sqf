private["_town","_townName","_townPos","_msg","_alert"];

// Get random town
_town = call FEAR_fnc_nukeTarget;
_townName = text _town;
_townPos = position _town;

diag_log format ["[nuke]: Target: %1", _townName];
	
// Inform players to get the hell out of dodge!
// 3 minute timer till impact
_msg = format ["You have %1 minutes to get %2k clear of %3.",3,1,_townName];
_msg = ["Nuclear Strike",_msg];
_alert = [_msg] call VEMFBroadcast; // Use VEMF broadcast function

// nukeAddMarker is a simple script that adds a marker to the location
[_townPos] call FEAR_fnc_nukeAddMarker;

// Start siren
NUKESiren = "Land_HelipadEmpty_F" createVehicle _townPos;
{
	if (isPlayer _x) then {
		(owner (vehicle _x)) publicVariableClient "NUKESiren";
	};
} forEach playableUnits;

// Wait 2 minutes
uisleep 120;

// Give warning on 1 minute to go
_msg = format ["You now have %1 minute to get %2k clear of %3.",1,1,_townName];
_msg = ["Nuclear Strike",_msg];
_alert = [_msg] call VEMFBroadcast;

uisleep 60;

// Drop the Bass...
NUKEImpact = "Land_HelipadEmpty_F" createVehicle _townPos;
{
	if (isPlayer _x) then {
		(owner (vehicle _x)) publicVariableClient "NUKEImpact";
	};
} forEach playableUnits;

[_townPos] spawn FEAR_fnc_nukeServerDamage;

diag_log "[nuke]: Cruise missile has reached its target.";

// Remove map markers
deleteMarker "nukeMarkerO";
deleteMarker "nukeMarkerR";
deleteMarker "nukeDot";

// Add radiation zone marker
[] spawn FEAR_fnc_radAddMarker;

// Inform players about radiation zone
_msg = format ["You will need to keep clear of %1 until the radiation cloud dissipates.",_townName];
_msg = ["Nuclear Strike",_msg];
_alert = [_msg] call VEMFBroadcast;

// Activate radiation zone
[] call FEAR_fnc_nukeRadDamage;

// Remove RadZone map markers
deleteMarker "RADMarkerR";
deleteMarker "RADMarkerY";
nukeMarkerCoords = nil;
