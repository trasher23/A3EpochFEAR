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
if (_minFPS > 0) then
{
    _minPlayers = "minPlayers" call VEMFr_fnc_getSetting;
    if (_minPlayers > 0) then
    {
        _maxGlobalMissions = "maxGlobalMissions" call VEMFr_fnc_getSetting;
        if (_maxGlobalMissions > 0) then
        {
            _minNew = "minNew" call VEMFr_fnc_getSetting;
            if (_minNew > 0) then
            {
                _maxNew = "maxNew" call VEMFr_fnc_getSetting;
                if (_maxNew > 1) then
                {
                    _missionList = "missionList" call VEMFr_fnc_getSetting;
                    if (count _missionList > 0) then
                    {
                        waitUntil { uiSleep 2; ([_minPlayers] call VEMFr_fnc_playerCount); diag_fps > _minFPS };
                        ["Launcher", 1, format["Minimal player count of %1 reached! Starting timer...", _minPlayers]] call VEMFr_fnc_log;

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
                                    VEMFr_missionCount = VEMFr_missionCount +1;
                                    _missVar = _missionList call BIS_fnc_selectRandom;
                                    [] execVM format["Epoch_VEMF_Reloaded\missions\%1.sqf", _missVar];
                                    _lastMission = time;
                                };
                                if not _ignoreLimit then
                                {
                                    if (VEMFr_missionCount < _maxGlobalMissions) then
                                    {
                                        VEMFr_missionCount = VEMFr_missionCount +1;
                                        _missVar = _missionList call BIS_fnc_selectRandom;
                                        [] execVM format["Epoch_VEMF_Reloaded\missions\%1.sqf", _missVar];
                                        _lastMission = time;
                                    };
                                };
                            };
                        };
                    };
                };
            };
        };
    };
};
