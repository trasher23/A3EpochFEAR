private ["_zombie", "_grp", "_sleepTime", "_lockedTarget", "_playersInRange", "_closeHumans", "_hasContact"];
_zombie = _this select 0;
_zombie disableAI "FSM";
_zombie disableAI "AUTOTARGET";
_zombie disableAI "TARGET";
_zombie setBehaviour "CARELESS";
_zombie enableFatigue false;
_zombie setVariable ["BIS_noCoreConversations", true];
_zombie setVariable ["BIS_enableRandomization", false];
_zombie setVariable ["LASTLOGOUT_EPOCH",1000000000000];
_zombie setVariable ["LAST_CHECK",1000000000000];
_rNumber = random 100;
_zombie setVariable ["GEM",_rNumber,true];
_zombie setObjectTexture [0,"zskin.jpg"];
_grp = group _zombie;
_grp setCombatMode "CARELESS";
_grp setSpeedMode "FULL";
diag_log format["Spawned Zombie: %1",_zombie];
playZSoundHurt = [_this select 0, "hurt"];
_zombie addEventHandler ["hit",{(owner (_this select 1)) publicVariableClient "playZSoundHurt"}];

[_zombie] spawn {
	_zombie = _this select 0;
	while{alive _zombie} do {
		_nearPlayers = _zombie nearEntities [["man"],100];
		{
			playZSound = [_zombie, "idle"]; 
			(owner _x) publicVariableClient "playZSound";
		}forEach _nearPlayers;
		sleep 8;
	};
};


_sleepTime = 7;
//When the target is the zombie itself, it is idle
_lockedTarget = _zombie;

while {alive _zombie} do {
	if (_lockedTarget == _zombie) then {
		//Idle mode
		_playersInRange = false;
		_closeHumans = _zombie nearEntities [["man"],200];
		{
			if ((side _zombie) getFriend (side _x) < 0.5) then {
				_playersInRange = true;
				_hasContact = [_zombie, _x] call fncContact;
				if (_hasContact) then {
					_lockedTarget = _x;
				};
			};
		} foreach _closeHumans;

		//_sleepTime will be overwritten later again in case player was spotted
		//Lower sleep time if a player is within 200m, longer sleep time if not to save processing power
		//A player will take longer than 15 seconds to travel 100m on foot, and zombies see players from 100m max.
		//Values can be adjusted accordingly to improve performance.
		if (_playersInRange) then {_sleepTime = 2} else {_sleepTime = 15};
	};

	if (_lockedTarget != _zombie) then {
		_zombie doMove getPosASL _lockedTarget;
		if (_zombie distance _lockedTarget < 2 && alive _lockedTarget) then {
			//_zombie switchMove "AwopPercMstpSgthWnonDnon_end";
			_zombie playAction "ThrowGrenade";
			sleep .5;
			if (_zombie distance _lockedTarget < 2 && alive _lockedTarget) then {
				_nearPlayers = _zombie nearEntities [["man"],100];
				{
					playZSound = [_zombie, "punch"]; 
					(owner _x) publicVariableClient "playZSound";
				} foreach _nearPlayers;
				_lockedTarget setDamage (damage _lockedTarget + 0.05);
			};
		};
		if (!alive _lockedTarget) then {
				_lockedTarget = _zombie;
		};
		_sleepTime = 1;
	};

	sleep _sleepTime;
};