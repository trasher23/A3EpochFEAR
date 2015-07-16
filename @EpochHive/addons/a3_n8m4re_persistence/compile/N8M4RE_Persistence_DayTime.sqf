private ["_dateRes","_format","_dateArr","_dateArrCount","_epochConfig","_staticDateTime"];
if (N8M4RE_PersistenceDayTime) then {

	_epochConfig = configFile >> "CfgEpochServer";
	_staticDateTime = [_epochConfig,"StaticDateTime",[]] call EPOCH_fnc_returnConfigEntry;
		
	if(_staticDateTime isEqualto[])exitWith{diag_log "[N8M4RE PERSISTENCE]: SERVER TIME NOT STATIC - SKIPPING DAYTIME FUNCTION!";};

		_format = [0,0,0,0,0];
		_format = count _format;
		_dateRes = [format["%1_%2",N8M4RE_PersistenceTablePrefix,"DAYTIME"], format["%1",(call EPOCH_fn_InstanceID)]] call EPOCH_server_hiveGET;
		if ((_dateRes select 0) == 1 && typeName(_dateRes select 1) == "ARRAY") then {
			_dateArr = _dateRes select 1;
			_dateArrCount = count _dateArr;
			if (_dateArrCount == _format) then {			
					setDate _dateArr;	
					while {true} do {if (date isEqualTo _staticDateTime)exitWith{};};
					setDate _dateArr;
					while {true} do {if (date isEqualTo _staticDateTime)exitWith{};};
					diag_log format ["[N8M4RE PERSISTENCE]: SET DAYTIME TO: %1",_dateArr];
					setDate _dateArr;
				};
		};
		
		while {true} do {
			[format["%1_%2",N8M4RE_PersistenceTablePrefix,"DAYTIME"], format["%1",(call EPOCH_fn_InstanceID)], date] call EPOCH_server_hiveSET;
			uiSleep 600;
		};
};
true
