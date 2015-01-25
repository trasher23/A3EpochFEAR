if (!isServer) then {	

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

	[] execVM "FEAR\scripts\fn_statusBar.sqf";	// Status bar lower screen
	[] ExecVM "FEAR\nuke\FEAR_nuke_init.sqf";	// Nuke towns
	
};