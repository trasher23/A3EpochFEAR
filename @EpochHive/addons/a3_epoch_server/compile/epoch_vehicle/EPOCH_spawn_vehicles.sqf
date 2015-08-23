private [
	"_spawnPositionSize","_spawnPositions","_type","_position","_range","_roads","_maxSpawnSize"
	,"_vehicleFound","_vehClass"
	,"_countAllowedVeh","_randomVehicleIndex","_randomVehicle","_velimit","_vehicleCount"
	,"_isShip"
	,"_spawnPositionIndex","_spawnPosition","_roadPosition"
	,"_dir","_vehObj","_config"
	,"_textureSelectionIndex","_selections","_colors","_textures","_color","_count"
	,"_marker"
];

_spawnPositionSize = [
	["FlatAreaCity",1],
	["FlatAreaCitySmall",1],
	["NameCity",2],
	["NameVillage",1],
	["NameCityCapital",4],
	["Airport",5]
];
if (worldName in ["Bornholm","Australia"]) then {
	_spawnPositionSize append [
		["NameLocal",2],
		["StrongpointArea",1],
		["VegetationBroadleaf",1],
		["VegetationFir",1],
		["ViewPoint",1]
	];
};

_allowedTypes = [];
{_allowedTypes pushBack (_x select 0)}forEach _spawnPositionSize;
_allCitys = (configfile >> "CfgWorlds" >> worldName >> "Names") call BIS_fnc_returnChildren;
_allCitysDync = _allCitys;
_increaseLimit = false;

