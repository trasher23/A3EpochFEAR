if (!isNil("SDROPActive")) exitWith {};
SDROPActive = true;
publicVariable "SDROPActive";
waitUntil{!isNil "EPOCH_server_vehicleInit" && !isNil "EPOCH_server_setVToken"};
if (SDROP_Debug)then{diag_log text format ["[SDROP]: Starting Supply Drop Mission Framework."];};
call SDROP_Functions;
uiSleep SDROP_MissionTimer;
[] spawn SDROP_SupplyDrop;