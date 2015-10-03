_target = _this select 0;
 
if(isPlayer _target) then {
 
[-2,{
_target = _this;
if(player == _target) then {
_body = _target gethit "body";
_legLeft = _target gethit "leg_l";
_legRight = _target getHit "leg_r";
if (_body > 0.85) then {_target sethit ["body",1]; _target setdammage 1};
_target sethit ["body",_body + Ryanzombiesdamage];
_target sethit ["leg_l",_legLeft + Ryanzombiesdamage];
_target sethit ["leg_r",_legRight + Ryanzombiesdamage];
};
},_target] call CBA_fnc_globalExecute;
 
} else {
 
_body = _target gethit "body";
_legLeft = _target gethit "leg_l";
_legRight = _target getHit "leg_r";
if (_body > 0.85) then {_target sethit ["body",1]; _target setdammage 1};
_target sethit ["leg_l",_legLeft + Ryanzombiesdamage];
_target sethit ["leg_r",_legRight + Ryanzombiesdamage];
 
};