/*
	DynamicLocationInvasion by Vampire, rewritten by IT07
*/
private ["_loc","_nearPlyr","_grpCnt","_housePos","_sqdPos","_msg","_alert","_winMsg","_crate","_cratePos","_wait","_noPlayers","_objs","_msg"];

diag_log "[VEMF] Mission 'Dynamic Location Invasion' started!";

// Define settings
_grpCount = (["groupCount"] call VEMF_fnc_getSetting) select 0;
_groupUnits = (["groupUnits"] call VEMF_fnc_getSetting) select 0;
_playerCheck = (["playerCheck"] call VEMF_fnc_getSetting) select 0;

// Find A Town to Invade
diag_log "[VEMF] DynamicLocationInvasion: Trying to find an empty location...";
while {true} do
{
	_loc = [playableUnits select floor random count playableUnits] call VEMF_fnc_findLoc;
	_hasPlayers = [_loc select 1, _playerCheck] call VEMF_fnc_findPlayers;
	if not(_hasPlayers) exitWith { diag_log format["[VEMF] DynamicLocationInvasion: invading %1...", text (_loc select 0)]; };
	// Player in town. Loop after uiSleep done
	uiSleep 2;
};

// Send message to all players
//["Activity sighted...", _msg, _loc select 0, mapGridPosition (_loc select 1), ""] call VEMF_fnc_broadCast;
_msg = format ["A CDC kill team has been spotted in %1", _loc select 0];
_msg = ["Activity sighted...",_msg];
[_msg] call FEARBroadcast;

// Create/place the marker
_marker = createMarker [format["VEMF_DynaLocInva_ID%1", floor random 9000], (_loc select 1)];
_marker setMarkerShape "ICON";
_marker setMarkerType "b_inf";
_marker setMarkerColor "ColorEAST";
_marker setMarkerText format[" %1 CDC kill team!", _loc select 0];

// Usage: COORDS, Radius
_playerNear = [_loc select 1, 800, _marker, _playerCheck] call VEMF_fnc_waitForPlayers;

if (_playerNear isEqualTo "TIMEOUT") exitWith
{
	diag_log format ["[VEMF] DynamicLocationInvasion: Mission timed out, no players near!"];
	VEMF_missionCount = VEMF_missionCount -1;
	deleteMarker _marker;
};

// Player is Near, so Spawn the Units
_spawned = [(_loc select 1),_grpCount,_groupUnits] call VEMF_fnc_spawnAI;
if (typeName _spawned isEqualTo "BOOL") exitWith
{
	diag_log "[VEMF] DynamicLocationInvasion: ERROR, fn_spawnAI returned invalid data. Exiting...";
	deleteMarker _marker;
	//["Mission done fucked up!", "fn_spawnAI FAILED!", _loc select 0, mapGridPosition (_loc select 1), ""] call VEMF_fnc_broadCast;
	_msg = ["Mission done fucked up!", "fn_spawnAI FAILED!"];
	[_msg] call FEARBroadcast;
};
_grpArr = _spawned select 1;
_unitArr = _spawned select 2;


// Wait for Mission Completion
_done = [_loc select 1, _grpArr, _unitArr, _playerCheck] call VEMF_fnc_waitForMissionDone;
deleteMarker _marker;
if not(_done) exitWith
{
	diag_log "[VEMF] DynamicLocationInvasion: something went wrong while waiting for missionDone!";
};

// Rewards
//[_msg, "Check for supplies...", _loc select 0, mapGridPosition (_loc select 1), ""] call VEMF_fnc_broadCast;
_msg = format ["%1 liberated!", _loc select 0];
_msg = [_msg,"Check for supplies..."];
[_msg] call FEARBroadcast;

// Choose a box
_boxes = ["I_CargoNet_01_ammo_F","O_CargoNet_01_ammo_F","B_CargoNet_01_ammo_F","I_supplyCrate_F","Box_East_AmmoVeh_F","Box_NATO_AmmoVeh_F"];
_box = _boxes call BIS_fnc_selectRandom;
_chute = "B_Parachute_02_F";
//_cratePos = (_loc select 1) findEmptyPosition [0,600, _chute];
_cratePos = [_loc select 1, 0, 20, 1, 0, 100, 0] call bis_fnc_findSafePos;
if (count _cratePos isEqualTo 0) exitWith
{
	diag_log format["[VEMF] DynamicLocationInvasion: ERROR no pos found for crate! at %1", _loc select 1];
};

_veh = createVehicle [_chute, _cratePos, [], 0, "FLY"];
_veh flyInHeight 400;
_veh call EPOCH_server_setVToken;
_crate = createVehicle [_box, getPos _veh, [], 0, "NONE"];
 _crate attachTo [_veh, [0,0,0]];
_crate allowDamage false;
 diag_log format ["[VEMF] DynamicLocationInvasion: Crate parachuted At: %1 / Grid: %2", (getPosATL _crate), mapGridPosition (getPosATL _crate)];

// Mark the crate
switch (true) do
{
	// If night, pop a flair
	case (dayTime < 5 or dayTime > 19):
	{
		_colors = ["F_20mm_Red","F_20mm_Green","F_20mm_White","F_20mm_Yellow"];
		_rndmColor = _colors select floor random count _colors;
		_alt = floor random 100 + 150;
		_flair = _rndmColor createVehicle [(getPos _crate) select 0, (getPos _crate) select 1, _alt];
		_flair setVelocity [0,0,-1];
	};
	// If day, pop smoke
	case (dayTime > 5 or dayTime < 19):
	{
		_colors = ["SmokeShell","SmokeShellBlue","SmokeShellGreen","SmokeShellOrange","SmokeShellRed","SmokeShellYellow"];
		_rndmColor = _colors select floor random count _colors;
		_smoke = createVehicle [_rndmColor, getPos _crate, [], 0, "CAN_COLLIDE"];
		_smoke attachTo [_crate,[0,0,1]];
	};
};

waitUntil { uiSleep 0.2; (getPos _crate select 2) < 2; };
detach _crate;
[_crate] spawn VEMF_fnc_loadLoot;
_crate setVariable ["VEMFScenery", true];
VEMFDynInv = nil;
VEMF_missionCount = VEMF_missionCount - 1;
