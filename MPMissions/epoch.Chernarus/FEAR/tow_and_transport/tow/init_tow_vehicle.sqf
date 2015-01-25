// Credits (please keep in-tact and additive if modifying)
//		R3F guys: Envisioning this addon and initial implementation
//		Scrap Iron (IHG servers): Almost complete overhaul inc. new UI and update some existing functions

private ["_leadVehicle", "_isDisabled", "_isTowing"];

_leadVehicle = _this select 0;

_isDisabled = _leadVehicle getVariable "TAT_isDisabled";
if (isNil "_isDisabled") then
{
	_leadVehicle setVariable ["TAT_isDisabled", false];
};

_isTowing = _leadVehicle getVariable "TAT_isTowing";

if (isNil "_isTowing") then
{
	_leadVehicle setVariable ["TAT_isTowing", objNull, false];
};

_leadVehicle addAction [("<t color=""#FFBB00"">Tow with this vehicle</t>"), "addons\tow_and_transport\tow\attach_vehicle.sqf", nil, 6, false, true, "", "s_player_TAT_action == _target && TAT_canTowSelectedVehicle"];
_leadVehicle addAction [("<t color=""#FFBB00"">Cancel tow</t>"), "TAT_selectedVehicle = objNull;", nil, 6, false, true, "", "s_player_TAT_action == _target && TAT_canTowSelectedVehicle"];