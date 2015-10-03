_logic = [_this,0,objNull,[objNull]] call BIS_fnc_param;
_units = [_this,1,[],[[]]] call BIS_fnc_param;
_activated = [_this,2,true,[true]] call BIS_fnc_param;

if (_activated) then {
	_Infection = _logic getVariable "Infection";
	_InfectionTimer = _logic getVariable "InfectionTimer";
	_Uniform = _logic getVariable "Uniform";
	ryanzombiesinfection = _Infection;
	ryanzombiesinfectiontimer = _InfectionTimer;
	ryanzombiesuniform = _Uniform;
};

true