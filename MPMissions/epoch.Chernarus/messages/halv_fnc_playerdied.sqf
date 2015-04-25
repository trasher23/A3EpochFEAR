/*
	a3 epoch killfeed server function
	By Halv
*/
 
private "_weapon";
_player = _this select 0;
_killer = _this select 1;
 
_message = "";
_dyntxt = "";
_loc_message = "";
_hint = "";
 
_killerName = name _killer;
_victimName = name _player;
 
_distance = _player distance _killer;
 
_weapon = weaponState _killer;
if !(isNil "_weapon") then{
		if (_weapon select 0 == "Throw") then
		{
				_weapon = _weapon select 3;
		}
		else
		{
				_weapon = _weapon select 0;
		};
}else{
		_weapon = currentWeapon _killer;
};
 
if(_killer != _player && (vehicle _killer) != (vehicle _player))then{
		//if killer is not vehicle
		_txt = (gettext (configFile >> 'cfgWeapons' >> _weapon >> 'displayName'));
		_pic = (gettext (configFile >> 'cfgWeapons' >> _weapon >> 'picture'));
		_vehicleKillerType = typeOf(vehicle _killer);
 
		//if killer is a vehicle type, then we get vehicle picture
		{
				if(_vehicleKillerType isKindOf _x)exitWith{
						_pic = (gettext (configFile >> 'CfgVehicles' >> _vehicleKillerType >> 'picture'));
						//and if he was in a driver position of the vehicle, we get vehicle displayName aswell
						if(_killer == driver(vehicle _killer))then{
								_txt = (gettext (configFile >> 'CfgVehicles' >> _vehicleKillerType >> 'displayName'));
						};
				};
		}count ["LandVehicle","Air","Ship"];
 
		//if weapon is a horn classname, then the killer was also driver, so we get vehicle displayName instead of weapon displayName
		if(_weapon in ["Horn","MiniCarHorn","SportCarHorn","TruckHorn2","TruckHorn","BikeHorn","CarHorn","TruckHorn3"])then{
				_txt = (gettext (configFile >> 'CfgVehicles' >> _vehicleKillerType >> 'displayName'));
		};
		//if leader of killer group was a player, then we are almost certain killer was a player, so we create a message
		if(isPlayer leader(group _killer))then{
				_dyntxt = format["
				<t size='0.75'align='left'color='#5882FA'>%1</t>
				<t size='0.5'align='left'>  Killed  </t>
				<t size='0.75'align='left'color='#c70000'>%2</t><br/>
				<t size='0.45'align='left'> With: </t>
				<t size='0.5'align='left'color='#FFCC00'>%3</t>
				<t size='0.45'align='left'> - Distance: </t>
				<t size='0.5'align='left'color='#FFCC00'>%4m</t><br/>
				<img size='2.5'align='left' image='%5'/>
				",
				_killerName,
				_victimName,
				_txt,
				_distance,
				_pic
				];
 
				_hint = parseText format ["
						<t size='1.25'align='center'color='#5882FA'>%1</t><br/>
						<t size='1'align='Center'>Killed:</t><br/>
						<t size='1.25'align='Center'color='#c70000'>%2</t><br/>
						<t size='1'align='Center'>With Weapon:</t><br/>
						<img size='5' image='%3'/><br/>
						<t size='1.25'align='Center'>[</t><t size='1.25'align='Center'color='#FFCC00'>%4</t><t size='1.25'align='Center'>]</t><br/>
						<t size='1'align='Center'>Distance:</t><br/>
						<t size='1.25'align='Center'color='#FFCC00'>%5m</t><br/>",
						_killerName,
						_victimName,
						_pic,
						_txt,
						_distance
				];
 
				_message = format["%1 was killed by %2 with %3 from %4m",_victimName, _killerName, _txt, _distance];
				_loc_message = format["[KillFeed]: PKILL: %1 was killed by %2 with %3 from %4m", _victimName, _killerName, _weapon, _distance];
		}else{
				if(HALV_KillFeed_AI)then{
						//killer is not a player
						_killerType = typeOf _killer;
						if(gettext (configFile >> 'CfgVehicles' >> _killerType >> 'displayName') != "")then{
								_killerName = gettext (configFile >> 'CfgVehicles' >> _killerType >> 'displayName');
						};
						_message = format["%1 was killed by a %2 with a %3 from %4m",_victimName,_killerName,_txt,_distance];
						_hint = _message;
						_dyntxt = format["<t size='0.70'align='left'>%1</t>",_message];
						_loc_message = format["[KillFeed]: PKILL: %1 | %2",_message,_killerType];
 
				};
		};
		if(_loc_message == "")then{_loc_message = format["[KillFeed]: PKILL: %1 was killed by %2 with %3",_player,_killer,_weapon];};
}else{
		//if player is killer
		_message = format["%1 Killed himself ...",name _player];
		_hint = _message;
		_dyntxt = format["<t size='0.70'align='left'>%1</t>",_message];
		_loc_message = format["[KillFeed]: PKILL: %1 killed himself", _victimName];
};
 
diag_log _loc_message;
 
{
		if(_x select 0) then {
				if(_message != "")then{
						HalvPV_player_message = (_x select 1);
						publicVariable "HalvPV_player_message";
				};
		};
}forEach[
		[HALV_KillFeedhint,["hint", _hint]],[HALV_KillFeedhintSilent,["hintSilent", _hint]],[HALV_KillFeedsystemChat,["systemChat", _message]],
		[HALV_KillFeeddynamictext,["dynamictext", _dyntxt]],[HALV_KillFeedsideChat,["sideChat", _message, _killer]],
		[HALV_KillFeedglobalChat,["globalChat", _message, _killer]],[HALV_KillFeedcutText,["cutText", [_message, "PLAIN DOWN"]]],
		[HALV_KillFeedtitleText,["titleText", [_message, "PLAIN DOWN"]]]
];