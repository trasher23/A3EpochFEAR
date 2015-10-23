/*
	MilitiaInvasions by IT07, original written by TheVampire
*/

private["_deleteQuarantineLoc"];

_deleteQuarantineLoc = {
	private "_loc";
	_loc  = _this select 0;
	_index = FEARQuarantineLocs find _loc;
	if (_index > -1) then
	{
		FEARQuarantineLocs deleteAt _index;
		publicVariableServer "FEARQuarantineLocs";
	};
};

private ["_settings","_grpCount","_groupUnits","_playerCheck","_loc","_hasPlayers","_spawned","_grpArr","_unitArr","_done","_boxes","_box","_chute","_colors","_lightType","_light","_smoke"];

// Define _settings
_settings = [["MI"],["maxInvasions","groupCount","groupUnits","distanceCheck","distanceTooClose","distanceMaxPrefered","playerCheck","crateAltitude","useMarker","parachuteCrate","crateVisualMarker","crateMapMarker","useAnnouncements"]] call VEMFr_fnc_getSetting;
_maxInvasions = _settings select 0;
if isNil"VEMFr_invasCount" then
{
	VEMFr_invasCount = 0;
};
VEMFr_invasCount = VEMFr_invasCount + 1;
if (VEMFr_invasCount <= _maxInvasions) then
{
	_grpCount = _settings select 1;
	_groupUnits = _settings select 2;
	_range = _settings select 3;
	_tooClose = _settings select 4;
	_maxPref = _settings select 5;
	_playerCheck = _settings select 6;
	_crateAltitude = _settings select 7;
	_useMissionMarker = _settings select 8;
	_useChute = _settings select 9;
	_crateVisualMarker = _settings select 10;
	_crateMapMarker = _settings select 11;
	_useAnnouncements = _settings select 12;

	// Find A Town to Invade
	_loc = ["loc", false, position (allPlayers call VEMFr_fnc_random), _range, _tooClose, _maxPref, _playerCheck] call VEMFr_fnc_findPos;
	if (typeName _loc isEqualTo "ARRAY") then
	{
		_locName = _loc select 0;
		// Setup quarantine parameter
		_loc spawn FEARQuarantineZone;
		if (_locName isEqualTo "") then { _locName = "Area" };
		["MilitiaInvasions", 1, format["Invading %1...", _locName]] call VEMFr_fnc_log;

		// Send message to all players
		if (_useAnnouncements isEqualTo 1) then
		{
			//_newMissionMsg = [format["Militia have invaded %1%2 near %3", if (_locName isEqualTo "Area") then {"an " } else {""}, _locName, mapGridPosition (_loc select 1)], ""] spawn VEMFr_fnc_broadCast;
			_newMissionMsg = [format["Remnants of the CDC have quarantined %1%2", if (_locName isEqualTo "Area") then {"an " } else {""},_locName], ""] call FEARBroadcast;
		};
		private["_marker"];
		if (_useMissionMarker isEqualTo 1) then
		{ // Create/place the marker if enabled
			_marker = createMarker [format["VEMF_DynaLocInva_ID%1", random 9000], (_loc select 1)];
			_marker setMarkerShape "ICON";
			_marker setMarkerType "o_unknown";
			_marker setMarkerColor "ColorBlack";
		};
		// Usage: POSITION, Radius
		_playerNear = [_loc select 1, 800] call VEMFr_fnc_waitForPlayers;
		if _playerNear then
		{
			// Player is Near, so Spawn the Units
			_spawned = [_loc select 1, _locName, ((_grpCount select 0) + round random ((_grpCount select 1) - (_grpCount select 0))), ((_groupUnits select 0) + round random ((_groupUnits select 1) - (_groupUnits select 0)))] call VEMFr_fnc_spawnAI;
			if (count (_spawned select 0) > 0) then
			{
				private ["_cal50s"];
				if (count (_spawned select 1) > 0) then
				{
					_cal50s = _spawned select 1;
				};
				// Place mines if enabled
				private ["_minesPlaced","_placeMines"];
				_placeMines = [[["MI"],["placeMines"]] call VEMFr_fnc_getSetting, 0, [0]] call BIS_fnc_param;
				if (_placeMines isEqualTo 1) then
				{
					_minesPlaced = [[_loc select 1, 5, 100] call VEMFr_fnc_placeMines, 0, [], [[]]] call BIS_fnc_param;
					if (count _minesPlaced > 0) then
					{
						["MilitiaInvasions", 1, format["Successfully placed mines at %1", _locName]] call VEMFr_fnc_log;
					};
					if (count _minesPlaced isEqualto 0) then
					{
						["MilitiaInvasions", 0, format["Failed to place mines at %1", _locName]] call VEMFr_fnc_log;
						_minesPlaced = nil;
					};
				};

				// Wait for Mission Completion
				_done = [_loc select 1, _spawned select 0, _playerCheck] call VEMFr_fnc_waitForMissionDone;
				_usedLocs = uiNamespace getVariable "VEMFrUsedLocs";
				_index = _usedLocs find [_loc select 0, _loc select 1];
				if (_index > -1) then
				{
					_usedLocs deleteAt _index;
				};
				// Delete from quarantine location array
				[_loc select 1] call _deleteQuarantineLoc;
				if _done then
				{
					// Broadcast
					if (_useAnnouncements isEqualTo 1) then
					{
						//_completeMsg = [format["Militia invasion of %1 @ %2 defeated!", _locName, mapGridPosition (_loc select 1)], ""] spawn VEMFr_fnc_broadCast;
						_completeMsg = [format["The CDC at %1 have been defeated!",_locName],""] call FEARBroadcast;
					};
					// Deal with the 50s
					if not isNil"_cal50s" then
					{
						_keep50s = ([["MI"],["keep50s"]] call VEMFr_fnc_getSetting) select 0;
						if (_keep50s isEqualTo -1) then
						{
							_cal50delMode = ([["MI"],["cal50delMode"]] call VEMFr_fnc_getSetting) select 0;
							{
								if (_cal50delMode isEqualTo 1) then
								{
									deleteVehicle _x;
								};
								if (_cal50delMode isEqualTo 2) then
								{
									_x setDamage 1;
								};
							} forEach _cal50s;
						};
					};
					// Choose a box
					_boxes = [["MI"],["crateTypes"]] call VEMFr_fnc_getSetting;
					_box = (_boxes select 0) call BIS_fnc_selectRandom;
					_pos = [_loc select 1, 0, 100, 0, 0, 300, 0] call bis_fnc_findSafePos;
					private ["_crate"];
					if (_useChute isEqualTo 1) then
					{
						_chute = createVehicle ["I_Parachute_02_F", _pos, [], 0, "FLY"];
						_chute setPos [getPos _chute select 0, getPos _chute select 1, _crateAltitude];
						_chute call EPOCH_server_setVToken;
						_chute enableSimulationGlobal true;

						if not isNull _chute then
						{
							_crate = createVehicle [_box, getPos _chute, [], 0, "NONE"];
							_crate enableSimulationGlobal true;
							_crate allowDamage false;
							_crate attachTo [_chute, [0,0,0]];
							["MilitiaInvasions", 1, format ["Crate parachuted At: %1 / Grid: %2", (getPosATL _crate), mapGridPosition (getPosATL _crate)]] call VEMFr_fnc_log;
							_lootLoaded = [_crate] call VEMFr_fnc_loadLoot;
							if _lootLoaded then { ["MilitiaInvasions", 1, "Loot loaded successfully into parachuting crate"] call VEMFr_fnc_log };
						};
					};
					if (_useChute isEqualTo -1) then // If parachute is disabled
					{
						_crate = createVehicle [_box, _pos, [], 0, "NONE"];
						_crate allowDamage false;
						_lootLoaded = [_crate] call VEMFr_fnc_loadLoot;
						if _lootLoaded then { ["MilitiaInvasions", 1, "Loot loaded successfully into crate"] call VEMFr_fnc_log };
					};
					if (_crateVisualMarker isEqualTo 1) then
					{
						// If night, attach a chemlight
						if (dayTime < 5 OR dayTime > 19) then
						{
							_colors = ([["MI"],["flairTypes"]] call VEMFr_fnc_getSetting) select 0;
							_lightType = _colors select floor random count _colors;
							_light = _lightType createVehicle (position _crate);
							_light attachTo [_crate,[0,0,0]];
						};
						// If day, attach smoke
						if (dayTime > 5 OR dayTime < 19) then
						{
							_colors = ([["MI"],["smokeTypes"]] call VEMFr_fnc_getSetting) select 0;
							_rndmColor = _colors select floor random count _colors;
							_smoke = createVehicle [_rndmColor, getPos _crate, [], 0, "CAN_COLLIDE"];
							_smoke attachTo [_crate,[0,0,0]];
						};
					};
					if (_useChute isEqualTo 1) then
					{
						waitUntil { uiSleep 1; (((getPos _crate) select 2) < 7) };
						detach _crate;
					};
					if not isNil"_marker" then
					{
						deleteMarker _marker
					};
					// Put a marker on the crate if enabled
					if not isNull _crate then
					{
						if not ([getPos _crate, 2] call VEMFr_fnc_checkPlayerPresence) then
						{
							_addMarker = [[["MI"],["crateMapMarker"]] call VEMFr_fnc_getSetting, 0, 1, [0]] call BIS_fnc_param;
							if (_addMarker isEqualTo 1) then
							{
								private ["_crateMarker"];
								_crateMarker = createMarker [format["VEMF_lootCrate_ID%1", random 9000], position _crate];
								_crateMarker setMarkerShape "ICON";
								_crateMarker setMarkerType "mil_box";
								_crateMarker setMarkerColor "colorBlack";
								_crateMarker setMarkerText " Loot";
								[_crate, _crateMarker] spawn
								{
									_crate = _this select 0;
									_crateMarker = _this select 1;
									waitUntil { uiSleep 4; [getPos _crate, 2] call VEMFr_fnc_checkPlayerPresence };
									deleteMarker _crateMarker;
								};
							};
						};
					};
					// Explode or remove the mines
					if not isNil"_minesPlaced" then
					{
						private ["_cleanMines"];
						_cleanMines = [[["MI"],["cleanMines"]] call VEMFr_fnc_getSetting, 0, -1, [0]] call BIS_fnc_param;
						if not(_cleanMines isEqualTo -1) then
						{
							if (_cleanMines isEqualTo 2) then
							{
								{
									if not isNull _x then
									{
										_x setDamage 1;
										uiSleep (2 + round random 2);
									};
								} forEach _minesPlaced;
								["MilitiaInvasions", 1, format["Successfully exploded all %1 mines at %2", count _minesPlaced, _locName]] call VEMFr_fnc_log;
								_minesPlaced = nil;
							};
							if (_cleanMines isEqualTo 1) then
							{
								{
									if not isNull _x then
									{
										deleteVehicle _x;
									};
								} forEach _minesPlaced;
								["MilitiaInvasions", 1, format["Successfully deleted all %1 mines at %2", count _minesPlaced, _locName]] call VEMFr_fnc_log;
								_minesPlaced = nil;
							};
						};
						if (_cleanMines isEqualTo -1) then
						{
							["MilitiaInvasions", 0, format["Invalid mines setting! Please check the config.cpp"]] call VEMFr_fnc_log;
						};
					};
					// Mission script is done.
					VEMFr_invasCount = VEMFr_invasCount - 1;
					VEMFr_missionCount = VEMFr_missionCount - 1;
				};
				if not _done then
				{ // This one failed.
					["MilitiaInvasions", 0, format["Mission failed. Waiting for completion went wrong. ERROR: %1", _done]] call VEMFr_fnc_log;
					VEMFr_invasCount = VEMFr_invasCount - 1;
					VEMFr_missionCount = VEMFr_missionCount - 1;
				};
			};
			if isNil"_spawned" then
			{
				["MilitiaInvasions", 0, format["Failed to spawn AI in %1", _locName]] call VEMFr_fnc_log;
				if not isNil"_marker" then
				{
					deleteMarker _marker
				};
				VEMFr_invasCount = VEMFr_invasCount - 1;
				VEMFr_missionCount = VEMFr_missionCount - 1;
				// Delete from quarantine location array
				[_loc select 1] call _deleteQuarantineLoc;
			};
		};
		if not _playerNear then
		{
			["MilitiaInvasions", 1, format["Invasion of %1 timed out.", _locName]] call VEMFr_fnc_log;
			if not isNil"_marker" then
			{
				deleteMarker _marker
			};
			_usedLocs = uiNamespace getVariable "VEMFrUsedLocs";
			_index = _usedLocs find _loc;
			if (_index > -1) then
			{
				_usedLocs deleteAt _index;
			};
			VEMFr_invasCount = VEMFr_invasCount - 1;
			VEMFr_missionCount = VEMFr_missionCount - 1;
			// Delete from quarantine location array
			[_loc select 1] call _deleteQuarantineLoc;
		};
	};
	if not(typeName _loc isEqualTo "ARRAY") then
	{
		VEMFr_invasCount = VEMFr_invasCount - 1;
		VEMFr_missionCount = VEMFr_missionCount - 1;
	};
};
if (VEMFr_invasCount >= _maxInvasions) then
{
	VEMFr_invasCount = VEMFr_invasCount - 1;
	VEMFr_missionCount = VEMFr_missionCount - 1;
};
