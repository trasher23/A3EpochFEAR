/*
	Lifted from Vampires' original VEMF code
	Idea was to consolidate all messages to player using same method, for consistency
	Still uses VEMFChatMsg to broadcast in IT07's revised code (in mission PBO)
*/

// Alerts Players With a Random Radio Type
FEARBroadcast = {
	private ["_msg","_eRads","_allUnits","_curRad","_send"];
	
	_msg = _this select 0;
	
	_eRads = ["EpochRadio0","EpochRadio1","EpochRadio2","EpochRadio3","EpochRadio4","EpochRadio5","EpochRadio6","EpochRadio7","EpochRadio8","EpochRadio9"];
	_eRads = _eRads call BIS_fnc_arrayShuffle;
	
	// Broadcast to Each Player
	_allUnits = allUnits;
	
	// Remove Non-Players
	{ if !(isPlayer _x) then {_allUnits = _allUnits - [_x];}; } forEach _allUnits;
	
	_curRad = 0;
	_send = false;
	// Find a Radio to Broadcast To
	while {true} do {
		{
			if ((_eRads select _curRad) in (assignedItems _x)) exitWith {
				_send = true;
			};
			if (_forEachIndex == ((count _allUnits)-1)) then {
				_curRad = _curRad + 1;
			};
		} forEach _allUnits;
		
		if (_send) exitWith {};
		if (_curRad > ((count _eRads)-1)) exitWith
		{
			/* No Radios */
		};
	};
	
	if (_send) then {
		{
			if ((_eRads select _curRad) in (assignedItems _x)) then {
				VEMFChatMsg = _msg;
				(owner (vehicle _x)) publicVariableClient "VEMFChatMsg";
			};
		} forEach _allUnits;
	};
};