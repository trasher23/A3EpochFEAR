private ["_A","_B","_C","_D","_E","_epochConfig","_persistenceConfig"];

_epochConfig = configFile >> "CfgEpochServer";
_persistenceConfig = configFile >> "CfgPersistence";

_A = getText (_epochConfig >> "PersistenceTablePrefix");
_B = getNumber (_epochConfig >> "PersistenceHolderExpires");
_C = getNumber (_epochConfig >> "PersistenceHolderLimit");
_D = getNumber (_epochConfig >> "PersistenceMines");
_E = getNumber (_epochConfig >> "PersistenceMinesLimit");

if (isNil "_A") then {	
	missionNamespace setVariable["N8M4RE_PersistenceTablePrefix",getText(_persistenceConfig >> "PersistenceTablePrefix")];
} else {
	missionNamespace setVariable["N8M4RE_PersistenceTablePrefix",_A];
};

if (isNil "_B") then {
	missionNamespace setVariable["N8M4RE_PersistenceHolderExpires",getNumber (_persistenceConfig >> "PersistenceHolderExpires")];
} else {
	missionNamespace setVariable["N8M4RE_PersistenceHolderExpires",_B];
};

if (isNil "_C") then {
	missionNamespace setVariable["N8M4RE_PersistenceHolderLimit",getNumber (_persistenceConfig >> "PersistenceHolderLimit")];
} else {
	missionNamespace setVariable["N8M4RE_PersistenceHolderLimit",_C];
};

if (isNil "_D") then {
	missionNamespace setVariable["N8M4RE_PersistenceMines",getNumber (_persistenceConfig >> "PersistenceMines") == 1 ];
} else {
	missionNamespace setVariable["N8M4RE_PersistenceMines",_D == 1];
};

if (isNil "_E") then {
	missionNamespace setVariable["N8M4RE_PersistenceMinesLimit",getNumber (_persistenceConfig >> "PersistenceMinesLimit") == 1 ];
} else {
	missionNamespace setVariable["N8M4RE_PersistenceMinesLimit",_D == 1];
};