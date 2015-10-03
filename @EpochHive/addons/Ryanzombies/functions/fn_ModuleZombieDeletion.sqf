_logic = [_this,0,objNull,[objNull]] call BIS_fnc_param;
_units = [_this,1,[],[[]]] call BIS_fnc_param;
_activated = [_this,2,true,[true]] call BIS_fnc_param;

if (_activated) then {
	_Deletion = _logic getVariable "Deletion";
	_DeletionRadius = _logic getVariable "DeletionRadius";
	_DeletionDemons = _logic getVariable "DeletionDemons";
	_DeletionRadiusDemons = _logic getVariable "DeletionRadiusDemons";
	ryanzombiesdeletion = _Deletion;
	ryanzombiesdeletionradius = _DeletionRadius;
	ryanzombiesdeletiondemons = _DeletionDemons;
	ryanzombiesdeletionradiusdemons = _DeletionRadiusDemons;
};

true