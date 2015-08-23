/*
	Author: VAMPIRE, rebooted by IT07

	Description:
	fn_waitForPlayers - waits for player to be nearby given pos
*/

private ["_pos","_rad","_time","_marker","_settings","_timeOutTime","_playerNear"];

_pos = _this select 0;
_rad = _this select 1;
_time = diag_tickTime;
_marker = _this select 2;

// Define _settings
_timeOutTime = "timeOutTime" call VEMF_fnc_getSetting;

while {true} do
{
	// Check if there are vehicles or players close
	_playerNear = [_pos, _rad] call VEMF_fnc_checkPlayerPresence;
	if _playerNear exitWith {};
	if (_timeOutTime > 4 && diag_tickTime - _time > _timeOutTime * 60) exitWith
	{
		_playerNear = "TIMEOUT";
	};
	uiSleep 1;
};
_playerNear // Return BOOLEAN
