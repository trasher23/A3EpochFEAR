/*
	HALV_takegive_crypto_init.sqf
	by Halv
	
	Copyright (C) 2015  Halvhjearne > README.md
*/

if(isServer)then{
	diag_log "[HALV_takegive] Server: loading 'HALV_takegive_crypto.sqf'";
	HALV_server_takegive_crypto = compileFinal preprocessFileLineNumbers "custom\HALV_takegive_crypto.sqf";
	diag_log "[HALV_takegive] Server: loading 'HALV_takegive' PVEvent";
	"HALV_takegive" addPublicVariableEventHandler {(_this select 1) call HALV_server_takegive_crypto};
};

if(hasInterface)then{
	isHalvTradeEnabled = true;
};