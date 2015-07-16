diag_log "[N8M4RE PERSISTENCE]: Init Variables";
private ["_epochConfigFile","_defaultConfigFile","_vars"];
N8M4RE_PersistenceHolderIndex=[];
N8M4RE_PersistenceMinesIndex=[];


	if(N8M4RE_DevelMode) then {
		_epochConfigFile = missionConfigFile >> "CfgEpochServer";
		_defaultConfigFile = missionConfigFile >> "CfgPersistence";
	} else {
		_epochConfigFile = configFile >> "CfgEpochServer";
		_defaultConfigFile = configFile >> "CfgPersistence";
	};		

_vars = [ // Name , Type
	["PersistenceTablePrefix","STRING"],
	["PersistenceHolder","BOOL"],
	["PersistenceHolderCanExpire","BOOL"],
	["PersistenceHolderExpires","STRING"],
	["PersistenceHolderLimit","SCALAR"],
	["PersistenceMines","BOOL"],
	["PersistenceMinesCanExpire","BOOL"],
	["PersistenceMinesExpires","STRING"],
	["PersistenceMinesLimit","SCALAR"],
	["PersistenceDayTime","BOOL"]
];

{
	_var = _x select 0;
	_config = _epochConfigFile >> _var;
	if (isNil "_config") then {	_config =  _defaultConfigFile >> _var; };
	_value = switch(_x select 1) do {
		case "SCALAR":{getNumber _config};
		case "STRING":{ if ((typeName _config) == "SCALAR") then {getNumber _config} else { getText _config;};};
		case "BOOL":{(getNumber _config)==1};
		case "ARRAY":{getArray _config};
		default{nil};
	};
	missionNamespace setVariable[format["N8M4RE_%1",_var] ,_value];
} forEach _vars;