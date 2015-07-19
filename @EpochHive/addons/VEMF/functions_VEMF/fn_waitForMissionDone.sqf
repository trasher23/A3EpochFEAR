/*
	Author: VAMPIRE, rebooted by IT07

	Description:
	fn_waitForMissionDone - waits for mission to be done
*/
private ["_pos","_grpArr","_grpCount","_unitArr","_unitCount","_complete","_playerInArea","_killed","_rad"];
_pos = _this select 0;
_grpArr = _this select 1;
_grpCount = count _grpArr;
_unitArr = _this select 2;
_unitCount = count _unitArr;
_killed = 0;
_killToComplete = round(((["killPercentage"] call VEMF_fnc_getSetting) select 0)/100*_unitCount);
_rad = _this select 3;

while {true} do
{
	// First check for a player
	_playerNear = [_pos, _rad] call VEMF_fnc_findPlayers;

	if (_playerNear) then
	{
		{
			if not(alive _x) then
			{
				_killed = _killed + 1;
				_unitArr deleteAt _foreachindex;
			};
	 	} forEach _unitArr;
	};
	if ((_killed isEqualTo _killToComplete) OR (_killed > _killToComplete)) exitWith
	{
		_complete = true;
	};
	uiSleep 5;
};

diag_log "[VEMF] fn_waitForMissionDone: mission complete!";
_complete
