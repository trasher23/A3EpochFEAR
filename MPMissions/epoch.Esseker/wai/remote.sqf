if(!isDedicated) then {
	fnc_wai_client = {
		private ["_type","_position"];
		
		_type 		= _this select 0;
		
		// Can be used as option variable
		if (count _this > 1) then {
			_position = _this select 1;
		};
		
		switch (_type) do {
			// NUKE
			case "nuke":
			{
				// Count down 10 sec.
				0 = [_position] spawn {
					private["_position","_number"];
					_number 	= 10;
					_position 	= _this select 0;
					while {_number > 0} do {
						_number = _number - 1;
						0 = ["<t size='0.8' shadow='1' color='#FF0000'>Nuclear detonation in " + str(_number) + "</t>", 0, 1, 5, 2, 0, 1] spawn bis_fnc_dynamictext;
						sleep 1;
					};
					playsound "Alarm_BLUFOR";
				};
				
				uisleep 10;
				
				[_position] spawn FEAR_fnc_nukeImpact;
			};
			
			case "vehiclehit": 
			{
				// Blow front wheels
				// _position is used as _player
				diag_log("Blow front wheels");
				(vehicle _position) sethit ["wheel_1_1_steering", 1];
				(vehicle _position) sethit ["wheel_2_1_steering", 1];

			};
		};
	
	};
	
	"WAIclient" addPublicVariableEventHandler { (_this select 1) call fnc_wai_client; };
};
remote_ready = true;
