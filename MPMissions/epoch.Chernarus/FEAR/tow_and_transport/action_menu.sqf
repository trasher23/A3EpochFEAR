// Credits (please keep in-tact and additive if modifying)
//		R3F guys: Envisioning this addon and initial implementation
//		Scrap Iron (IHG servers): Almost complete overhaul inc. new UI and update some existing functions

private ["_cursorTarget", "_isVehicleLocked", "_fnc_isVehicleLocked"];

_isVehicleLocked = false;

_fnc_isVehicleLocked =
{
	private ["_isLocked"];
	
	_isLocked = locked _this in [2,3];
	
	_isLocked;
};

while {true} do
{
	s_player_TAT_action = objNull;
	
	_cursorTarget = cursorTarget;
	
	if !(isNull _cursorTarget) then
	{
		if (player distance _cursorTarget <= 5) then
		{
			s_player_TAT_action = _cursorTarget;
			
			// Vehicle is towable
			if ({_cursorTarget isKindOf _x} count TAT_towableVehicles > 0) then
			{
				_isVehicleLocked = _cursorTarget call _fnc_isVehicleLocked;
				
				// Vehicle can be towed
				TAT_canBeTowed = (!(_isVehicleLocked) && vehicle player == player && (alive _cursorTarget) && (count crew _cursorTarget == 0) && isNull (_cursorTarget getVariable "TAT_isTransportedBy") &&
					(isNull (_cursorTarget getVariable "TAT_isMovedBy") || (!alive (_cursorTarget getVariable "TAT_isMovedBy"))) &&
					!(_cursorTarget getVariable "TAT_isDisabled") && (isNull (_cursorTarget getVariable "TAT_isTowing")));
				
				// Vehicle can be untowed
				TAT_canBeUntowed = (vehicle player == player &&
					!isNull (_cursorTarget getVariable "TAT_isTransportedBy") && !(_cursorTarget getVariable "TAT_isDisabled"));
			};
			
			// Vehicle is transportable
			if ({_cursorTarget isKindOf _x} count TAT_transportableVehicles > 0) then
			{
				_isVehicleLocked = _cursorTarget call _fnc_isVehicleLocked;
				
				// Vehicle can be transported
				TAT_canBeTransported = (!(_isVehicleLocked) && vehicle player == player && (count crew _cursorTarget == 0) && isNull (_cursorTarget getVariable "TAT_isTransportedBy") &&
					(isNull (_cursorTarget getVariable "TAT_isMovedBy") || (!alive (_cursorTarget getVariable "TAT_isMovedBy"))) &&
					!(_cursorTarget getVariable "TAT_isDisabled"));
			};
			
			// Vehicle can tow
			if ({_cursorTarget isKindOf _x} count TAT_towVehicles > 0) then
			{
				// Selected vehicle was selected for towing
				if(!TAT_isSelectedForTransport) then
				{
					// Vehicle can be towed
					TAT_canTowSelectedVehicle = (vehicle player == player && (alive _cursorTarget) &&
						(!isNull TAT_selectedVehicle) && (TAT_selectedVehicle != _cursorTarget) &&
						!(TAT_selectedVehicle getVariable "TAT_isDisabled") &&
						({TAT_selectedVehicle isKindOf _x} count TAT_towableVehicles > 0) &&
						isNull (_cursorTarget getVariable "TAT_isTowing") && ([0,0,0] distance velocity _cursorTarget < 6) &&
						(getPos _cursorTarget select 2 < 2) && !(_cursorTarget getVariable "TAT_isDisabled"));
				};
			};
			
			// Vehicle can transport
			if ({_cursorTarget isKindOf _x} count TAT_transportVehicles > 0) then
			{
				_isVehicleLocked = _cursorTarget call _fnc_isVehicleLocked;
			
				// Selected vehicle can be transported by target vehicle
				TAT_canTransportSelectedVehicle = (alive _cursorTarget && (vehicle player == player) &&
					(!isNull TAT_selectedVehicle) && (TAT_selectedVehicle != _cursorTarget) && (TAT_isSelectedForTransport) &&
					!(TAT_selectedVehicle getVariable "TAT_isDisabled") &&
					({TAT_selectedVehicle isKindOf _x} count TAT_transportableVehicles > 0) &&
					([0,0,0] distance velocity _cursorTarget < 6) && (getPos _cursorTarget select 2 < 2) && !(_cursorTarget getVariable "TAT_isDisabled"));
				
				// Vehicle has viewable payload
				TAT_canViewPayload = (!(_isVehicleLocked) && (alive _cursorTarget) && (vehicle player == player) &&
					([0,0,0] distance velocity _cursorTarget < 6) && (getPos _cursorTarget select 2 < 2) && !(_cursorTarget getVariable "TAT_isDisabled"));
			};
		};
	};
	
	sleep 0.3;
};