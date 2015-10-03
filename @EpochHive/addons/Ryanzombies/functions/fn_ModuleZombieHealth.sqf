_logic = [_this,0,objNull,[objNull]] call BIS_fnc_param;
_units = [_this,1,[],[[]]] call BIS_fnc_param;
_activated = [_this,2,true,[true]] call BIS_fnc_param;

if (_activated) then {
	_ZombieMaxHealth = _logic getVariable "ZombieMaxHealth";
	_DemonMaxHealth = _logic getVariable "DemonMaxHealth";
	ryanzombieshealth = _ZombieMaxHealth;
	ryanzombieshealthdemon = _DemonMaxHealth;
};

true