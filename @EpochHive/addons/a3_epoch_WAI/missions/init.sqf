if(isServer) then {

	private["_marker","_unitGroup","_b_missionTime","_h_missionTime","_h_startTime","_b_startTime","_result","_cnt","_currTime","_mission"];

	diag_log "WAI: Initialising missions";

	// Mission functions
	call 							compile preprocessFileLineNumbers "\x\addons\WAI\compile\position_functions.sqf";
	mission_init					= compile preprocessFileLineNumbers "\x\addons\WAI\compile\mission_init.sqf";
	patrol							= compile preprocessFileLineNumbers "\x\addons\WAI\compile\patrol.sqf";
	mission_winorfail				= compile preprocessFileLineNumbers "\x\addons\WAI\compile\mission_winorfail.sqf";
	minefield						= compile preprocessFileLineNumbers "\x\addons\WAI\compile\minefield.sqf";
	//custom_publish  				= compile preprocessFileLineNumbers "\x\addons\WAI\compile\custom_publish_vehicle.sqf";
	
	markerready 					= true;
	wai_mission_data				= [];
	wai_bandit_mission				= [];
	wai_special_mission				= [];
	b_missionsrunning				= 0;
	_b_startTime 					= floor(time);
	_delayTime						= floor(time);
	_b_missionTime					= nil;
	_mission						= "";
	_bresult 						= 0;

	// Set mission frequencies from config
	{
		for "_i" from 1 to (_x select 1) do {
			wai_bandit_mission set [count wai_bandit_mission, _x select 0];
		};
	} count wai_bandit_missions;

	// Start mission monitor
	while {true} do
	{
		_cnt 		= {alive _x} count playableUnits;
		_currTime 	= floor(time);

		if (isNil "_b_missionTime") then { _b_missionTime = ((wai_mission_timer select 0) + random((wai_mission_timer select 1) - (wai_mission_timer select 0))); };

		if((_currTime - _b_startTime >= _b_missionTime) && (b_missionsrunning < wai_bandit_limit)) then { _bresult = 1; };

		if(b_missionsrunning == wai_bandit_limit) then { _b_startTime = floor(time); };

		if((_cnt >= wai_players_online) && (diag_fps >= wai_server_fps)) then {

			if (_bresult == 1) then {
				waitUntil {_currTime = floor(time);(_currTime - _delayTime > 10 && markerready)};
				markerready 		= false;
				b_missionsrunning 	= b_missionsrunning + 1;
				_b_startTime 		= floor(time);
				_delayTime			= floor(time);
				_b_missionTime		= nil;
				_bresult 			= 0;
				wai_mission_markers set [(count wai_mission_markers), ("MainBandit" + str(count wai_mission_data))];
				wai_mission_data = wai_mission_data + [[0,"",[],[0,0,0]]];
				
				_mission 			= wai_bandit_mission call BIS_fnc_selectRandom;
				execVM format ["\x\addons\WAI\missions\bandit\%1.sqf",_mission];
			};

		};
		sleep 5;
	};
};