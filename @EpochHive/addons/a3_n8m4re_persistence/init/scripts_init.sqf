private ["_load0","_load1"];
waitUntil {!isNil"EPOCH_fn_InstanceID" && !isNil"EPOCH_server_hiveGET"};
diag_log "[N8M4RE PERSISTENCE]: LOADING";
call N8M4RE_Persistence_PublicEH;
_load0 = [] spawn N8M4RE_Persistence_Holder_Load;
waitUntil{scriptDone _load0};
//_load1 = [] spawn N8M4RE_Persistence_Mines_Load;
// waitUntil{scriptDone _load1};