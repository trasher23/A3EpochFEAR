// Broadcasts message to players who have a radio
private["_msg","_mode","_sent","_allPlayers","_player"];
_msg = _this select 0;
_mode = _this select 1;
// Get list of player-controlled units
_allPlayers = call FEARGetPlayers;
// Players radio check
{
	_player = _x;
	{			
		if (configName(inheritsFrom(configFile >> "CfgWeapons" >> _x)) == "ItemRadio") exitWith {
			// If player has radio, send message
			VEMFrClientMsg = [_msg,_mode];
			(owner (vehicle _player)) publicVariableClient "VEMFrClientMsg";
		};
	}forEach assignedItems _player;
}forEach _allPlayers;
// Message was still sent, regardless of whether player has radio to receive it
_sent = true;
_sent