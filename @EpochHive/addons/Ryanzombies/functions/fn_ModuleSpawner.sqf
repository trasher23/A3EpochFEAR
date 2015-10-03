_logic = [_this,0,objNull,[objNull]] call BIS_fnc_param;
_units = [_this,1,[],[[]]] call BIS_fnc_param;
_activated = [_this,2,true,[true]] call BIS_fnc_param;

if (_activated) then {
	_Amount = _logic getVariable "Amount";
	_TotalAmount = _logic getVariable "TotalAmount";
	_Start = _logic getVariable "Start";
	_Frequency = _logic getVariable "Frequency";
	_Delay = _logic getVariable "Delay";
	_Density = _logic getVariable "Density";
	_Activation = _logic getVariable "Activation";
	_ActivationRadius = _logic getVariable "ActivationRadius";
	_HordeSize = _logic getVariable "HordeSize";
	ryanzombiesamount = _Amount;
	ryanzombiestotalamount = _TotalAmount - 1;
	ryanzombiesstart = _Start;
	ryanzombiesfrequency = _Frequency;
	ryanzombiesdelay = _Delay;
	ryanzombiesdensity = _Density;
	ryanzombiesactivation = _Activation;
	ryanzombiesactivationradius = _ActivationRadius;
	ryanzombieshordesize = _HordeSize;
};

true