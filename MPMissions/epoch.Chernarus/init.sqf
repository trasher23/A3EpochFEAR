if (!isServer) then {
	MISSION_ROOT = format ["mpmissions\epoch.%1\", worldName];
	
	"VEMFChatMsg" addPublicVariableEventHandler {
		[
			[
				[((_this select 1) select 0),"align = 'center' size = '1' font='PuristaBold'"],
				["","<br/>"],
				[((_this select 1) select 1),"align = 'center' size = '0.5'"]
			]
		] spawn BIS_fnc_typeText2;
		sleep 15;
		VEMFChatMsg = nil;
	};

	[] ExecVM "FEAR\nuke\NUKEInit.sqf";		// Nuke towns
	[] execVM "FEAR\scripts\welcome.sqf";		// Welcome credits
	[] ExecVM "FEAR\scripts\ambient_fx.sqf";	// Random sound fx
	[] ExecVM "FEAR\scripts\earthquake.sqf";	// Random earthquake - need to move trigger to server
	[] execVM "FEAR\scripts\fn_statusBar.sqf";	// Status bar lower screen
};
