if(isServer) then {

	private ["_player_near","_map_marker","_node","_max_ai","_timeout_time","_currenttime","_starttime","_msglose","_msgwin","_msgstart","_objectives","_crate","_marker","_in_range","_objectivetarget","_position","_type","_complete","_timeout","_mission","_killpercent","_delete_mines","_cleanunits","_clearmission","_baseclean","_msg"];

	_mission	= (_this select 0) select 0;
	_crate		= (_this select 0) select 1;
	_type		= (_this select 1) select 0;
	_baseclean	= _this select 2;
	_msgstart	= _this select 3;
	_msgwin		= _this select 4;
	_msglose	= _this select 5;

	_position		= position _crate;
	_timeout 		= false;
	_player_near	= false;
	_complete		= false;
	_starttime 		= time;
	_start 			= false;
	_timeout_time	= ((wai_mission_timeout select 0) + random((wai_mission_timeout select 1) - (wai_mission_timeout select 0)));
	_max_ai			= (wai_mission_data select _mission) select 0;
	_killpercent 	= _max_ai - (_max_ai * (wai_kill_percent / 100));
	_mission_units	= [];

	if((_type == "patrol")) then {
		_start = true;
	};
	
	if(_type == "bomb") then {
		_start = true;
		_timeout_time = wai_timeout_bomb;
		
		// Debug 
		if(debug_mode) then {_timeout_time = 300;};
	};

	{
		if (_x getVariable ["mission", nil] == _mission) then {
			_mission_units set [count _mission_units, _x];
		};

	} count allUnits;
	if(debug_mode) then { diag_log("WAI: _mission_units " + str(_mission_units)); };
	
	/*
	RemoteMessage = [wai_announce,_msgstart];
	publicVariable "RemoteMessage";
	*/
	[["Activity sighted...",_msgstart,"",""],""] call FEARBroadcast;
	
	markerready = true;

	while {!_start && !_timeout} do {

		sleep 1;
		_currenttime = time;

		{
			if((isPlayer _x) && (_x distance _position <= 1500)) then {
				_start = true
			};

		} count playableUnits;

		if (_currenttime - _starttime >= _timeout_time) then {
			_timeout = true;
		};

	};

	{	
		_x enableAI "TARGET";
		_x enableAI "AUTOTARGET";
		_x enableAI "MOVE";
		_x enableAI "ANIM";
		_x enableAI "FSM";
		_x setRank  "Private";
	} count _mission_units;

	while {!_timeout && !_complete} do {

		sleep 1;
		_currenttime = time;
		{
			if((isPlayer _x) && (_x distance _position <= wai_timeout_distance) && (_type != "bomb") ) then {
				_player_near = true;
			};
			
		} count playableUnits;

		if (_currenttime - _starttime >= _timeout_time && !_player_near) then {
			_timeout = true;
		};
		
		call {

			if (_type == "crate") exitWith {

				if(wai_kill_percent == 0) then {

					{
						if((isPlayer _x) && (_x distance _position <= 30)) then {
							_complete = true;
						};
					} count playableUnits;

				} else {

					if(((wai_mission_data select _mission) select 0) <= _killpercent) then {
						{
							if((isPlayer _x) && (_x distance _position <= 30)) then {
								_complete = true;
							};
						} count playableUnits;
					};

				};

			};

			if (_type == "kill") exitWith {
				if(((wai_mission_data select _mission) select 0) == 0) then {
					_complete = true;
				};
			};

			if (_type == "patrol") exitWith {
				if(((wai_mission_data select _mission) select 0) == 0) then {
					_complete = true;
				};
			};
			
			if (_type == "assassinate") exitWith {
				_objectivetarget = (_this select 1) select 1;
				{
					_complete = true;
					if (alive _x) exitWith {_complete = false;};
				} count units _objectivetarget;
			};
			
			if (_type == "bomb") exitWith {
				{
					if((isPlayer _x) && (_x distance _position <= 2)) then {
						_complete = true;
					};
				} count playableUnits;
			};

			if (_type == "resource") exitWith {
				_node 		= (_this select 1) select 1;
				_resource 	= _node getVariable ["Resource", 0];
				if (_resource == 0) then {
					{
						if((isPlayer _x) && (_x distance _position <= 80)) then {
							_complete = true;
						} else {
							_timeout = true;
						};
					} count playableUnits;
				};
			};
		};
	};

	if (_complete) then {

		if (typeOf(_crate) in (crates_large + crates_medium + crates_small)) then {

			if(wai_crates_smoke && sunOrMoon == 1) then {
				_marker = "SmokeShellPurple" createVehicle getPosATL _crate;
				_marker setPosATL (getPosATL _crate);
				_marker attachTo [_crate,[0,0,0]];
			};

			if (wai_crates_flares && sunOrMoon != 1) then {
				_marker = "B_IR_Grenade" createVehicle getPosATL _crate;
				_marker setPosATL (getPosATL _crate);
				_marker attachTo [_crate, [0,0,0]];
			};

		};

		_delete_mines = ((wai_mission_data select _mission) select 2);

		if(count _delete_mines > 0) then {
		
			{
				if(typeName _x == "ARRAY") then {
					{
						deleteVehicle _x;
					} count _x;
				} else {
					deleteVehicle _x;	
				};
				
			} forEach _delete_mines;
			
		};
		
		// WINNING
		/*
		RemoteMessage = [wai_announce,_msgwin];
		publicVariable "RemoteMessage";
		*/
		[["Activity sighted...",_msgwin,"",""],""] call FEARBroadcast;
		
		if (wai_clean_mission) then {

			[_position,_baseclean] spawn {
				private ["_pos","_clean","_finish_time","_cleaned","_playernear","_currenttime"];
				_pos = _this select 0;
				_clean = _this select 1;
				_finish_time = time;
				_cleaned = false;
				while {!_cleaned} do {

					_playernear = false;

					{
						if ((isPlayer _x) && (_x distance _pos < 400)) exitWith { _playernear = true };
					} count playableUnits;	

					_currenttime = time;

					if ((_currenttime - _finish_time >= wai_clean_mission_time) && !_playernear) then {

						{
							if(typeName _x == "ARRAY") then {
							
								{
									if ((_x getVariable ["ObjectID", nil]) == nil) then {
										deleteVehicle _x;
										//if(debug_mode) then { diag_log("WAI: DELETE " + str(_x)); };

									};
								} count _x;
							
							} else {
								if ((_x getVariable ["ObjectID", nil]) == nil) then {
									deleteVehicle _x;
									//if(debug_mode) then { diag_log("WAI: DELETE " + str(_x)); };
								};
							};
							
						} forEach _clean;

						_cleaned = true;

					};
					
					sleep 1;
				};
			};
		};
	};
	
	if (_timeout) then {
		
		//BOMB STUFF 
		if(_type == "bomb") then {
			private["_bomb"];
			{
				// only send to players with in view distance
				if((isPlayer _x) && (_x distance _position <= 1600)) then {
					// Magic happens
					WAIclient = ["nuke",_position];
					publicVariable "WAIclient";
				};
			} count playableUnits;
			
			// Wait for countdown
			sleep 20;
			{
				_bomb = "Bo_GBU12_LGB_MI10" createVehicle (getpos _x);
				_bomb setVectorDirAndUp [[0,0,1],[0,-1,0]];
				_bomb setVelocity [0,0,-1000];
				_x setDamage 1;
			} forEach (_position nearObjects (wai_blacklist_range - 50));// Player base protection
		};
		
		// Delete AI
		{
		
			if (_x getVariable ["mission", nil] == _mission) then {
			
				if (alive _x) then {

					_cleanunits = _x getVariable ["missionclean",nil];
		
					if (!isNil "_cleanunits") then {
				
						call {
							if(_cleanunits == "ground") 	exitWith { ai_ground_units = (ai_ground_units -1); };
							if(_cleanunits == "air") 		exitWith { ai_air_units = (ai_air_units -1); };
							if(_cleanunits == "vehicle") 	exitWith { ai_vehicle_units = (ai_vehicle_units -1); };
							if(_cleanunits == "static") 	exitWith { ai_emplacement_units = (ai_emplacement_units -1); };
						};
					};
				};
				
				deleteVehicle _x;
				if(debug_mode) then { diag_log("WAI: DELETE " + str(_x)); };
			};

		} count allUnits + vehicles + allDead;
		
		// Delete scenery
		{
			if(typeName _x == "ARRAY") then {
			
				{
					deleteVehicle _x;
					//if(debug_mode) then { diag_log("WAI: DELETE " + str(_x)); };
				} count _x;
			
			} else {
			
				deleteVehicle _x;
				//if(debug_mode) then { diag_log("WAI: DELETE " + str(_x)); };
			};
			
		} forEach _baseclean + ((wai_mission_data select _mission) select 2) + [_crate];

		// Loosing
		/*
		RemoteMessage = [wai_announce,_msglose];
		publicVariable "RemoteMessage";
		*/
		[["Activity sighted...",_msglose,"",""],""] call FEARBroadcast;
	};
	
	_map_marker = (wai_mission_data select _mission) select 1;
	wai_mission_markers = wai_mission_markers - [(_map_marker + str(_mission))];
	wai_mission_data set [_mission, -1];
	_complete

};
