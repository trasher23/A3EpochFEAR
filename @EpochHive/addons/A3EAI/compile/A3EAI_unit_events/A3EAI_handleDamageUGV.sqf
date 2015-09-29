#include "\A3EAI\globaldefines.hpp"

private["_object","_hit","_damage","_source","_ammo","_hitPoint"];

_object = 		_this select 0;				//Object the event handler is assigned to. (the unit taking damage)
_hit = 			_this select 1;				//Name of the selection where the unit was damaged. "" for over-all structural damage, "?" for unknown selections. 
_damage = 		_this select 2;				//Resulting level of damage for the selection. (Received damage)
_source = 		_this select 3;				//The source unit that caused the damage. 
//_ammo = 		_this select 4;				//Classname of the projectile that caused inflicted the damage. ("" for unknown, such as falling damage.) 
_hitPartIndex = _this select 5;				//Hit part index of the hit point, -1 otherwise.

_hitPoint = (_object getHitIndex _hitPartIndex);
if (_damage > _hitPoint) then {
	call {
		if ((group _object) call A3EAI_getNoAggroStatus) exitWith {_damage = _hitPoint;};
		if !(isPlayer _source) exitWith {_damage = _hitPoint;};
	};
};

_damage