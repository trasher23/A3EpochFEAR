if (!isDedicated) exitWith {};

private["_town","_townName","_townPos", "_msgresponse","_nukeDevice"];

// Get random town
_town = call FEAR_fnc_nukeTarget;
_townName = text _town;
_townPos = position _town;

// Create nuke truck as nuke device
_nukeDevice =  "O_Truck_03_device_F" createVehicle _townPos;

diag_log format ["[FEAR] nuke target: %1",_townName];

// nukeAddMarker is a simple script that adds a marker to the location
[_townPos] call FEAR_fnc_nukeAddMarker;

// Start siren
NUKESiren = _nukeDevice;
publicVariable "NUKESiren";

// Inform players to get the hell out of dodge!
// 2 minute timer till impact
_msgresponse = [format["Nuclear strike. You have %1 minutes to get %2k clear of %3.",2,500,_townName],""] call FEARBroadcast; // Use VEMF broadcast function

// AI run!
[_nukeDevice] spawn FEAR_fnc_escape;

uisleep 60; // Wait 1 minute

// Give warning on 1 minute to go
_msgresponse = [format["Nuclear strike. You now have %1 minute to get %2m clear of %3.",1,500,_townName],""] call FEARBroadcast;

uisleep 60; // Wait 1 minute

// Switch Siren off
NUKESiren = nil;
publicVariable "NUKESiren";

// Drop the Bass...
NUKEDetonate = _nukeDevice;
publicVariable "NUKEDetonate";

[_townPos] spawn FEAR_fnc_nukeServerDamage;

diag_log "[FEAR] nuke has reached its target";

// Remove map markers
deleteMarker "nukeMarkerO";
deleteMarker "nukeMarkerR";
deleteMarker "nukeDot";

// Add radiation zone marker
[] spawn FEAR_fnc_radAddMarker;

// Inform players about radiation zone
_msgresponse = [format["Keep clear of %1 until radiation dissipates.",_townName],""] call FEARBroadcast;

// Activate radiation zone
[_townPos] spawn FEAR_fnc_nukeRadDamage;

// uiSleep 10 minutes
uisleep 600;

// Remove RadZone map markers
deleteMarker "radMarkerR";
deleteMarker "radMarkerY";
// Reset nuke marker
nukeMarkerCoords = nil;
publicVariableServer "nukeMarkerCoords";