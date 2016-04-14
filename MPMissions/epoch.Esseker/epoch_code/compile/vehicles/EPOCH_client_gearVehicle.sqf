/*
	Author: Aaron Clark - EpochMod.com

    Contributors:

	Description:
	Open gear on cursorTarget function

    Licence:
    Arma Public License Share Alike (APL-SA) - https://www.bistudio.com/community/licenses/arma-public-license-share-alike

    Github:
    https://github.com/EpochModTeam/Epoch/tree/master/Sources/epoch_code/compile/vehicles/EPOCH_client_gearVehicle.sqf
*/
closeDialog 0;
if (!isNull cursorTarget) then {
	_vehicles = player nearEntities[["LandVehicle", "Ship", "Air", "Tank"], 6];
	if (cursorTarget in _vehicles) then {
		player action["Gear", cursorTarget];
	};
};
