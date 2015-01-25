// Credits (please keep in-tact and additive if modifying)
//		R3F guys: Envisioning this addon and initial implementation
//		Scrap Iron (IHG servers): Almost complete overhaul inc. new UI and update some existing functions

disableSerialization;

if (TAT_isOperationInProgress) then
{
    cutText [TAT_opNotFinishedMsg, "PLAIN DOWN"]; 
}
else
{
	TAT_isOperationInProgress = true;
	
	private ["_vehicle", "_stowedVehicleTotalWeight", "_transporterPayloadCapacity", "_payload"];
	private ["_stowedVehicles", "_stowedVehicleQty", "_i", "_j", "_dialog"];
	
	_vehicle = _this select 0;
	
	uiNamespace setVariable ["TAT_currentTransporter", _vehicle];
	
	createDialog "DLG_TAT_Transporter";
	
	_payload = _vehicle getVariable "TAT_payload";
	
	// List of unique stowed vehicle types
	_stowedVehicles = [];
    
	// Number of each stowed vehicle type
	_stowedVehicleQty = [];
	
	_stowedVehicleTotalWeight = 0;
	
	for [{_i = 0}, {_i < count _payload}, {_i = _i + 1}] do
	{
		private ["_vehicle"];
		_vehicle = _payload select _i;
		
		if !((typeOf _vehicle) in _stowedVehicles) then
		{
			_stowedVehicles = _stowedVehicles + [typeOf _vehicle];
			_stowedVehicleQty = _stowedVehicleQty + [1];
		}
		else
		{
			private ["_vehicleIndex"];
			_vehicleIndex = _stowedVehicles find (typeOf _vehicle);
			_stowedVehicleQty set [_vehicleIndex, ((_stowedVehicleQty select _vehicleIndex) + 1)];
		};
		
		// Adding the object of the current loading
		for [{_j = 0}, {_j < count TAT_transportableVehicleData}, {_j = _j + 1}] do
		{
			if (_vehicle isKindOf (TAT_transportableVehicleData select _j select 0)) exitWith
			{
				_stowedVehicleTotalWeight = _stowedVehicleTotalWeight + (TAT_transportableVehicleData select _j select 1);
			};
		};
	};
	
	// Search for the maximum capacity of the carrier
	_transporterPayloadCapacity = 0;
	for [{_i = 0}, {_i < count TAT_transportVehicleData}, {_i = _i + 1}] do
	{
		if (_vehicle isKindOf (TAT_transportVehicleData select _i select 0)) exitWith
		{
			_transporterPayloadCapacity = (TAT_transportVehicleData select _i select 1);
		};
	};
    
	private ["_vehicleList"];
	
	_dialog = findDisplay 20100;
	
	// Set the text for various labels on the dialog
	(_dialog displayCtrl 20104) ctrlSetText (format ["%1/%2 kg", _stowedVehicleTotalWeight, _transporterPayloadCapacity]);
	
    // Initialize the list box
	_vehicleList = _dialog displayCtrl 20105;
	
    // Disable unload button if there is no payload
	if (count _stowedVehicles == 0) then
	{
		(_dialog displayCtrl 20107) ctrlEnable false;
	}
	else
	{
		// Insertion of each type of object in the list
		for [{_i = 0}, {_i < count _stowedVehicles}, {_i = _i + 1}] do
		{
			private ["_index", "_icon"];
			
			_icon = getText (configFile >> "CfgVehicles" >> (_stowedVehicles select _i) >> "picture");
			
			// Insert if item has a valid picture
			if (toString ([toArray _icon select 0]) == "\") then
			{
				_index = _vehicleList lbAdd (getText (configFile >> "CfgVehicles" >> (_stowedVehicles select _i) >> "displayName") + format [" (%1x)", _stowedVehicleQty select _i]);
				
                _vehicleList lbSetPicture [_index, _icon];
			}
			else
			{
                _index = _vehicleList lbAdd ("     " + getText (configFile >> "CfgVehicles" >> (_stowedVehicles select _i) >> "displayName") + format [" (%1x)", _stowedVehicleQty select _i]);
			};
			
			_vehicleList lbSetData [_index, _stowedVehicles select _i];
		};
	};
	
	waitUntil (uiNamespace getVariable "DLG_TAT_Transporter");
	TAT_isOperationInProgress = false;
};