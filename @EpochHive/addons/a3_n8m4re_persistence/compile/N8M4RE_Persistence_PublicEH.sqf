"N8M4RE_PERSISTENCE_PUT" addPublicVariableEventHandler {
	// diag_log format["N8M4RE_PERSISTENCE_PUT: %1",(_this select 1)];
	(_this select 1) call N8M4RE_Persistence_Holder_PutTake;
};
"N8M4RE_PERSISTENCE_TAKE" addPublicVariableEventHandler {
	// diag_log format["N8M4RE_PERSISTENCE_TAKE: %1",(_this select 1)];
	(_this select 1) call N8M4RE_Persistence_Holder_PutTake; 
};