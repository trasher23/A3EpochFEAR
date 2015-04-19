if (!isServer) then {	
	
	/* VEMF missions
	-----------------------------------------------------------
	*/
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
	
	/* Nuke eventhandlers
	-----------------------------------------------------------
	*/
	"NUKESiren" addPublicVariableEventHandler {
		[_this select 1] spawn FEAR_fnc_nukeSiren;
		NUKESiren = nil;
	};

	"NUKEImpact" addPublicVariableEventHandler {
		[_this select 1] spawn FEAR_fnc_nukeImpact;
		NUKEImpact = nil;
	};
	
	"NUKEQuake" addPublicVariableEventHandler {
		[random 4] spawn BIS_fnc_earthquake;
		NUKEQuake = nil;
	};
	
	/* Zupa's Capture Points 2.0 eventhandler
	------------------------------------------------------------
	*/
	"PV_ZCP_zupastic" addPublicVariableEventHandler {
	_messageArray = _this select 1;
		hint parseText (format [	   
			"<t color='#ff0000' size='2' align='center'>%1</t><br /><t align='center'>%2</t><br/>",
			_messageArray  select 0,_messageArray  select 1
		]);
	};
	
	/* Load other scripts
	-----------------------------------------------------------
	*/
	call compileFinal preprocessFileLineNumbers "SHK_pos\shk_pos_init.sqf";
	call compileFinal preprocessFileLineNumbers "FEAR\scripts\FEAR_nuke_clientFunctions.sqf";
	
	[] execVM "FEAR\scripts\fn_statusBar.sqf";			// Status bar lower screen
	[] execVM "FEAR\scripts\FEAR_ambientFx.sqf";		// Random sound fx
	[] execVM "FEAR\scripts\FEAR_playerLoadOut.sqf";	// Initial player gear

};
