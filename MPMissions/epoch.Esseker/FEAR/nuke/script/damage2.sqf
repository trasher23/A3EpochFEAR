private ["_xpos", "_ypos", "_dis", "_damage"];

_xpos = _this select 0;
_ypos = _this select 1;

for [{_dis = 300}, {_dis <= RadiationRadius}, {_dis = _dis + 100}] do
{
  //[_xpos, _ypos, _dis] exec "FEAR\nuke\script\wave.sqs";
  if ( schaden_an ) then
  {
    //if ( _dis < 800 ) then {[_xpos, _ypos, _dis] execvm "FEAR\nuke\script\noise.sqf"};
  };
  {
    if ( ! (_x iskindof "Land_nav_pier_m_2") ) then
    {
      if ( _x iskindof "Static" ) then {_damage = 0.15 + random 0.1} else
      {
        if ( _x iskindof "Man" || _x iskindof "Air" ) then {_damage = 0.1 + random 0.06}
        else
        {
          {_x setdammage ((getdammage _x) + 0.07)} foreach (crew _x);
          _damage = 0.06 + random 0.04;
        };
      };
      _x setdammage ((getdammage _x) + _damage);
    };
  } foreach ([_xpos, _ypos, 0] nearobjects ["All", _dis]);
};


//[_xpos, _ypos, time] execvm "FEAR\nuke\script\geiger.sqf";
//[_xpos, _ypos, time] execvm "FEAR\nuke\script\radiation.sqf";
