if (hasInterface) then
{
	uiNamespace setVariable ["VEMFrClientMsgQeue", []];
	uiNamespace setVariable ["RscDisplayVEMFrClient", displayNull];
	// custom addPublicVariableEventHandler. Those bloody BE filters.....
	[] spawn
	{
		while {true} do
		{
			waitUntil { uiSleep 0.05; not isNil"VEMFrClientMsg" };
			if (typeName VEMFrClientMsg isEqualTo "ARRAY") then
			{
				_data = +[VEMFrClientMsg];
				VEMFrClientMsg = nil;
				_data = _data select 0;
				[_data] spawn
				{
					_data = _this select 0;
					_mode = [_data, 1, "corrupted", [""]] call BIS_fnc_param;
					if not(_mode isEqualTo "corrupted") then
					{
						_msg = [_data, 0, "fail", [""]] call BIS_fnc_param;
						if not (_msg isEqualTo "fail") then
						{
							switch _mode do
							{
								case "sys":
								{
									systemChat _msg;
								};
								default
								{
									playSound [format ["UAV_0%1",(floor (random 5) + 1)],false]; // Used from A3AI client, random radio msg
									[_msg] spawn VEMFr_fnc_clientMessage;
								};
							};
						};
					};
				};
			};
		};
	};
};
