private ["_unitGroup", "_vehicle","_inNoAggroArea"];

_unitGroup = _this select 0;
_vehicle = _this select 1;

_this call A3EAI_checkInNoAggroArea;

true