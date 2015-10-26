/*
	Quarantine zone.
	Creates marker, surrounded by sign posts.
	Used Maca's Better Safezone script to spawn signposts in a circle.
*/

if(!isServer)exitWith{};

private["_quarantineZone"];

_quarantineZone = {
	private ["_trigger","_trigger_pos","_trigger_area","_angle","_radius","_distance","_count","_step","_pic","_signs"];
	
	_trigger = _this;
	_trigger_pos = getPos _trigger;
	_trigger_area = triggerArea _trigger;
	_angle = _trigger_area select 2;
	_radius = _trigger_area select 0; // needs to be a circle with equal a and b
	_distance = 30; // meters
	_count = round((2 * 3.14592653589793 * _radius) / _distance);
	_step = 360/_count;
	_signs = [];
	
	// Add _trigger to cleanup array
	_signs pushBack _trigger;
	
	// Create signposts in circle around _pos
	for "_x" from 0 to _count do
	{
		private["_pos","_sign"];
		_a = (_trigger_pos select 0) + (sin(_angle)*_radius);
		_b = (_trigger_pos select 1) + (cos(_angle)*_radius);

		_pos = [_a,_b,0];
		_angle = _angle + _step;

		_sign = createVehicle["SignAd_Sponsor_F",_pos,[],0,"CAN_COLLIDE"];
		// Load from Mission PBO, took ages to find this out! 
		// Global command broadcasts to clients.  They each need the picture file, separately.
		_pic = format["%1FEAR\sign.jpg",MISSION_directory]; // Path has hidden backslash before FEAR path
		_sign setObjectTextureGlobal[0,_pic];
		_sign setDir([_pos,_trigger_pos] call BIS_fnc_DirTo);
		
		// Add to array.
		// Use to delete later
		_signs pushBack _sign;
	};
	
	// Delete signs and trigger after set time
	uiSleep 1200; // 20 minutes
	{deleteVehicle _x}forEach _signs;
	QuarantineActive = false;
};

_contaminationDamage = {
	private["_quarantineCentre","_radius","_allPlayers"];
	
	_quarantineCentre = _this select 0;
	_radius = _this select 1;
	_allPlayers = call FEARGetPlayers;
	
	waitUntil {({(_quarantineCentre distance _x) < _radius} count _allPlayers) > 0};
	
	// Ground level fog
	5 setFog [0.7,0.7,5];

	while {QuarantineActive} do {
		{
			if (isPlayer _x) then {
				if !(_x call FEAR_fnc_hasGasMask) then {
					_x setDammage (getDammage _x + 0.01);
					hint "You need a gas mask in the quarantine zone";
				};
			};
		}forEach (_quarantineCentre nearEntities [["Epoch_Male_F","Epoch_Female_F"],_radius]);
		uisleep 0.1;
	};
};

private ["_arr","_list","_pos","_target","_radius","_name","_trigger"];

_arr = _this;
_name = _arr select 0;
_pos = _arr select 1;
_radius = 300;  // Default town radius

diag_log format["[FEAR] quarantine enforced at %1",_name];

_trigger = createTrigger["EmptyDetector",_pos];
_trigger setTriggerArea[_radius,_radius,0,false];
_trigger setTriggerActivation["ANY","PRESENT",true];
_trigger setTriggerType "SWITCH";

QuarantineActive = true;
_trigger spawn _quarantineZone;
[_pos,_radius] spawn _contaminationDamage;

// Add to existing public array and broadcast location to clients
FEARQuarantineLocs pushBack _pos;
publicVariable "FEARQuarantineLocs";