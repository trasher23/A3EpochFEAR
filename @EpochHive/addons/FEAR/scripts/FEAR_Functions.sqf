/*
	Consolidate all messages to player
	Uses VEMFChatMsg to broadcast (in mission PBO)
*/

// Broadcasts message to players who have a radio
FEARBroadcast = {
	private ["_msg","_mode","_sent","_allPlayers","_player"];
	
	_msg = _this select 0;
	_mode = _this select 1;
	
	// Get list of player-controlled units
	_allPlayers = [];
	{
		if (isPlayer _x) then {
			_allPlayers pushBack _x;
		};
	} forEach playableUnits;

	// Players radio check
	{
		_player = _x;
		{			
			if (configName(inheritsFrom(configFile >> "CfgWeapons" >> _x)) == "ItemRadio") exitWith {
				// If player has radio, send message
				VEMFChatMsg = [_msg, _mode];
				(owner (vehicle _player)) publicVariableClient "VEMFChatMsg";
			};
		} forEach assignedItems _player;
	} forEach _allPlayers;
	
	// Message was still sent, regardless of whether player has radio to receive it
	_sent = true;
	_sent
};