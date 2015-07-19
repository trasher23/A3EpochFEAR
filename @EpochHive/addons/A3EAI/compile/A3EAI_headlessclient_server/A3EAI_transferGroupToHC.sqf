private ["_unitGroup", "_unitLevel", "_trigger", "_unitType", "_groupSize","_lootPool","_miscData","_miscData2","_groupData""_result","_vehicle"];
_unitGroup = _this;

if ((diag_tickTime - A3EAI_lastGroupTransfer) < 5) exitWith {false};
A3EAI_lastGroupTransfer = diag_tickTime;

/*
if (A3EAI_debugLevel > 1) then {
	diag_log format ["%1 variables: %2",_unitGroup,(allVariables _unitGroup)];
};
*/

_unitLevel = _unitGroup getVariable ["unitLevel",0];
_trigger = _unitGroup getVariable ["trigger",nil];
_unitType = _unitGroup getVariable ["unitType","unknown"];
_groupSize = _unitGroup getVariable ["GroupSize",nil];
_lootPool = _unitGroup getVariable ["LootPool",[]];
_miscData = _unitGroup getVariable ["MiscData",nil];
_miscData2 = _unitGroup getVariable ["MiscData2",nil];
_vehicle = _unitGroup getVariable ["assignedVehicle",nil];

_groupData = [_unitGroup,_unitLevel,nil,_unitType,_groupSize,_lootPool];

if (!isNil "_trigger") then {_groupData set [2,(getPosATL _trigger)];};
if (!isNil "_vehicle") then {_groupData set [2,_vehicle];};
if (!isNil "_miscData") then {_groupData set [6,_miscData];};
if (!isNil "_miscData2") then {_groupData set [7,_miscData2];};

A3EAI_transferGroup_PVC = _groupData;
A3EAI_HCObjectOwnerID publicVariableClient "A3EAI_transferGroup_PVC";

_result = _unitGroup setGroupOwner A3EAI_HCObjectOwnerID; 

_result