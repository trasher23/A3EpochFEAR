if (!isServer) then {	

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

	[] execVM "FEAR\scripts\fn_statusBar.sqf";	// Status bar lower screen
	[] ExecVM "FEAR\nuke\FEAR_nuke_init.sqf";	// Nuke towns
	[] ExecVM "FEAR\tow_and_transport\init.sqf";
};