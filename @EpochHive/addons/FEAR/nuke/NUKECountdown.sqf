// ---------------
//	Launch NUKE!
// ---------------

if (isDedicated) then {
	private["_town","_townName","_townPos","_nukePad","_varName","_msg","_alert"];
	
	_town = call nukeTarget; // Get random town
	_townName = text _town; // Assign town name
	_townPos = position _town; // Get town position
	
	diag_log format ["[NUKE]: Target: %1", _townName];

	// Assign _townPos as a PublicVariable: nukeCoords
	// This is used in the NUKEMarkerLoop.sqf and Mission.PBO NUKE files
	_nukePad = createVehicle ["Land_HelipadEmpty_F",_townPos,[],0,"NONE"];
	_varName = "nukeCoords";
	_nukePad setVehicleVarName _varName;
	_nukePad call compile format ["%1=_This ; PublicVariable ""%1""",_varName];

	// Inform players to get the hell out of dodge!
	// 3 minute timer till impact
	_msg = format ["You have %1 minutes to get %2k clear of %3.",3,1,_townName];
	_msg = ["Nuclear Strike",_msg];
	_alert = [_msg] call VEMFBroadcast; // Use VEMF broadcast function

	// NUKEAddMarker is a simple script that adds a marker to the location
	[_townPos] ExecVM "\FEAR\NUKE\NUKEAddMarker.sqf";

	// Start air-raid siren
	nukeSiren = true;
	publicVariable "nukeSiren";

	// Wait 2 minutes
	sleep 120;
	
	// Give warning on 1 minute to go
	_msg = format ["You now have %1 minute to get %2k clear of %3.",1,1,_townName];
	_msg = ["Nuclear Strike",_msg];
	_alert = [_msg] call VEMFBroadcast;
	
	sleep 60;
	
	// Broadcast nukeDetonate to clients
	// This will enable the NUKE script
	nukeDetonate = true;
	publicVariable "nukeDetonate";
	
	[_townPos] ExecVM "\FEAR\NUKE\NUKEServerDamage.sqf";

	diag_log "[NUKE]: Cruise missile has reached its target.";
	
	sleep 1;
	
	// Remove map markers
	deleteMarker "NUKEMarkerO";
	deleteMarker "NUKEMarkerR";
	deleteMarker "NUKEDot";
	
	nukeDetonate = false;
	publicVariable "nukeDetonate";
	
	// Delete nukepad
	deleteVehicle _nukePad;
	
	sleep 1;
	
	// Inform players about radiation zone
	_msg = format ["You will need to keep clear of %1 until the radiation cloud dissipates.",_townName];
	_msg = ["Nuclear Strike",_msg];
	_alert = [_msg] call VEMFBroadcast;
	
	nukeRadZone = True;
	publicVariable "nukeRadZone";
	
	// Add radiation zone marker
	[] ExecVM "\FEAR\NUKE\NUKEAddRadMarker.sqf";
	// Activate radiation zone
	[_townPos] ExecVM "\FEAR\NUKE\NUKERadZone.sqf";
	
	// Wait length of time for RadZone (15 minutes)
	sleep 900;
};
