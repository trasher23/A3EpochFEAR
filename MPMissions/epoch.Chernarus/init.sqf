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

	[] execVM "FEAR\scripts\FEAR_welcome.sqf";	// Welcome credits
	[] ExecVM "FEAR\scripts\FEAR_soundFx.sqf";	// Random sound fx
	[] ExecVM "FEAR\scripts\FEAR_earthquake.sqf";	// Random earthquake - need to move trigger to server
	[] execVM "FEAR\scripts\fn_statusBar.sqf";	// Status bar lower screen
	[] ExecVM "FEAR\nuke\FEAR_nuke_init.sqf";	// Nuke towns
};

[] ExecVM "R3F_LOG\init.sqf";			// [R3F] Logistics http://forums.bistudio.com/showthread.php?180049-R3F-Logistics
DAC_Basic_Value = 0;execVM "DAC\DAC_Config_Creator.sqf";	// DAC AI Generator http://forums.bistudio.com/showthread.php?176926-DAC-V3-1-%28Dynamic-AI-Creator%29-released/page18