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
	
	call compile preprocessFileLineNumbers "shk_pos\shk_pos_init.sqf";
	
	[] ExecVM "FEAR\nuke\FEAR_nuke_init.sqf";			// Nuke towns
	[] execVM "FEAR\scripts\fn_statusBar.sqf";			// Status bar lower screen
	[] ExecVM "FEAR\scripts\FEAR_ambientFx.sqf";		// Random sound fx
	[] ExecVM "FEAR\scripts\FEAR_playerLoadOut.sqf";	// Initial player gear
	
};