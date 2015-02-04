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
	
	"NUKESiren" addPublicVariableEventHandler {
		_coords = _this select 1;
		systemChat format ["NUKESiren triggered!, %1", _coords];
		[_coords] spawn FEAR_fnc_nukeSiren;
		NUKESiren = nil;
	};

	"NUKEImpact" addPublicVariableEventHandler {
		_coords = _this select 1;
		systemChat format ["NUKEImpact triggered!, %1", _coords];
		[_coords] spawn FEAR_fnc_nukeImpact;
		NUKEImpact = nil;
	};

	call compileFinal preprocessFileLineNumbers "FEAR\scripts\FEAR_nuke_clientFunctions.sqf";
	
	[] execVM "FEAR\scripts\fn_statusBar.sqf";			// Status bar lower screen
	[] execVM "FEAR\scripts\FEAR_ambientFx.sqf";		// Random sound fx
	[] execVM "FEAR\scripts\FEAR_playerLoadOut.sqf";	// Initial player gear

};
