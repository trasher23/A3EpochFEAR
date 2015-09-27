/*
	Spawn random wrecks around the map
*/

private["_airWrecks","_landWrecks","_spawnPositionSize","_allowedTypes","_allCitys","_allCitysDync","_cityPos","_range","_nearBy","_find","_limit","_numberOfWrecks","_direction","_position","_selectedCity","_roads","_road","_collide","_wreck","_wreckObj"];

_airWrecks = [
	"Land_Wreck_Heli_Attack_01_F",
	"Land_Wreck_Plane_Transport_01_F",
    "C130J_wreck_EP1",
	"Land_Wreck_Heli_Attack_02_F",
    "Mi8Wreck"
];

_landWrecks = [
	"Land_Wreck_HMMWV_F",
    "BMP2Wreck",
    "Land_Wreck_BMP2_F",
    "BRDMWreck",
    "Land_Wreck_BRDM2_F",
    "LADAWreck",
    "Land_Wreck_Skodovka_F",
    "Land_Wreck_CarDismantled_F",
    "Land_Wreck_Truck_F",
    "Land_Wreck_Car2_F",
    "Land_Wreck_Car_F",
    "Land_Wreck_Car3_F",
    "HMMWVWreck",
    "Land_Wreck_Hunter_F",
    "hiluxWreck",
    "Land_Wreck_Offroad2_F",
    "Land_Wreck_Offroad_F",
    "datsun01Wreck",
    "datsun02Wreck",
    "Land_Wreck_UAZ_F",
    "Land_Wreck_Ural_F",
    "SKODAWreck",
    "Land_Wreck_Slammer_hull_F",
    "Land_Wreck_Slammer_F",
    "Land_Wreck_Slammer_turret_F",
    "T72Wreck",
    "T72WreckTurret",
    "Land_Wreck_T72_hull_F",
    "Land_Wreck_T72_turret_F",
    "Land_Wreck_Truck_dropside_F",
    "UAZWreck",
    "UralWreck",
    "Land_Wreck_Van_F"
];

_spawnPositionSize = [
      ["FlatAreaCity",1],
      ["FlatAreaCitySmall",1],
      ["NameCity",2],
      ["NameVillage",1],
      ["NameCityCapital",4],
      ["Airport",5]
];

_allowedTypes = [];
{
  _allowedTypes pushBack (_x select 0)
}forEach _spawnPositionSize;

_allCitys = "getText(_x >> 'type') in _allowedTypes" configClasses (configfile >> "CfgWorlds" >> worldName >> "Names");
_allCitysDync = [];

{
    _cityPos = getArray(_x >> "position");
    _range = getNumber(_x >> "radiusA") * 1.3;
    _nearBy = count(_cityPos nearEntities[["LandVehicle", "Ship", "Air", "Tank"], _range]);
    _find = _allowedTypes find (getText(_x >> "type"));
    if (_find > -1) then{
        _limit = _spawnPositionSize select _find select 1;
        if (_limit > _nearBy) then{
          _allCitysDync pushBack _x;
        };
    };
} forEach _allCitys;

_getRandomPos = false;
_numberOfWrecks = 50;
for "_i" from 1 to _numberOfWrecks do {
	
	_direction = random 360;
	_position = [0,0,0];

	if (_allCitysDync isEqualTo []) then {
		_position = [MapCentre, 0, MapRadius, 10, 0, 1000, 0] call BIS_fnc_findSafePos;
	} else {
		_selectedCity = _allCitysDync deleteAt (floor random(count _allCitysDync));
		_cityPos = getArray(_selectedCity >> "position");
		_range = getNumber(_selectedCity >> "radiusA") * 1.3;
		
		_roads = _cityPos nearRoads _range;
		if !(_roads isEqualTo []) then {
			_road = _roads select(floor random(count _roads));
			_position = getPosATL _road;
			_position deleteAt 2;
		};
	};

	if ((count _position == 2 && _getRandomPos) || !_getRandomPos) then {
		_collide = "CAN_COLLIDE";
		
		if (_getRandomPos) then {
			_collide = "NONE";
			_position set[2, 0];
			if (surfaceIsWater _position) then {
				_position = ASLToATL _position;
			};
		};
		
		_wreck = _landWrecks call BIS_fnc_selectRandom;
		_wreckObj = createVehicle [_wreck, _position, [], 0, _collide];
		
		diag_log format["[FEAR] wreck %1 created at %2", _wreck, _position];
	};
};

