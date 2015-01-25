// Credits (please keep in-tact and additive if modifying)
//		R3F guys: Envisioning this addon and initial implementation
//		Scrap Iron (IHG servers): Almost complete overhaul inc. new UI and update some existing functions

private ["_vehicle", "_isDisabled", "_vehiclePayload"];

_vehicle = _this select 0;

_isDisabled = _vehicle getVariable "TAT_isDisabled";

if (isNil "_isDisabled") then
{
	_vehicle setVariable ["TAT_isDisabled", false];
};

_vehiclePayload = _vehicle getVariable "TAT_payload";

if (isNil "_vehiclePayload") then
{
	_vehicle setVariable ["TAT_payload", [], false];
};

_vehicle addAction [("<t color=""#FFBB00"">Transport with this vehicle</t>"), "addons\tow_and_transport\transport\load_vehicle.sqf", nil, 6, false, true, "", "s_player_TAT_action == _target && TAT_canTransportSelectedVehicle"];
_vehicle addAction [("<t color=""#FFBB00"">Cancel transport</t>"), "TAT_selectedVehicle = objNull; TAT_isSelectedForTransport = false;", nil, 6, false, true, "", "s_player_TAT_action == _target && TAT_canTransportSelectedVehicle"];
_vehicle addAction [("<t color=""#FFBB00"">View payload</t>"), "addons\tow_and_transport\transport\open_payload_dialog.sqf", nil, 5, false, true, "", "s_player_TAT_action == _target && TAT_canViewPayload"];