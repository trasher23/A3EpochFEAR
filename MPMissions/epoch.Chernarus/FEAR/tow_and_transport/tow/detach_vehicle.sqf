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
	
	private ["_leadVehicle", "_vehicleBeingTowed"];
	
	_vehicleBeingTowed = _this select 0;
	_leadVehicle = _vehicleBeingTowed getVariable "TAT_isTransportedBy";
	
	if ({_leadVehicle isKindOf _x} count TAT_towVehicles > 0) then
	{
		// Is stored on the network that the vehicle towing something
		_leadVehicle setVariable ["TAT_isTowing", objNull, true];
        
		// It also stores the network as the object is attached trailer
		_vehicleBeingTowed setVariable ["TAT_isTransportedBy", objNull, true];
		
		detach _vehicleBeingTowed;
		_vehicleBeingTowed setVelocity [0, 0, 0];
		
		[0] call IHG_fnc_playAnim;

		cutText [format ["""%1"" has been detached.", getText (configFile >> "CfgVehicles" >> (typeOf _vehicleBeingTowed) >> "displayName")], "PLAIN DOWN"];
	}
	else
	{
		cutText [format ["Only the driver can detach ""%1""from this vehicle.", getText (configFile >> "CfgVehicles" >> (typeOf _vehicleBeingTowed) >> "displayName")], "PLAIN DOWN"];
	};
	
	TAT_isOperationInProgress = false;
};