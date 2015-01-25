// Credits (please keep in-tact and additive if modifying)
//		R3F guys: Envisioning this addon and initial implementation
//		Scrap Iron (IHG servers): Almost complete overhaul inc. new UI and update some existing functions

waitUntil {!isNil "TAT_configLoaded"};

[] spawn
{
	private ["_moveableVehicles", "_initializedVehicles", "_newVehicles", "_newVehicleCount", "_i", "_vehicle"];
	
	TAT_opNotFinishedMsg = "The current operation isn't finished.";

	if !(isServer && isDedicated) then
	{
		// Wait for attachment point
		waitUntil {!isNil "TAT_attachmentPoint"};
		
		// Tracks operation state
		TAT_isOperationInProgress = false;
		
		// Currently selected object to be loaded / towed
		TAT_selectedVehicle = objNull;
		
		// Flag to indicate selected vehicle is selected for tow or transport
		TAT_isSelectedForTransport = false;
		
		// Action menu variable
		s_player_TAT_action = objNull;
		
		// Used in determining whether or not to display action menu
		TAT_canTransportSelectedVehicle = false;
		TAT_canViewPayload = false;
		TAT_canTowSelectedVehicle = false;
		TAT_canBeTowed = false;
		TAT_canBeUntowed = false;
		TAT_canBeTransported = false;
		
		// Action menu
		execVM "addons\tow_and_transport\action_menu.sqf";

		sleep 0.1;

		// Towable/Transportable vehicles
		_moveableVehicles = TAT_towableVehicles + TAT_transportableVehicles;

		// Contain the list of vehicles (and objects) already initialized
		_initializedVehicles = [];
		
		while {true} do
		{
			if !(isNull player) then
			{
				// Retrieving all *new* vehicles and new map objects near the player derived from "Static"
				_newVehicles = (vehicles + nearestObjects [player, ["Static"], 80]) - _initializedVehicles;
				_newVehicleCount = count _newVehicles;
				
				if (_newVehicleCount > 0) then
				{
					// Initialize each new vehicle
					for [{_i = 0}, {_i < _newVehicleCount}, {_i = _i + 1}] do
					{
						_vehicle = _newVehicles select _i;
						
						// Vehicle can be towed/transported
						if ({_vehicle isKindOf _x} count _moveableVehicles > 0) then
						{
							[_vehicle] spawn (compile preprocessFile "addons\tow_and_transport\init_moveable_vehicle.sqf");
						};
						
						// Vehicle can tow
						if ({_vehicle isKindOf _x} count TAT_towVehicles > 0) then
						{
							[_vehicle] spawn (compile preprocessFile "addons\tow_and_transport\tow\init_tow_vehicle.sqf");
						};
						
						// Vehicle can transport
						if ({_vehicle isKindOf _x} count TAT_transportVehicles > 0) then
						{
							[_vehicle] spawn (compile preprocessFile "addons\tow_and_transport\transport\init_transport_vehicle.sqf");
						};
					};
					
					// Store initialized vehicles
					_initializedVehicles = _initializedVehicles + _newVehicles;
				}
				else
				{
					sleep 15;
				};
			}
			else
			{
				sleep 2;
			};
		};
	};
};