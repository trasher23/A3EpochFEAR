call compile preprocessFileLineNumbers "FEAR\nuke\FEAR_nuke_clientFunctions.sqf";

"NUKESiren" addPublicVariableEventHandler {
	[_this select 0] spawn FEAR_fnc_nukeSiren;
	NUKESiren = nil;
};

"NUKEImpact" addPublicVariableEventHandler {
	[_this select 0] spawn FEAR_fnc_nukeImpact;
	NUKEImpact = nil;
};