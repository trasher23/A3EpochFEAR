/*
	fn_lightningStrike.sqf
*/

if (hasInterface) then
{
	[] spawn {
		private["_pos","_target","_center","_group","_logic","randomInterval"];
		
		while {true} do {
			// Get random position around player
			_pos = [player,[10,300],random 360] call SHK_pos;
			_target = "Land_HelipadEmpty_F" createVehicle _pos;
			
			_center = createCenter sideLogic;
			_group = createGroup _center;
			
			_logic = _group createUnit ["LOGIC",[0,0,0], [], 0, ""];
			_logic setPosASL (getPosASL _target);
			
			[_logic, nil, true] call BIS_fnc_moduleLightning;

			randomInterval = [0.5, 1, 5, 60, 300, 900] call BIS_fnc_selectRandom;
			sleep randomInterval;
		};
	};
};