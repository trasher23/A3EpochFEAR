/*
	DynamicLocationInvasion by Vampire, rewritten by IT07
*/
private ["_settings","_grpCount","_groupUnits","_playerCheck","_loc","_hasPlayers","_marker","_spawned","_grpArr","_unitArr","_done","_boxes","_box","_chute","_colors","_lightType","_light","_smoke"];

// Define _settings
_settings = [["VEMFconfig","DLI"],["maxInvasions","groupCount","groupUnits","distanceCheck","distanceTooClose","distanceMaxPrefered","playerCheck","crateAltitude"]] call VEMF_fnc_getSetting;
_maxInvasions = _settings select 0;
if isNil"VEMF_invasCount" then { VEMF_invasCount = 0; };
if (VEMF_invasCount isEqualTo _maxInvasions) exitWith
{
	VEMF_invasCount = VEMF_invasCount - 1;
	VEMF_missionCount = VEMF_missionCount - 1;
};
_grpCount = _settings select 1;
_groupUnits = _settings select 2;
_range = _settings select 3;
_tooClose = _settings select 4;
_maxPref = _settings select 5;
_playerCheck = _settings select 6;
_crateAltitude = _settings select 7;

VEMF_invasCount = VEMF_invasCount + 1;

// Find A Town to Invade
_loc = ["loc", false, position (playableUnits select floor random count playableUnits), _range, _tooClose, _maxPref, _playerCheck] call VEMF_fnc_findPos;
if not(typeName _loc isEqualTo "ARRAY") exitWith
{
	VEMF_invasCount = VEMF_invasCount - 1;
	VEMF_missionCount = VEMF_missionCount - 1;
	["DLI", 0, "Unable to find location to invade. Canceling this mission."] call VEMF_fnc_log;
};

["DLI", 1, format["Invading %1...", _loc select 0]] call VEMF_fnc_log;
// Send message to all players, if they have a radio
[["Activity sighted...", "A CDC kill team has been spotted", format["Location: %1 @ %2", _loc select 0, mapGridPosition (_loc select 1)],""],""] call FEARBroadcast;

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
	["DLI", 1, format["Mission timed out..."]] call VEMF_fnc_log;
	VEMF_missionCount = VEMF_missionCount -1;
	deleteMarker _marker;
};

// Player is Near, so Spawn the Units
_spawned = [_loc select 1, _loc select 0, _grpCount, _groupUnits] call VEMF_fnc_spawnAI;
if (typeName _spawned isEqualTo "BOOL") exitWith
{
	VEMF_invasCount = VEMF_invasCount - 1;
	VEMF_missionCount = VEMF_missionCount - 1;
	["DLI | fn_spawnAI", 0, "Returned invalid data. Exiting..."] call VEMF_fnc_log;
	deleteMarker _marker;
};

// Wait for Mission Completion
_done = [_loc select 1, _spawned, _playerCheck] call VEMF_fnc_waitForMissionDone;
_usedLocs = uiNamespace getVariable "vemfUsedLocs";
_index = _usedLocs find _loc;
_usedLocs deleteAt _index;
deleteMarker _marker;
if not(_done) exitWith
{
	VEMF_invasCount = VEMF_invasCount - 1;
	VEMF_missionCount = VEMF_missionCount - 1;
	["DLI", 0, "Something went wrong while waiting for missionDone. Exiting..."] call VEMF_fnc_log;
};

// Broadcast
//_completeMsg = [["Liberated!", "Check for supplies...", format["Location: %1 @ %2", _loc select 0, mapGridPosition (_loc select 1)], ""], ""] call VEMF_fnc_broadCast;
// send as system message instead
_completeMsg = [[format["%1 liberated! Check for supplies...", _loc select 0],"","",""], ""] call VEMF_fnc_broadCast;
if not(_completeMsg) then
{
	["DLI", 0, "fnc_broadCast returned FALSE after sending completion message..."] call VEMF_fnc_log;
};
// Choose a box
_boxes = ["I_CargoNet_01_ammo_F","O_CargoNet_01_ammo_F","B_CargoNet_01_ammo_F","I_supplyCrate_F","Box_East_AmmoVeh_F","Box_NATO_AmmoVeh_F"];
_box = _boxes call BIS_fnc_selectRandom;
//_cratePos = (_loc select 1) findEmptyPosition [0,600, _chute];
_cratePos = [_loc select 1, 0, 100, 0, 0, 300, 0] call bis_fnc_findSafePos;
if (count _cratePos isEqualTo 0 OR _cratePos isEqualTo [0,0,0] OR (mapGridPosition _cratePos) isEqualTo "108105") exitWith
{
	VEMF_invasCount = VEMF_invasCount - 1;
	VEMF_missionCount = VEMF_missionCount - 1;
	["DLI", 0, format["No pos found for crate! at %1", _loc select 1]] call VEMF_fnc_log;
};

_chute = createVehicle ["B_Parachute_02_F", _cratePos, [], 0, "FLY"];
_chute flyInHeight _crateAltitude;
_chute call EPOCH_server_setVToken;
_crate = createVehicle [_box, getPos _chute, [], 0, "NONE"];
 _crate attachTo [_chute, [0,0,0]];
_crate allowDamage false;
 ["DLI", 1, format ["Crate parachuted At: %1 / Grid: %2", (getPosATL _crate), mapGridPosition (getPosATL _crate)]] call VEMF_fnc_log;

// Mark the crate
switch (true) do
{
	// If night, attach a chemlight
	case (dayTime < 5 or dayTime > 19):
	{
		_colors = ["Chemlight_green","Chemlight_red","Chemlight_yellow","Chemlight_blue"];
		_lightType = _colors select floor random count _colors;
		_light = _lightType createVehicle (position _crate);
		_light attachTo [_chute,[0,0,0]];
	};
	// If day, attach smoke
	case (dayTime > 5 or dayTime < 19):
	{
		_colors = ["SmokeShell","SmokeShellBlue","SmokeShellGreen","SmokeShellOrange","SmokeShellRed","SmokeShellYellow"];
		_rndmColor = _colors select floor random count _colors;
		_smoke = createVehicle [_rndmColor, getPos _crate, [], 0, "CAN_COLLIDE"];
		_smoke attachTo [_chute,[0,0,0]];
	};
};

waitUntil { uiSleep 1; (getPos _crate select 2) < 4; };
detach _crate;
_loaded = [_crate] call VEMF_fnc_loadLoot;
if _loaded then { ["DLI", 1, "Loot loaded successfully into crate"] call VEMF_fnc_log };

VEMFDynInv = nil;
VEMF_invasCount = VEMF_invasCount - 1;
VEMF_missionCount = VEMF_missionCount - 1;
