/*
	Author: VAMPIRE, rebooted by IT07

	Description:
	fn_waitForMissionDone - waits for mission to be done

	Params:
	_this select 0: POSITION - center of area to be waiting for
	_this select 1: ARRAY - array of units to check for
	_this select 2: SCALAR - radius around center to check for players
*/

private ["_pos","_unitArr","_unitCount","_killed","_killToComplete","_rad","_playerNear","_complete"];
_pos = _this select 0;
_unitArr = _this select 1;
_unitCount = count _unitArr;
_killed = [];
_killToComplete = round(("killPercentage" call VEMF_fnc_getSetting)/100*_unitCount);
_rad = _this select 2;

while {true} do
{
	// First check for a player
	_playerNear = [_pos, _rad] call VEMF_fnc_checkPlayerPresence;

	if (_playerNear) then
	{
		{
			if not(alive _x) then
			{
				_killed pushBack _x;
			};
	 	} forEach _unitArr;
		{ // Delete the not(alive) units
			_index = _unitArr find _x;
			if not(_index isEqualTo -1) then
			{
				_unitArr deleteAt _index;
			};
		} forEach _killed;
	};
	if (((count _killed) isEqualTo _killToComplete) OR ((count _killed) > _killToComplete)) exitWith
	{
		_complete = true;
	};
	uiSleep 5;
};

["fn_waitForMissionDone", 1, "mission complete!"] call VEMF_fnc_log;
_complete
