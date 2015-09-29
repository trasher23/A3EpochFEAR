#include "\A3EAI\globaldefines.hpp"

private ["_noAggroArea", "_objectPos"];

_objectPos = _this;

_noAggroArea = locationNull;
if ((typeName _this) isEqualTo "OBJECT") then {_objectPos = getPosATL _this};

{
	if (_objectPos in _x) exitWith {
		_noAggroArea = _x;
	};
} forEach A3EAI_noAggroAreas;

_noAggroArea
