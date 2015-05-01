waitUntil {!isNil"EPOCH_fn_InstanceID" && !isNil"EPOCH_server_hiveGET"};
diag_log "[N8M4RE PERSISTENCE]: LOADING";
call N8M4RE_Persistence_PublicEH;
[] spawn N8M4RE_Persistence_Load;
