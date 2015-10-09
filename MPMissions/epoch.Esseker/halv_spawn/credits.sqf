/*
	Simple Credits script
	by Halv
	Copyright (C) 2015  Halvhjearne > README.md
*/
if(isServer)exitWith{};

// Start with apocalyptic environment
_sound = MISSION_directory + "FEAR\fx\dimensionfold.ogg";
playSound3D [_sound,player];
[] spawn FEAR_fnc_nukeFlash;
[] spawn FEAR_fnc_nukeAsh;
enableEnvironment true;

sleep 3; // Wait for client to load

_alltext = [
	[
		// Title
		"Epoch F.E.A.R.",
		[
			// Sub text
			"No bullshit PVP/PVE",
			"AI is a bitch",
			"Fuck Everything and RUN!"
		]
	]
];

{
	sleep 2; // Wait between texts
	
	_memberFunction = _x select 0;
	_memberNames = _x select 1;
	_color = "#71C700"; // Light green
	
	_finalText = format["<t size='1.0'color='%2'align='left'shadow='1'>%1<br /></t><t size='0.1'><br /></t><t size='0.5'shadow='1'color='#EBEBEB'align='left'>",_memberFunction,_color];
	
	{
		_finalText =_finalText + format["%1<br />", _x];
	}forEach _memberNames;
	
	_finalText = _finalText + "</t>";
	_onScreenTime = (count _memberNames) * 0.5;
	if(_onScreenTime < 6)then{_onScreenTime = 5};
	[_finalText,[safezoneX + safezoneW - 0.5,0.35],[safezoneY + safezoneH - 0.8,0.7],_onScreenTime,0.5] spawn BIS_fnc_dynamicText;
	sleep _onScreenTime;
}forEach _alltext;