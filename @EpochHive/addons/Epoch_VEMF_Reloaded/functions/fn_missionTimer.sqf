/*
    Author: IT07

    Description:
    Handles the start and timeout of missions

    Params:
    none

    Returns:
    nothing
*/

_minFPS = "minServerFPS" call VEMFr_fnc_getSetting;
if (_minFPS > -1) then
{
    _minPlayers = "minPlayers" call VEMFr_fnc_getSetting;
    if (_minPlayers > -1) then
    {
        _maxGlobalMissions = "maxGlobalMissions" call VEMFr_fnc_getSetting;
        if (_maxGlobalMissions > -2) then
        {
            _minNew = "minNew" call VEMFr_fnc_getSetting;
            if (_minNew > -1) then
            {
                _maxNew = "maxNew" call VEMFr_fnc_getSetting;
                if (_maxNew > 0) then
                {
                    _missionList = "missionList" call VEMFr_fnc_getSetting;
                    if (count _missionList > 0) then
                    {
                        waitUntil { uiSleep 5; (if (([_minPlayers] call VEMFr_fnc_playerCount) AND (diag_fps > _minFPS)) then { true } else { false }) };
                        ["missionTimer", 1, format["Minimal player count of %1 reached! Starting timer...", _minPlayers]] call VEMFr_fnc_log;

                        VEMFr_missionCount = 0;
                        private ["_ignoreLimit"];
                        _ignoreLimit = false;
                        if (_maxGlobalMissions isEqualTo -1) then
                        {
                            _ignoreLimit = true;
                        };
                        while {true} do
                        {
                            // Wait random amount
                            uiSleep ((_minNew*60)+ floor random ((_maxNew*60)-(_minNew*60)));

                            // Pick A Mission if enough players online
                            if ([_minPlayers] call VEMFr_fnc_playerCount) then
                            {
                                if _ignoreLimit then
                                {
                                    _missVar = _missionList call VEMFr_fnc_random;
                                    [] execVM format["Epoch_VEMF_Reloaded\missions\%1.sqf", _missVar];
                                    _lastMission = serverTime;
                                };
                                if not _ignoreLimit then
                                {
                                    if (VEMFr_missionCount <= _maxGlobalMissions) then
                                    {
                                        _missVar = _missionList call VEMFr_fnc_random;
                                        [] execVM format["Epoch_VEMF_Reloaded\missions\%1.sqf", _missVar];
                                        VEMFr_missionCount = VEMFr_missionCount +1;
                                        _lastMission = serverTime;
                                    };
                                };
                            };
                        };
                    };
                };
            };
        };
        if (_maxGlobalMissions < -1) then
        {
            ["missionTimer", 0, format["Invalid maximum global missions number! it is: %1", _maxGlobalMissions]] call VEMFr_fnc_log;
        };
    };
    if (_minPlayers < 0) then
    {
        ["missionTimer", 0, format["Invalid minimum player setting of %1", _minPlayers]] call VEMFr_fnc_log;
    };
};
if (_minFPS < 0) then
{
    ["missionTimer", 0, format["Invalid minimum server FPS setting of %1", _minFPS]] call VEMFr_fnc_log;
};
