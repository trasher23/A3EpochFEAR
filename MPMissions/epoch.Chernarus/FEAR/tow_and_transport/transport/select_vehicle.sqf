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
	
	TAT_selectedVehicle = _this select 0;
	
	TAT_isSelectedForTransport = true;
	
    cutText [format ["Now select the vehicle to load the ""%1"" in to", getText (configFile >> "CfgVehicles" >> (typeOf TAT_selectedVehicle) >> "displayName")], "PLAIN DOWN"]; 
	
	TAT_isOperationInProgress = false;
};