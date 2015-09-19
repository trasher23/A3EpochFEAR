while {true} do
{
	waitUntil {alive vehicle player};
	Sleep 30;
	[] execVM "FEAR\scripts\EtV.sqf";
	waitUntil {!isNil "EtVInitialized"};
	[player] call EtV_Actions;

	waitUntil {!alive player};
	Sleep 30;
	[] execVM "FEAR\scripts\EtV.sqf";
	waitUntil {!isNil "EtVInitialized"};
	[player] call EtV_Actions;
};