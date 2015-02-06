private ["_unitGroup","_tooClose","_wpSelect"];
_unitGroup = _this select 0;

_tooClose = true;
while {_tooClose} do {
	_wpSelect = (A3EAI_locations call BIS_fnc_selectRandom2) select 1;
	if (((waypointPosition [_unitGroup,0]) distance _wpSelect) > 300) then {
		_tooClose = false;
	} else {
		uiSleep 0.1;
	};
};
_wpSelect = [_wpSelect,50+(random 900),(random 360),1] call SHK_pos;
[_unitGroup,0] setWPPos _wpSelect; 
[_unitGroup,1] setWPPos _wpSelect;
//if ((waypointType [_unitGroup,1]) isEqualTo "MOVE") then {
if (_unitGroup getVariable ["SAD_Ready",true]) then {
	if (0.275 call A3EAI_chance) then {
		//[_unitGroup,1] setWaypointType "SAD";
		_unitGroup setVariable ["SAD_Ready",false];
		[_unitGroup,1] setWaypointTimeout [10,15,20];
		//_unitGroup setVariable ["DetectPlayersWide",true];
	};
} else {
	//[_unitGroup,1] setWaypointType "MOVE";
	[_unitGroup,1] setWaypointTimeout [3,6,9];
};

_unitGroup setCurrentWaypoint [_unitGroup,0];
(vehicle (leader _unitGroup)) flyInHeight (100 + (random 25));
