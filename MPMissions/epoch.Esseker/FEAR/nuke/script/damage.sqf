private ["_xpos", "_ypos", "_vehicles", "_units", "_airs", "_objects", "_distance", "_damage","_wave_radius", "_speed", "_vel"];

_xpos = _this select 0;
_ypos = _this select 1;

_wave_radius = RadiationRadius * 1.7;

  _vehicles = nearestobjects [[_xpos, _ypos , 0], ["Car", "Motorcycle", "Tank", "Air", "Ship"], RadiationRadius * 2.9];
  _objects = nearestobjects [[_xpos, _ypos, 0], [], _wave_radius];


sleep 4;

{
  if ( ! (_x iskindof "Land_nav_pier_m_2") ) then
  {
    {_x setdammage 1} foreach (crew _x);
    _x setdammage 1;
  };
} foreach ([_xpos, _ypos, 0] nearobjects ["All", 200]);

[_xpos, _ypos] execvm "FEAR\nuke\script\damage2.sqf";

if ( schaden_an ) then
{
  _airs = nearestobjects [[_xpos, _ypos , 0], ["Air"], RadiationRadius];
} else {
_airs = main_airs;  };
{
  _distance = [_xpos, _ypos, 0] distance _x;
  _dir = asin (((getpos _x select 1) - _ypos) / _distance);
  if ( getpos _x select 0 < _xpos ) then {_dir = 180 - _dir};
  _vel = velocity _x;
  _damage = 1 - _distance / RadiationRadius;
  _damage = _damage * _damage;
  _speed = 4 * (_damage + random (_damage / 4));
  _speed = _speed * main_nuclear_blow_speed;
  _x setvelocity [(_vel select 0) + (_speed * cos _dir),
                  (_vel select 1) + (_speed * sin _dir),
                  _speed / 3];
  _x setdammage ((getdammage _x) + _damage);
} foreach _airs;


  {[_x] execvm "FEAR\nuke\script\electro_pulse.sqf"} foreach _vehicles;


{
  if ( ! (_x iskindof "All") ) then {_x setdammage 1}
  else
  {
    if ( _x iskindof "Man" || _x iskindof "Car" || _x iskindof "Motorcycle" ||
         _x iskindof "Tank" || _x iskindof "Ship" ) then
    {
      _distance = [_xpos, _ypos, 0] distance _x;
      _dir = asin (((getpos _x select 1) - _ypos) / _distance);
      if ( getpos _x select 0 < _xpos ) then {_dir = 180 - _dir};
      _vel = velocity _x;
      _damage = 1 - _distance / RadiationRadius;
      _damage = _damage * _damage;
      _speed = _damage + random (_damage / 4);
      if ( _x iskindof "Man" ) then {_speed = _speed * 2}
        else {[_x, _speed * 4] execvm "FEAR\nuke\script\rotate.sqf"};
      _speed = _speed * main_nuclear_blow_speed;
      _x setvelocity [(_vel select 0) + (_speed * cos _dir),
                      (_vel select 1) + (_speed * sin _dir),
                      _speed / 3];
      _x setdammage ((getdammage _x) + _damage);
    };
  };  
} foreach _objects;

