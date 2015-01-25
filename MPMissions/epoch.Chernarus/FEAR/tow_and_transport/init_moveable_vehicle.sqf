// Credits (please keep in-tact and additive if modifying)
//		R3F guys: Envisioning this addon and initial implementation
//		Scrap Iron (IHG servers): Almost complete overhaul inc. new UI and update some existing functions

private ["_vehicle", "_isDisabled", "_isTransportedBy", "_isMovedBy"];

_vehicle = _this select 0;

_isDisabled = _vehicle getVariable "TAT_isDisabled";
if (isNil "_isDisabled") then
{
	_vehicle setVariable ["TAT_isDisabled", false];
};

_isTransportedBy = _vehicle getVariable "TAT_isTransportedBy";
if (isNil "_isTransportedBy") then
{
	_vehicle setVariable ["TAT_isTransportedBy", objNull, false];
};

_isMovedBy = _vehicle getVariable "TAT_isMovedBy";
if (isNil "_isMovedBy") then
{
	_vehicle setVariable ["TAT_isMovedBy", objNull, false];
};

// Do not allow riding in a vehicle that is in transit
_vehicle addEventHandler ["GetIn",
{
	if (_this select 2 == player) then
	{
		_this spawn
		{
			if ((!(isNull (_this select 0 getVariable "TAT_isMovedBy")) && (alive (_this select 0 getVariable "TAT_isMovedBy"))) || !(isNull (_this select 0 getVariable "TAT_isTransportedBy"))) then
			{
				player action ["eject", _this select 0];
                cutText ["You cannot ride in a vehicle that's being towed!", "PLAIN DOWN"];
			};
		};
	};
}];

// Do for towable vehicles
if ({_vehicle isKindOf _x} count TAT_towableVehicles > 0) then
{
	_vehicle addAction [("<t color=""#FFBB00"">" + "Tow" + "</t>"), "addons\tow_and_transport\tow\select_vehicle.sqf", nil, 5, false, true, "", "s_player_TAT_action == _target && TAT_canBeTowed"];
	_vehicle addAction [("<t color=""#FFBB00"">" + "Detach" + "</t>"), "addons\tow_and_transport\tow\detach_vehicle.sqf", nil, 6, false, true, "", "s_player_TAT_action == _target && TAT_canBeUntowed"];
};

// Do for transportable vehicles
if ({_vehicle isKindOf _x} count TAT_transportableVehicles > 0) then
{
	_vehicle addAction [("<t color=""#FFBB00"">" + "Prep for transport" + "</t>"), "addons\tow_and_transport\transport\select_vehicle.sqf", nil, 5, false, true, "", "s_player_TAT_action == _target && TAT_canBeTransported"];
};