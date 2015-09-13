#define PLAYER_UNITS "Epoch_Male_F","Epoch_Female_F"
#define LOOT_HOLDER_CLASS "WH_Loot"

private ["_unitGroup","_searchRange","_searchType","_searchPoints"];
_unitGroup = _this select 0;

if ((count (waypoints _unitGroup)) > 9) exitWith {};

_searchType = floor (random 2);

_searchPoints = call {
	if (_searchType isEqualTo 0) exitWith {
		(leader _unitGroup) nearObjects [LOOT_HOLDER_CLASS,100]
	};
	if (_searchType isEqualTo 1) exitWith {
		(leader _unitGroup) nearEntities [[PLAYER_UNITS,"LandVehicle"],100]
	};
	[]
};

{
	if ((count (waypoints _unitGroup)) > 9) exitWith {};
	_waypoint = [_unitGroup,getPosATL _x] call A3EAI_addTemporaryWaypoint;
} forEach _searchPoints;

true