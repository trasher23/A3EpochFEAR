_ferrisPosition = [epoch_centerMarkerPosition, 0, EPOCH_dynamicVehicleArea, 10, 0, 4000, 0] call BIS_fnc_findSafePos;
if ((count _ferrisPosition) == 2) then{
	_item = createVehicle["ferrisWheel_EPOCH", _ferrisPosition, [], 0.0, "CAN_COLLIDE"];

	{
		_item = createVehicle[_x, _ferrisPosition, [], 80, "NONE"];
		sleep 1;
	} forEach["Carnival_Tent", "Land_Slide_F", "Carnival_Tent", "Land_Carousel_01_F", "Carnival_Tent", "Carnival_Tent"];

	if (EPOCH_showShippingContainers) then{
		_marker = createMarker[str(_ferrisPosition), _ferrisPosition];
		_marker setMarkerShape "ICON";
		_marker setMarkerType "mil_dot";
		// _marker setMarkerText "Ferris";
		_marker setMarkerColor "ColorOrange";
	};
};