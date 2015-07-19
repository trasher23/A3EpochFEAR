/*
	Author: Vampire

	Description:
	fn_mainFrame - logs the start of VEMF and runs a loop to launch new missions
*/

[] spawn
{
	private ["_timeDiff","_missVar","_players"];
	_players = 0;
	_minPlayers = (["minPlayers"] call VEMF_fnc_getSetting) select 0;
	_maxMissions = (["maxMissions"] call VEMF_fnc_getSetting) select 0;
	_minTime = (["minMissionTime"] call VEMF_fnc_getSetting) select 0;
	_maxTime = (["maxMissionTime"] call VEMF_fnc_getSetting) select 0;
	_missionList = (["missionList"] call VEMF_fnc_getSetting) select 0;

	while {true} do
	{
		{
			if (isPlayer _x) then
			{
				_players = _players + 1;
			};
			uiSleep 0.05;
		} forEach playableUnits;
		if (_players isEqualTo _minPlayers OR _players > _minPlayers) exitWith
		{
			diag_log format["[VEMF] missionTimer can now run. VEMF_minPlayers amount reached! player count: %1", _players];
		};
		uiSleep 5;
	};

	// Find the Min and Max time
	_timeDiff = ((_maxTime*60) - (_minTime*60));
	VEMF_missionCount = 0;
	while {true} do
	{
		// Wait random amount
		uiSleep ((floor(random(_timeDiff)))+(_minTime*60));


		// Pick A Mission if enough players online
		if ((count playableUnits) isEqualTo _minPlayers OR (count playableUnits) > _minPlayers) then
		{
			if (VEMF_missionCount < _maxMissions AND not(count playableUnits isEqualTo 0)) then
			{
				VEMF_missionCount = VEMF_missionCount +1;
				_missVar = _missionList call BIS_fnc_selectRandom;
				[] execVM format["\VEMF\Missions\%1.sqf", _missVar];
			};
		};
	};
};
