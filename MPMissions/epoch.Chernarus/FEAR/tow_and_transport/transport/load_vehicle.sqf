// Credits (please keep in-tact and additive if modifying)
//		R3F guys: Envisioning this addon and initial implementation
//		Scrap Iron (IHG servers): Almost complete overhaul inc. new UI and update some existing functions

if (TAT_isOperationInProgress) then
{
    cutText [TAT_opNotFinishedMsg, "PLAIN DOWN"]; 
}
else
{
	TAT_isOperationInProgress = true;
	
	private ["_vehicle", "_transporter", "_i"];
	
	_vehicle = TAT_selectedVehicle;
	_transporter = _this select 0;
	
	if (!(isNull _vehicle) && !(_vehicle getVariable "TAT_isDisabled")) then
	{
		if (isNull (_vehicle getVariable "TAT_isTransportedBy") && (isNull (_vehicle getVariable "TAT_isMovedBy") || (!alive (_vehicle getVariable "TAT_isMovedBy")))) then
		{
			private ["_stowedVehicles", "_stowedVehicleTotalWeight", "_stowedVehicleWeight", "_transporterPayloadCapacity"];
			
			_stowedVehicles = _transporter getVariable "TAT_payload";
			
			// Calculation of current load
			_stowedVehicleTotalWeight = 0;
			{
				for [{_i = 0}, {_i < count TAT_transportableVehicleData}, {_i = _i + 1}] do
				{
					if (_x isKindOf (TAT_transportableVehicleData select _i select 0)) exitWith
					{
						_stowedVehicleTotalWeight = _stowedVehicleTotalWeight + (TAT_transportableVehicleData select _i select 1);
					};
				};
			} forEach _stowedVehicles;
			
			// Get the stowed vehicle capacity
			_stowedVehicleWeight = 99999;
			for [{_i = 0}, {_i < count TAT_transportableVehicleData}, {_i = _i + 1}] do
			{
				if (_vehicle isKindOf (TAT_transportableVehicleData select _i select 0)) exitWith
				{
					_stowedVehicleWeight = (TAT_transportableVehicleData select _i select 1);
				};
			};
			
			// Get the transporter payload capacity
			_transporterPayloadCapacity = 0;
			for [{_i = 0}, {_i < count TAT_transportVehicleData}, {_i = _i + 1}] do
			{
				if (_transporter isKindOf (TAT_transportVehicleData select _i select 0)) exitWith
				{
					_transporterPayloadCapacity = (TAT_transportVehicleData select _i select 1);
				};
			};
			
			// Do if there is room left in the transporter
			if (_stowedVehicleTotalWeight + _stowedVehicleWeight <= _transporterPayloadCapacity) then
			{
				if (_vehicle distance _transporter <= 30) then
				{
					// Player animation
					[0] call IHG_fnc_playAnim;
                    
					_stowedVehicles = _stowedVehicles + [_vehicle];
					_transporter setVariable ["TAT_payload", _stowedVehicles, true];
					
					// Choose a temporary position out in the nether to put the vehicle while it's "in transport"
					private ["_posAttempt", "_attachmentPos"];
                    
					_attachmentPos = [random 3000, random 3000, (10000 + (random 3000))];
                    
					_posAttempt = 1;
                    
					while {(!isNull (nearestObject _attachmentPos)) && (_posAttempt < 25)} do
					{
						_attachmentPos = [random 3000, random 3000, (10000 + (random 3000))];
						_posAttempt = _posAttempt + 1;
					};

					_vehicle attachTo [TAT_attachmentPoint, _attachmentPos];
					
					TAT_selectedVehicle = objNull;
					
					TAT_isSelectedForTransport = false;
					
                    cutText [format["The ""%1"" has been loaded in the vehicle.", getText (configFile >> "CfgVehicles" >> (typeOf _vehicle) >> "displayName")],"PLAIN DOWN"];
				}
				else
				{
                     cutText [format["The ""%1"" is too far from the vehicle to be loaded.", getText (configFile >> "CfgVehicles" >> (typeOf _vehicle) >> "displayName")],"PLAIN DOWN"];
				};
			}
			else
			{
                cutText ["There is not enough space in this vehicle.", "PLAIN DOWN"];
			};
		}
		else
		{
            cutText [format ["The ""%1"" is currently being transported.", getText (configFile >> "CfgVehicles" >> (typeOf _vehicle) >> "displayName")], "PLAIN DOWN"];
		};
	};
	
	TAT_isOperationInProgress = false;
};