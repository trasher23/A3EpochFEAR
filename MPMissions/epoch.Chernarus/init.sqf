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

	"FEARNuke" addPublicVariableEventHandler { [_this select 0] ExecVM "FEAR\nuke\nuke.sqf"; };
	"FEARNukeSiren" addPublicVariableEventHandler { [_this select 0] ExecVM "FEAR\nuke\nukeSiren.sqf"; };
};
