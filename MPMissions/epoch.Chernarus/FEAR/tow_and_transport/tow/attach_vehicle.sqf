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
	
	private ["_vehicleToTow", "_leadVehicle"];
	
	_vehicleToTow = TAT_selectedVehicle;
	_leadVehicle = _this select 0;
	
	if (!(isNull _vehicleToTow) && (alive _vehicleToTow) && !(_vehicleToTow getVariable "TAT_isDisabled")) then
	{
		if (isNull (_vehicleToTow getVariable "TAT_isTransportedBy") && (isNull (_vehicleToTow getVariable "TAT_isMovedBy") || (!alive (_vehicleToTow getVariable "TAT_isMovedBy")))) then
		{
			if (_vehicleToTow distance _leadVehicle <= 30) then
			{
			 	// The vehicle that is towing
				_tempobj = _leadVehicle;
				_countTransportedBy = 1;
				
				while {!isNull(_tempobj getVariable["TAT_isTransportedBy", objNull])} do
				{
					_countTransportedBy = _countTransportedBy + 1; _tempobj = _tempobj getVariable["TAT_isTransportedBy", objNull];
				};
				
				// The vehicle that is being towed
				_tempobj = _vehicleToTow;
				_towedVehicleCount = 1;
				
				while {!isNull(_tempobj getVariable["TAT_isTowing", objNull])} do
				{
					_towedVehicleCount = _towedVehicleCount + 1;
					_tempobj = _tempobj getVariable["TAT_isTowing", objNull];
				};
				
				if(_countTransportedBy + _towedVehicleCount <= 2) then
				{
					// Variable to indicate lead vehicle is towing something
					_leadVehicle setVariable ["TAT_isTowing", _vehicleToTow, true];
					
					// Variable to indicate towable is being towed
					_vehicleToTow setVariable ["TAT_isTransportedBy", _leadVehicle, true];
					
					// Move player to side of vehicle (buggy)
					// Work-around for BI bug (attach and setVectorDirAndUp must be executed twice in MP)
					/*
					for "_i" from 1 to 2 do
					{					
						player attachTo
						[
							_leadVehicle,
							[
								(boundingBox _leadVehicle select 1 select 0),
								(boundingBox _leadVehicle select 0 select 1) + 1,
								(boundingBox _leadVehicle select 0 select 2) - (boundingBox player select 0 select 2)
							]
						];
						
						player setVectorDirAndUp [[-1,0,0], [0,0,1]];
					};
					*/
					
					[0] call IHG_fnc_playAnim;

					// More buggy
					/*
					// Adjust attachment point offset depending on vehicles
					if (_vehicleToTow isKindOf "Truck" && !(_leadVehicle isKindOf "Truck")) then
					{
						objectOffset = 1;
					}
					else
					{
						objectOffset = 0.2
					};
					*/

					// TODO: Offsets for specific vehicles or types
					_vehicleToTow attachTo 
					[
						_leadVehicle,
						[
							/*Offset right*/ 0,
							/*Offset front*/ ((boundingBox _leadVehicle select 0 select 1) / 1.2) + ((boundingBox _vehicleToTow select 0 select 1) / 1.2),
							/*Offset up   */ (boundingBox _leadVehicle select 0 select 2) - (boundingBox _vehicleToTow select 0 select 2)
						]
					];
					
					TAT_selectedVehicle = objNull;

					// Buggy
					//detach player;
				}
				else
				{
					cutText ["You can't tow more than one vehicle.", "PLAIN DOWN"];
				};
			}
			else
			{
				cutText [format ["""%1"" is too far from the vehicle to be towed.", getText (configFile >> "CfgVehicles" >> (typeOf _vehicleToTow) >> "displayName")], "PLAIN DOWN"];
			};
		}
		else
		{
			cutText [format ["""%1"" is in transit.", getText (configFile >> "CfgVehicles" >> (typeOf _vehicleToTow) >> "displayName")], "PLAIN DOWN"];
		};
	};
	
	TAT_isOperationInProgress = false;
};