private ["_dateRes","_format","_dateArr","_dateArrCount","_epochConfig","_staticDateTime"];
if (N8M4RE_PersistenceDayTime) then {

/*
 [] spawn {while {true} do {diag_log format["SERVERTIME: %1 ", date];uiSleep 0.1;};};
*/

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
				
				_dateChange = 0;
				_loops = 999;
				for "_x" from 1 to _loops do {
						if (_x==_loops || _dateChange==3) exitWith {diag_log format ["[N8M4RE PERSISTENCE]: SET DAYTIME TO: %1 ",_dateArr];};
						_a = date;
						_a = [(_a select 0),(_a select 1),(_a select 2),(_a select 3)];
						_c = [(_dateArr select 0),(_dateArr select 1),(_dateArr select 2),(_dateArr select 3)];
						
						if !(_a isEqualTo _c ) then {
							_dateChange = _dateChange + 1;
							setDate _dateArr;
							// diag_log format ["[N8M4RE PERSISTENCE]: DAYTIME LOOP: %1",_x];	
						};
						uiSleep 0.5;
					};
				};
		};
		
		while {true} do {
			[format["%1_%2",N8M4RE_PersistenceTablePrefix,"DAYTIME"], format["%1",(call EPOCH_fn_InstanceID)], date] call EPOCH_server_hiveSET;
			uiSleep 600;
			// uiSleep 10;
		};
};
true
