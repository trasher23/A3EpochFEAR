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
		
	private ["_transporter", "_stowedVehicles", "_stowedVehicleClass", "_stowedVehicle", "_i"];
	
	_transporter = uiNamespace getVariable "TAT_currentTransporter";
	
	_stowedVehicles = _transporter getVariable "TAT_payload";
	
	_stowedVehicleClass = lbData [20105, lbCurSel 20105];
	
	closeDialog 0;
	
	// Find stowed vehicle with the specified class
	_stowedVehicle = objNull;
	for [{_i = 0}, {_i < count _stowedVehicles}, {_i = _i + 1}] do
	{
		if (typeOf (_stowedVehicles select _i) == _stowedVehicleClass) exitWith
		{
			_stowedVehicle = _stowedVehicles select _i;
		};
	};
	
	if !(isNull _stowedVehicle) then
	{
		_stowedVehicles = _stowedVehicles - [_stowedVehicle];
		_transporter setVariable ["TAT_payload", _stowedVehicles, true];
		
		detach _stowedVehicle;
		    
		private ["_dimension_max"];
		
		_dimension_max = (((boundingBox _stowedVehicle select 1 select 1) max (-(boundingBox _stowedVehicle select 0 select 1))) max ((boundingBox _stowedVehicle select 1 select 0) max (-(boundingBox _stowedVehicle select 0 select 0))));

		// Player animation
		[0] call IHG_fnc_playAnim;
		
		// Place the object randomly towards the rear of the vehicle being unpacked from
		_stowedVehicle setPos
		[
			(getPos _transporter select 0) - ((_dimension_max+5+(random 10)-(boundingBox _transporter select 0 select 1))*sin (getDir _transporter - 90+random 180)),
			(getPos _transporter select 1) - ((_dimension_max+5+(random 10)-(boundingBox _transporter select 0 select 1))*cos (getDir _transporter - 90+random 180)),
			0
		];
		_stowedVehicle setVelocity [0, 0, 0];
		
		cutText [format["The ""%1"" has been unloaded from the vehicle.", getText (configFile >> "CfgVehicles" >> (typeOf _stowedVehicle) >> "displayName")],"PLAIN DOWN"];
	}
	else
	{
		cutText [format["The ""%1"" has already been unloaded.", getText (configFile >> "CfgVehicles" >> (typeOf _stowedVehicle) >> "displayName")],"PLAIN DOWN"];
	};
	
	TAT_isOperationInProgress = false;
};