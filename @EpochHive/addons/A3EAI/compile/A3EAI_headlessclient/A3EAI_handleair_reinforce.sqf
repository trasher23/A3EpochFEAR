private ["_unitGroup", "_unitLevel", "_trigger", "_unitType", "_groupSize","_patrolParams"];

_unitGroup = _this;

_unitLevel = _unitGroup getVariable ["unitLevel",1];
_unitType = _unitGroup getVariable ["unitType","unknown"];
_groupSize = _unitGroup getVariable ["GroupSize",-1];

//_vehicle = assignedVehicle (leader _unitGroup);
//_unitGroup setVariable ["assignedVehicle",_vehicle];
_vehicle = _unitGroup getVariable ["assignedVehicle",assignedVehicle (leader _unitGroup)];
(assignedDriver _vehicle) setVariable ["isDriver",true];
_vehicle call A3EAI_addVehAirEH;
_vehicle call A3EAI_secureVehicle;
_vehicle setVariable ["unitGroup",_unitGroup];

[_unitGroup,_vehicle] spawn A3EAI_airReinforcementDetection;

if (A3EAI_debugLevel > 1) then {diag_log format ["A3EAI Extended Debug: Group %1 (Level: %2): %3, %4, %5, %6",_unitGroup,_unitLevel,_vehicle,(assignedDriver _vehicle),_unitType,_groupSize];};

true