{
	if (count EPOCH_VehicleSlots <= EPOCH_storedVehicleCount) exitWith{
		//diag_log format["DEBUG at limit %1 %2", count EPOCH_VehicleSlots, EPOCH_storedVehicleCount];
	};

	// diag_log format["DEBUG %1", EPOCH_allowedVehiclesList];

	// Find vehicle that is below limit
	_vehicleFound = false;
	_vehClass = "";
	while {!_vehicleFound} do {
		_countAllowedVeh = count EPOCH_allowedVehiclesList;
		if (_countAllowedVeh == 0) exitWith{};

		_randomVehicleIndex = floor(random(_countAllowedVeh));
		_randomVehicle = EPOCH_allowedVehiclesList select _randomVehicleIndex;
		_vehClass = _randomVehicle select 0;
		_velimit = _randomVehicle select 1;

		_vehicleCount = {typeOf _x == _vehClass} count vehicles;
		if (_vehicleCount >= _velimit) then {
			// remove and loop to select another
			EPOCH_allowedVehiclesList deleteAt _randomVehicleIndex;
		}
		else {
			// under limit
			if (_vehicleCount == (_velimit-1)) then {
				// if limit allows only one more, use and remove from array
				EPOCH_allowedVehiclesList deleteAt _randomVehicleIndex;
			};
			_vehicleFound = true;
		};
	};

	if (!_vehicleFound) exitWith {};

	_direction = random 360;
	_position = [];
	_getRandomPos = true;

	// get whitelisted positions
	_preferedPos = getArray(configFile >> "CfgEpoch" >> worldname >> "whitelistedVehiclePos" >> _vehClass);
	if !(_preferedPos isEqualTo []) then{
		_newPosition = _preferedPos select(floor(random(count _preferedPos)));
		if ((nearestObjects[(_newPosition select 0), ["LandVehicle", "Ship", "Air", "Tank"], 50]) isEqualTo []) then{
			_position = _newPosition select 0;
			_direction = _newPosition select 1;
			_getRandomPos = false;
		};
	};

	if (_getRandomPos) then{		
		_isShip = _vehClass isKindOf "Ship";
		if (_isShip || (_vehClass isKindOf "Air")) then{
			if (_isShip) then{
				_position = [epoch_centerMarkerPosition, 0, EPOCH_dynamicVehicleArea, 10, 0, 4000, 1] call BIS_fnc_findSafePos;
				_position = [_position, 0, 100, 10, 2, 4000, 0] call BIS_fnc_findSafePos;
			}
			else {
				_position = [epoch_centerMarkerPosition, 0, EPOCH_dynamicVehicleArea, 10, 0, 1000, 0] call BIS_fnc_findSafePos;
			};
		}
		else {
			if (_increaseLimit) then{
					{
						_spawnPositionSize set[_forEachIndex, [_x select 0, (_x select 1) + 1]];
					}forEach _spawnPositionSize;
					_allCitysDync = _allCitys;
			};
			_position = [];
			_start = diag_tickTime;
			waitUntil{
				if (_allCitysDync isEqualTo[]) exitWith{ _increaseLimit = true };
				_selectedCity = _allCitysDync select(floor random(count _allCitysDync));
				if (!isNil "_selectedCity") then{
					_find = _allowedTypes find(getText(_selectedCity >> "type"));
					if (_find > -1) then{
						_cityPos = getArray(_selectedCity >> "position");
						_range = getNumber(_selectedCity >> "radiusA") * 1.3;
						_nearBy = count(_cityPos nearEntities[["LandVehicle", "Ship", "Air", "Tank"], _range]);
						_limit = _spawnPositionSize select _find select 1;
						if (_limit > _nearBy) then{
							_roads = _cityPos nearRoads _range;
							if (_roads isEqualTo[]) then{
								_allCitysDync = _allCitysDync - [_selectedCity];
							}
							else {
								_road = _roads select(floor random(count _roads));
								if (!isNil "_road") then{
									_position = getPosATL _road;
									if (_nearBy + 1 == _limit) then{ _allCitysDync = _allCitysDync - [_selectedCity] };
								};
							};
						}
						else {
							_allCitysDync = _allCitysDync - [_selectedCity];
						};
					};
				};
				count _position == 3 || diag_tickTime - _start > 0.8
			};

			if (count _position == 3) then{ //Check if Pos is correct - if not => no spawnpoint found == all citys full
				_position deleteAt 2;
				_position = [_position, 0, 10, 10, 0, 2000, 0] call BIS_fnc_findSafePos;
			}
			else {
				_increaseLimit = true;
			}
		};
	};

	// only proceed if two params and is random or if postion is not random
	if ((count _position == 2 && _getRandomPos) || !_getRandomPos) then{

		if ((nearestObjects[_position, ["LandVehicle", "Ship", "Air", "Tank"], 50]) isEqualTo[]) then{

			if (_getRandomPos) then{
				_position set[2, 0];
			};

			//place vehicle
			_vehObj = createVehicle[_vehClass, _position, [], 0, "CAN_COLLIDE"];
			_vehObj call EPOCH_server_setVToken;

			if (typeName _direction == "ARRAY") then{
				_vehObj setVectorDirAndUp _direction;
			}
			else {
				_vehObj setdir _direction;
			};

			clearWeaponCargoGlobal    _vehObj;
			clearMagazineCargoGlobal  _vehObj;
			clearBackpackCargoGlobal  _vehObj;
			clearItemCargoGlobal	  _vehObj;

			_vehObj disableTIEquipment true;

			_vehObj lock true;

			if (surfaceIsWater _position && _getRandomPos) then{
				_vehObj setposASL _position;
			} else {
				_vehObj setposATL _position;
			};

			// randomize fuel TODO push min max to config
			_vehObj setFuel ((random 1 max 0.1) min 0.9);

			// get colors from config
			_config = (configFile >> "CfgVehicles" >> _vehClass >> "availableColors");
			if (isArray(_config)) then{

				_textureSelectionIndex = configFile >> "CfgVehicles" >> _vehClass >> "textureSelectionIndex";
				_selections = if (isArray(_textureSelectionIndex)) then{ getArray(_textureSelectionIndex) }
				else { [0] };

				_colors = getArray(_config);
				_textures = _colors select 0;
				_color = floor(random(count _textures));
				_count = (count _colors) - 1;
				{
					if (_count >= _forEachIndex) then{
						_textures = _colors select _forEachIndex;
					};
					//Probably better: setVariable instead setObjectTextureGlobal //Skaronator
					_vehObj setObjectTextureGlobal[_x, (_textures select _color)];
				} forEach _selections;

				_vehObj setVariable["VEHICLE_TEXTURE", _color];
			};

			// add random loots
			if (_vehClass isKindOf "Ship") then{
				[_vehObj, "VehicleBoat"] call EPOCH_serverLootObject;
			}
			else {
				[_vehObj, "Vehicle"] call EPOCH_serverLootObject;
			};

			// Add jack to all fresh spawns
			_vehObj addMagazineCargoGlobal["JackKit", 1];

			// Set slot used by vehicle
			_vehObj setVariable["VEHICLE_SLOT", _x, true];

			// Unlock from hive
			_vehLockHiveKey = format["%1:%2", (call EPOCH_fn_InstanceID), _x];
			["VehicleLock", _vehLockHiveKey] call EPOCH_server_hiveDEL;

			// SAVE VEHICLE
			_vehObj call EPOCH_server_save_vehicle;

			_vehObj call EPOCH_server_vehicleInit;

			if (EPOCH_DEBUG_VEH) then{
				_marker = createMarker[str(_position), _position];
				_marker setMarkerShape "ICON";
				_marker setMarkerType "mil_dot";
				_marker setMarkerText _vehClass;
			};

			// Remove from available slots
			EPOCH_VehicleSlots set[_forEachIndex, "REM"];

			addToRemainsCollector[_vehObj];
		};
	};

} forEach EPOCH_VehicleSlots;

EPOCH_VehicleSlots = EPOCH_VehicleSlots - ["REM"];

// make global so clients can use this to determine if a vehicle can be purchased
EPOCH_VehicleSlotCount = count EPOCH_VehicleSlots;
publicVariable "EPOCH_VehicleSlotCount";

EPOCH_allowedVehiclesList = nil;
true
