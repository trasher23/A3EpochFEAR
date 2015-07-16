private ["_l1","_l2","_l3"];
waitUntil {!isNil"EPOCH_fn_InstanceID" && !isNil"EPOCH_server_hiveGET"};

call N8M4RE_Persistence_Variables;
call N8M4RE_Persistence_PublicEH;

diag_log "[N8M4RE PERSISTENCE]: LOADING";
_l1 = [] spawn N8M4RE_Persistence_DayTime;
// waitUntil{scriptDone _l1};
_l2 = [] spawn N8M4RE_Persistence_Holder_Load;
// waitUntil{scriptDone _l2};
// _l3 = [] spawn N8M4RE_Persistence_Mines_Load;
// waitUntil{scriptDone _l3};