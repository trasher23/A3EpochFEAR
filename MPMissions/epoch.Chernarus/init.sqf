if (!isServer) then {	
	
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
	
	[] execVM "FEAR\nuke\FEAR_nuke_init.sqf";		// Nuke towns
	[] execVM "FEAR\scripts\fn_statusBar.sqf";		// Status bar lower screen
	[] execVM "FEAR\scripts\FEAR_ambientFx.sqf";		// Random sound fx
	[] execVM "FEAR\scripts\FEAR_playerLoadOut.sqf";	// Initial player gear

};
