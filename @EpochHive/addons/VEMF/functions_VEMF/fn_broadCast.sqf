/*
	Author: VAMPIRE, rebooted by IT07

	Description:
	will alert players

	Returns:
	nothing
*/

_title = _this select 0;
_type = _this select 1;
_location = _this select 2;
_coords = _this select 3;
_task = _this select 4;

VEMFChatMsg = [_title, _type, _location, _coords, _task];
{
	if (isPlayer _x) then
	{
		(owner _x) publicVariableClient "VEMFChatMsg";
	};
	uiSleep 0.05;
} forEach playableUnits;