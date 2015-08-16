private ["_unitGroup", "_vehicle", "_isInfantry", "_nearPlayers", "_leaderPos", "_newPosEmpty","_unitType","_vehicleType","_leader"];

_unitGroup = _this select 0;

_vehicle = (_unitGroup getVariable ["assignedVehicle",objNull]);
_isInfantry = (isNull _vehicle);
_unitType = _unitGroup getVariable ["unitType",""];

_leaderPos = getPosATL (leader _unitGroup);

if (_isInfantry) then {
	_newPosEmpty = _leaderPos findEmptyPosition [0.5,30,"Land_Coil_F"];

	if !(_newPosEmpty isEqualTo []) then {
		_newPosEmpty = _newPosEmpty isFlatEmpty [0,0,0.75,5,0,false,objNull];
	};

	if (_newPosEmpty isEqualTo []) then {
		_newPosEmpty = [_leaderPos,10 + random(25),random(360),0,[0,0],[25,"Land_Coil_F"]] call SHK_pos;
	};

	_newPosEmpty set [2,0];
	{
		_x setPosATL _newPosEmpty;
		_x setVelocity [0,0,0.25];
	} forEach (units _unitGroup);
	if (A3EAI_debugLevel > 1) then {diag_log format ["A3EAI Debug: Relocated stuck group %1 (%2) to new location %3m away.",_unitGroup,(_unitGroup getVariable ["unitType","unknown"]),(_leaderPos distance _newPosEmpty)];};
} else {
	_newPosEmpty = [0,0,0];
	if (_unitType in ["land","ugv"]) then {
		_keepLooking = true;
		_vehicleType = (typeOf _vehicle);
		while {_keepLooking} do {
			_newPosEmpty = [(getMarkerPos "A3EAI_centerMarker"),300 + random((getMarkerSize "A3EAI_centerMarker") select 0),random(360),0,[2,750],[25,_vehicleType]] call SHK_pos;
			if ((count _newPosEmpty) > 1) then {
				if (({isPlayer _x} count (_newPosEmpty nearEntities [["Epoch_Male_F","Epoch_Female_F","AllVehicles"], 300]) isEqualTo 0) && {((_newPosEmpty nearObjects ["PlotPole_EPOCH",300]) isEqualTo [])}) then {
					_keepLooking = false;
				};
			} else {
				if (A3EAI_debugLevel > 1) then {diag_log format ["A3EAI Debug: Unable to find road position to relocate AI group %1 %2. Retrying in 15 seconds.",_unitGroup,_vehicleType]};
				uiSleep 15;
			};
		};
	} else {
		_newPosEmpty = [_leaderPos,10 + random(25),random(360),0,[1,300],[25,(typeOf _vehicle)]] call SHK_pos;
	};
	_leader = (leader _unitGroup);
	if ((_leader distance (_leader findNearestEnemy _vehicle)) > 500) then {
		_vehicle setPosATL _newPosEmpty;
		_vehicle setVelocity [0,0,0.25];
		{
			if (((vehicle _x) isEqualTo _x) && {(_x distance _vehicle) > 100}) then {
				_newUnitPos = [_vehicle,25,random(360),0,[0,0],[25,"i_survivor_F"]] call SHK_pos;
				_x setPosATL _newUnitPos;
				_x setVelocity [0,0,0.25];
			};
		} forEach (units _unitGroup);
		if (A3EAI_debugLevel > 1) then {diag_log format ["A3EAI Debug: Relocated stuck group %1 (%2) to new location %3m away.",_unitGroup,(_unitGroup getVariable ["unitType","unknown"]),(_leaderPos distance _newPosEmpty)];};
	} else {
		if (A3EAI_debugLevel > 1) then {diag_log format ["A3EAI Debug: Unable to relocate stuck group %1 (%2) due to nearby enemy presence.",_unitGroup,(_unitGroup getVariable ["unitType","unknown"])];};
	};
};

true