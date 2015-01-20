/*
  UNIT TRACKER 
  V1.4.0 / 2011-05-30

  Creates an independent trail of markers for any unit the script is assigned to. (ArmA Version)                          

  © 2011 - Kronzky (kronzky@gmail.com)

 ************************************************************************************************************

  Call arguments:                                                              

  Mandatory:
   unit         = Unit that is supposed to be tracked                                                        
                  (either "this", if called in the unit's init field, or the ID of the unit)                 
                  More than one unit can be tracked, using different parameters and marker types             
                  nul=[this] execVM "track.sqf"                                                                

	Optional:
   distance     = By default the distance between markers depends on the kind of unit that's being tracked.
                  To define a specific distance, enter it as the second parameter.
                  nul=[this,1] execVM "track.sqf"                                                                

   waypointflag = If you want waypoints to be displayed as well, use the parameter "WP"                      
                  If *only* the waypoints should be displayed (without tracking), use "WPONLY"
                  nul=[this,"WP"] execVM "track.sqf"

   groupflag    = If a group is tracked, then by default only the leader's path is shown.
                  To show each team members path individually, use the "GROUP" parameter.
                  nul=[this,"GROUP"] execVM "track.sqf"

   traillength  = If the track length should only have a limited length, defined this via
                  the parameter ["TRAIL:",length] (keyword, followed by value)
                  nul=[this,"TRAIL:",10] execVM "track.sqf"

   showreverse  = If the marker should show up in red if the vehicle is moving backwards,
                  use the parameter "SHOWREVERSE" in the argument list.
                  nul=[this,"SHOWREVERSE"] execVM "track.sqf"

   showstatic   = If the marker should increase its size when the unit is static,
                  user the parameter "SHOWSTATIC" in the argument list.
                  nul=[this,"SHOWSTATIC"] execVM "track.sqf"
                  By default, the size of the marker will be increased by 1% for every second,
                  up to a maximum size of 5.
                  To change this, pass an array with [percent,maxsize] after the "SHOWSTATIC" argument:
                  e.g. nul=[this,"SHOWSTATIC",[2,10]] execVM "track.sqf"

 ------------------------------------------------------------------------------------------------------------

  By default the tracking marker is a dot, with a color dependent on the unit's side                         
  (red=opfor, green=blufor, black=resistance, blue=civilians)                                                
  If another style is preferred, a sample marker can be created to define the look.                        
  In that case create a marker called "TRACK" anywhere on the map that has the looks you desire.  
  If you want to use a specific sample marker for the tracked unit, create it manually,
  and enter its name into the parameter list (nul=[unit1,"marker_u1"] execVM "track.sqf")           

  You can also customize the look of the waypoint markers by creating a sample marker called "WP"            

 ------------------------------------------------------------------------------------------------------------

  Since this script is not mission specific, it might be a good idea to put it into the common               
  script folder, so that it can be accessed by all missions.                                                 
  The common script folder is named "Scripts", and resides in your My Documents\playername\ArmA directory    
  (It also contains the folders "missions", "Saved", "UserSaved").                                           
  By default VBS doesn't create this folder, so you may have to create it first yourself.                   

 ************************************************************************************************************
*/

_max=100000;

_getArg = {private["_cLC","_cUC","_arg","_list","_a","_v"]; _cLC=_this select 0; _cUC=_this select 1; _arg=_this select 2; _list=_this select 3; _a=-1; {_a=_a+1; _v=format["%1",_list select _a]; if ((_v==_cLC) || (_v==_cUC)) then {_arg=(_list select _a+1)}} foreach _list; _arg};

if (isNil("markercnt")) then {	markercnt=0; };

// unit to be tracked
_unit = _this select 0;

// minimum distance 
_mindist=2;
_isvehicle=false;
if ("LandVehicle" countType [vehicle _unit]>0) then {_mindist=5;};
if ("Ship" countType [vehicle _unit]>0) then {_mindist=5;};
if ("Air" countType [vehicle _unit]>0) then {_mindist=10;};
_isvehicle=vehicle _unit!=_unit;
_defdist=0;
//define distance
if ((count _this)>1) then {
	_tst=_this select 1;
	if (parseNumber str(_tst)>0) then {
		_mindist=_tst;
		_defdist=_tst;
	};
};

// marker defaults
_markertype = "MIL_DOT"; //IK23
_markersize=.5;
_markershape="ICON";
_markercolor="ColorBlue";
switch (side _unit) do {
	case east:{_markercolor="ColorRed"};
	case west:{_markercolor="ColorGreen"};	
	case resistance:{_markercolor="ColorBlack"};
};
//player groupchat format["unit:%1,%2,%3",_unit,side _unit,_markercolor];

//generic sample marker
_sample=getMarkerPos "TRACK";
if ((_sample select 0)!=0) then {
	_markertype=getMarkerType "TRACK";
	_markersize=getMarkerSize "TRACK" select 0;
	_markercolor=getMarkerColor "TRACK";
	"TRACK" setMarkerPos getpos _unit;
};
//specific sample marker
_markersample="";
if (count _this>1) then {
	for "_i" from 1 to (count _this) do {
		_tracker=_this select _i;
		if ((typeName (_tracker))=="string") then {
			_sample = getMarkerPos _tracker;
			if ((_sample select 0)!=0) then {
				_markersample = _tracker;
				_markertype=getMarkerType _tracker;
				_markersize=getMarkerSize _tracker select 0;
				_tracker setMarkerPos getpos _unit;
				_markercolor = getMarkerColor _tracker;
			}
		}
	}
};

