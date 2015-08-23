/*
    Author: IT07

    Description:
    Handles the start and timeout of missions

    Params:
    none

    Returns:
    nothing
*/

_settings = [["VEMFconfig"],["minServerFPS","minPlayers","maxGlobalMissions","minMissionTime","maxMissionTime","missionList"]] call VEMF_fnc_getSetting;
_minFPS = _settings select 0;
_minPlayers = _settings select 1;
_maxGlobalMissions = _settings select 2;
_minTime = _settings select 3;
_maxTime = _settings select 4;
_missionList = _settings select 5;

while {true} do
{
    if (_minPlayers call VEMF_fnc_playerCount AND diag_fps > _minFPS) exitWith
    {
        ["Launcher", 1, format["Minimal player count of %1 reached! Starting timer...", _minPlayers]] call VEMF_fnc_log
    };
    uiSleep 3;
};

VEMF_missionCount = 0;
while {true} do
{
    // Wait random amount
    uiSleep ((_minTime*60)+ floor random ((_maxTime*60)-(_minTime*60)));

    // Pick A Mission if enough players online
    if (1 call VEMF_fnc_playerCount) then
    {
        if (VEMF_missionCount < _maxGlobalMissions AND not(count playableUnits isEqualTo 0)) then
        {
            VEMF_missionCount = VEMF_missionCount +1;
            _missVar = _missionList call BIS_fnc_selectRandom;
            [] execVM format["\VEMF\Missions\%1.sqf", _missVar];
            _lastMission = time;
        };
    };
};
