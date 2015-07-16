/*
	File: OX3_GetInProtect.sqf
	Author: ScaRR
	Date: 2 June 2015
	Description: This script protects helis when a player gets close to a vehicles and the locality changes, at times this can cause a vehicle to explode or when the player 
	gets into the pilot seat.
	This script could possibly be optimised a bit more and needs further testing. 
	
	BE filters:
		
		setvariable.txt
			append !="added_EHProtect" !="GotIn" !="LocalChanged" 
		
		scripts.txt (note, your line numbers might differ
			line 22: append !="_x allowDamage true;" !="_vehicle allowDamage false"
			line 48: append !="_x setDamage 0;"
			if you get kicked for addEventHandler then add
			line 53: !="_x addEventHandler [\"GetIn\", {_this call fn_handleGetIn;}];" !="_x addEventHandler [\"Local\", {_this call fn_handleLocal;}];"
			
	Installation:
		Copy into your scripts folder, add this line to your init.sqf, execVM \"scripts\OX3_GetInProtect.sqf";
	
		
	PLEASE KEEP CREDITS - THEY ARE DUE TO THOSE WHO PUT IN THE EFFORT!	
*/

if(isServer) exitWith {};

fn_handleGetIn = {
	private ["_vehicle","_seat"];
	_vehicle = _this select 0;
	_seat = _this select 1;
	
	if(_seat == "driver")then{
		_vehicle setVariable ["GotIn",true];
		_vehicle allowDamage false;
		diag_log "[OX3] - Vehicle getin handled";
	};
};

fn_handleLocal = {
	private ["_vehicle","_local"];
	
	_vehicle = _this select 0;
	_local = _this select 1;
	_vehicle setVariable ["LocalChanged",true];
	_vehicle allowDamage false;
	diag_log "[OX3] - Vehicle local handled";
	
};

diag_log "[OX3] - Vehicle get in pilot protection";
while {true} do 
{
	
	{	
		if (!(_x getVariable ["added_EHProtect",false])) then {
			_x addEventHandler ["GetIn", {_this call fn_handleGetIn;}];
			_x addEventHandler ["Local", {_this call fn_handleLocal;}];
			_x setVariable ["added_EHProtect",true];
		 };
		
		if( (_x getVariable["GotIn",false])) then{
		 	sleep 3;
			_x allowDamage true;
			_x setVariable ["GotIn",false];
		};
		
		if( (_x getVariable["LocalChanged",false])) then{
		 	sleep 3;
			_x allowDamage true;
			_x setVariable ["LocalChanged",false];
		};
	}forEach vehicles;
	
	uiSleep 5;
};  