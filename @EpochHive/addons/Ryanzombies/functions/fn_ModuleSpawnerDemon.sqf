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
	_ActivationDemon = _logic getVariable "ActivationDemon";
	_ActivationRadiusDemon = _logic getVariable "ActivationRadiusDemon";
	_HordeSize = _logic getVariable "HordeSize";
	ryanzombiesamountdemon = _Amount;
	ryanzombiestotalamountdemon = _TotalAmount - 1;
	ryanzombiesstartdemon = _Start;
	ryanzombiesfrequencydemon = _Frequency;
	ryanzombiesdelaydemon = _Delay;
	ryanzombiesdensitydemon = _Density;
	ryanzombiesactivationdemon = _ActivationDemon;
	ryanzombiesactivationradiusdemon = _ActivationRadiusDemon;
	ryanzombieshordesizedemon = _HordeSize;
};

true