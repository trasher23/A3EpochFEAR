if (!isServer) then {	
	
	// Assign mission path to global
	MISSION_ROOT = format ["mpmissions\__cur_mp.%1\", worldName];
	
	// VEMF missions
	"VEMFChatMsg" addPublicVariableEventHandler {
		systemChat ((_this select 1) select 0);
		[
			[
				[((_this select 1) select 0),"align = 'center' size = '1' font='PuristaBold'"],
				["","<br/>"],
				[((_this select 1) select 1),"align = 'center' size = '0.5'"]
			]
		] spawn BIS_fnc_typeText2;
		VEMFChatMsg = nil;
	};

	[] ExecVM "FEAR\nuke\FEAR_nuke_init.sqf";		// Nuke towns
	[] execVM "FEAR\scripts\fn_statusBar.sqf";		// Status bar lower screen
	[] ExecVM "FEAR\scripts\FEAR_ambient_fx.sqf";	// Random sound fx
	
};