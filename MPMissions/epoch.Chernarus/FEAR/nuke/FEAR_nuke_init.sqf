call compile preprocessFileLineNumbers "FEAR\nuke\FEAR_nuke_clientFunctions.sqf";
[] execVM "FEAR\nuke\FEAR_nuke_siren.sqf";

"NUKEBlast" addPublicVariableEventHandler {
	[] spawn FEAR_fnc_nukeBlast;
	NUKEBlast = nil;
};