//limited trail
_trailsize = ["TRAIL:","trail:",10000,_this] call _getArg;

//display waypoints
if (("WP" in _this) || ("wp" in _this) || ("WPONLY" in _this) || ("wponly" in _this)) then {
	_wpidx=0;
	_wptype="flag"; 
	_wpsize=[.5,.5];
	_wpsample=getMarkerPos "WP";
	if ((_wpsample select 0)!=0) then {
		_wptype=getMarkerType "WP";
		_wpsize=getMarkerSize "WP";
	};
	"WP" setMarkerPos [-3333,-3333,111];
	// create markers
	while {(getwppos[_unit,_wpidx] select 0)!=0} do
	{
		_mrkname=format["wp_%1_%2",_wpidx,markercnt];
		_marker=createMarker[_mrkname,getwppos[_unit,_wpidx]];
		_marker setMarkerText format["%1",_wpidx];
		_mrkname setMarkerType _wptype;
		_mrkname setMarkerSize _wpsize;
		_mrkname setMarkerColor "ColorYellow";
		_wpidx=_wpidx+1;
		markercnt=markercnt+1;
	};
};
if (("WPONLY" in _this) || ("wponly" in _this)) exitWith {};

// track group members
if (("GROUP" in _this) || ("group" in _this)) then {
	_grp = units _unit;
	if ((count _grp)>1) then {
		{
			if (_x!=_unit) then {
				_vu = vehicle _x;
				if ((_vu==_x) || (driver _vu==_x)) then {
					_nul=[_x,_defdist,_markersample,"trail:",_trailsize] execVM "FEAR\dynamic_ups\track.sqf";
				};
			};
		} forEach _grp;
	};
};
if (_isvehicle) exitWith {};

_showreverse = (("showreverse" in _this) || ("SHOWREVERSE" in _this));

_showstatic = (("showstatic" in _this) || ("SHOWSTATIC" in _this));
_staticparm = [1.001,5];
if (_showstatic) then {
	_idx = _this find "showstatic";
	if (_idx==-1) then {
		_idx = _this find "SHOWSTATIC";
	};
	if (count _this>_idx+1) then {
		_staticparm = _this select _idx+1;
	};
	// 1%/sec == 1.001 per 1/100 second (testing cycle)
	_staticparm set [0,1+(_staticparm select 0)/1000];
};

//init
_lastpos=getpos _unit;
_idx=0;

// ***************************** MAIN LOOP *****************************
_trail=[];
_mrkname="";
_stopsize=_markersize;
while {true} do {
	sleep 0.01;
	_currpos = getpos _unit;
	if !(alive _unit) exitWith {
		if ((count _trail)>1) then {
			(_trail select (count _trail)-1) setMarkerColor "ColorBlack";
		};
	};
	_dist = _lastpos distance _currpos;
	if (_dist>_mindist) then {
		_lastpos = _currpos;
		_idx=_idx+1;
		//_mrkname=format["M_%1_%2",_idx,name _unit]; // can't use names since they're identical in ArmA for E,C & R
		_mrkname=format["M_%1_%2",_idx,markercnt];
		_marker=createMarker[_mrkname,_currpos];
		_mrkname setMarkerType _markertype;
		_mrkname setMarkerSize [_markersize*2,_markersize*2];
		_marker setMarkerShape _markershape;
		_marker setMarkerDir getDir _unit;
		_mrkname setMarkerColor "ColorYellow";
		if (_showreverse && (speed (vehicle _unit)<0)) then {
			_mrkname setMarkerColor "ColorRed";
		};
		
		markercnt=markercnt+1;
		if (markercnt>_max) then {_loop=1;};
		_ts=count _trail;
		// if the trail gets too long, cut off the end
		if (_ts>=_trailsize) then {
			deleteMarker (_trail select 0);
			for "_i" from 0 to _trailsize-1 do {
				_trail set [_i,_trail select _i+1];
			};
			_trail set [_trailsize-1,_mrkname];
		} else {
			_trail=_trail+[_mrkname];
		};
		// change the previously first marker from its head settings (bigger & yellow) to the regular settings
		if (_ts>1) then {
			_tail = _trail select (_ts-1);
			_tail setMarkerColor _markercolor;
			_tail setMarkerSize [_stopsize,_stopsize];
			_stopsize = _markersize;
		};
	} else {
		if ((_showstatic) && (speed _unit<1)) then {
			if (_mrkname!="") then {
				_stopsize = ((getMarkerSize _mrkname select 0)*(_staticparm select 0)) min (_staticparm select 1);
				_mrkname setMarkerSize [_stopsize,_stopsize];
			};	
		};
	};
};
if (markercnt>_max) then {hintc format["too many markers:%1",markercnt]};
