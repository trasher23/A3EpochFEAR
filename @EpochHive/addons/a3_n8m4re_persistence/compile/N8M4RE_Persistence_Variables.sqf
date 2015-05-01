_epochConfig = configFile >> "CfgEpochServer";
_persistenceConfig = configFile >> "CfgPersistence";
_A = getText(_epochConfig >> "PersistenceTablePrefix");
if (isNil "_A") then {	
	missionNamespace setVariable["N8M4RE_PersistenceTablePrefix",getText(_persistenceConfig >> "PersistenceTablePrefix")];
	diag_log format["Persistence epochConfig %1", false];
} else {
	missionNamespace setVariable["N8M4RE_PersistenceTablePrefix",_A];
};
_B = getNumber(_epochConfig >> "PersistenceExpires");
if (isNil "_B") then {
	missionNamespace setVariable["N8M4RE_PersistenceExpires",getNumber(_persistenceConfig >> "PersistenceExpires")];
} else {
	missionNamespace setVariable["N8M4RE_PersistenceExpires",_B];
};
_C = getNumber(_epochConfig >> "PersistenceLimit");
if (isNil "_C") then {
	missionNamespace setVariable["N8M4RE_PersistenceLimit",getNumber(_persistenceConfig >> "PersistenceLimit")];
} else {
	missionNamespace setVariable["N8M4RE_PersistenceLimit",_C];
};
missionNamespace setVariable["N8M4RE_PersistenceIndex",0];
