/*
	spawndialog
	by Halv
	Copyright (C) 2015  Halvhjearne > README.md
*/
#include "spawn_gear_settings.sqf";
_scriptpath = _this select 0;
_rspawnw = getMarkerPos "respawn_west";
HALV_Center = getMarkerPos "center";

// Wait until player ingame
waitUntil{!isNil "HALV_senddeftele"};
waitUntil{!isNil "Epoch_my_GroupUID"};

// Exit if player not near spawn
if(player distance _rspawnw > 35)exitWith{
	call Halv_clear_vars;
	diag_log "Spawn Menu Aborted...";
};

diag_log format["[halv_spawn] waiting for new teleports to be build in %1 ...",worldName];

{
	_x addAction [
		"<img size='1.5'image='\a3\Ui_f\data\IGUI\Cfg\Actions\ico_cpt_start_on_ca.paa'/> <t color='#0096ff'>Select</t><t > </t><t color='#00CC00'>Spawn</t>",
		(_scriptpath+"opendialog.sqf"),
		_x,
		-9,
		true,
		true,
		"",
		"player distance _target < 5"
	];
}forEach (HALV_senddeftele select 0);

diag_log format["[halv_spawn] addAction added to %1",HALV_senddeftele];
waitUntil {!dialog};

_diagTiackTime = diag_tickTime;
diag_log format["Loading Spawn Menu ... %1",_diagTiackTime];

_pregearcheck = profileNamespace getVariable["HALVSPAWNLASTGEAR",[[],[],[],[],[],[],[],[],[],[]]];
if !(_pregearcheck isEqualTo [[],[],[],[],[],[],[],[],[],[]])then{
	_gchanged = false;
	_PID = getPlayerUID player;
	{
		_garray = _x;
		_serverarr = switch(_forEachIndex)do{
			case 0:{[(_geararr select 0)select 0,1]};
			case 1:{[(_geararr select 1)select 0,1]};
			case 2:{[(_geararr select 2)select 0,(_geararr select 2)select 1]};
			case 3:{[(_geararr select 3)select 0,(_geararr select 3)select 1]};
			case 4:{[(_geararr select 4)select 0,(_geararr select 4)select 1]};
			case 5:{[_geararr select 5,1]};
			case 6:{[_geararr select 6,1]};
			case 7:{[((_geararr select 7)select 0)+((_geararr select 7)select 1),1]};
			case 8:{[_geararr select 8,1]};
			case 9:{[_geararr select 9,1]};
		};
		
		{
			_item = _x;
			if (!(_x in (_serverarr select 0)))exitWith{_gchanged = true};
		}forEach _garray;
		
		if (_gchanged || count _garray > (_serverarr select 1))exitWith{
			profileNamespace setVariable ["HALVSPAWNLASTGEAR",nil];
		};
		
	}forEach _pregearcheck;
};

#include "spawn_locations.sqf";
HALV_GEAR_TOADD = [[],[],[],[],[],[],[],[],[],[]];

Halv_near_cityname = {
	_nearestCity = nearestLocations [_this, ["NameCityCapital","NameCity","NameVillage","NameLocal"],1000];
	_textCity = "Wilderness";
	if (count _nearestCity > 0) then {
		{if !(toLower(text _x) in ["military"])exitWith{_textCity = text _x};}count _nearestCity;
	};
	_textCity
};

// Spawn near jammer
{
	if((_x getVariable ["BUILD_OWNER", "-1"]) in [getPlayerUID player, Epoch_my_GroupUID])exitWith{
		_jamvar = getPos _x;
		diag_log format["[halv_spawn] found a player jammer @ %1",_jamvar];
		_name = _jamvar call Halv_near_cityname;
		Halv_spawns pushBack [_jamvar,6,format["%1 (%2)",_name,localize "STR_HALV_NEAR_JAMMER"]];
	}; 
}forEach (HALV_Center nearObjects ["PlotPole_EPOCH",10000]); // Range to search

// Spawn near group
_leader = leader(group player);
if (count units(group player) > 1 && !(_leader isEqualTo player)) then{
	_grouppos = getPos _leader;
	_name = _grouppos call Halv_near_cityname;
	Halv_spawns pushBack [_grouppos,7,format["%1 (%2)",_name,localize "STR_HALV_NEAR_GROUP"]];
};

Halv_moveMap = {
	disableSerialization;
	_lb = _this select 0;
	_index = _this select 1;
	_value = _lb lbValue _index;
	_zoom = 1;
	_spawn = HALV_Center;
	if !(_value in [-1,-2,-3]) then {
		_spawn = (Halv_spawns select _value)select 0;
		_zoom = .15;
	};
	_ctrl = (findDisplay 7777) displayCtrl 7775;
	ctrlMapAnimClear _ctrl;
	_ctrl ctrlMapAnimAdd [1,_zoom,_spawn];
	ctrlMapAnimCommit _ctrl;
};

HALV_addiweaponwithammo = {
	#include "spawn_gear_settings.sqf";
	_ammo = [] + getArray (configFile >> "cfgWeapons" >> _this >> "magazines");
	if (count _ammo > 0) then {
		_ammoamount = if(_this in ((_geararr select 1) select 0))then{((_geararr select 1) select 1)}else{((_geararr select 0) select 1)};
		for "_i" from 1 to _ammoamount do {
			_rnd = _ammo select 0;
			player addMagazine _rnd;
		};
	};
	player addWeapon _this;
	player selectWeapon _this;
	reload player;
};

Halv_spawn_player = {
	#include "spawn_gear_settings.sqf";
	disableSerialization;
	private ["_spawn","_cityname","_val"];
	_lb = _this select 0;
	_index = _this select 1;
	_value = _lb lbValue _index;
	if(_value isEqualTo -1)exitWith{};
	if(_value isEqualTo -3)then{
		_spawn = (Halv_spawns call BIS_fnc_selectRandom) select 0;
		_val= 0 ;
		_cityname = _spawn call Halv_near_cityname;
	}else{
		_spawn = (Halv_spawns select _value)select 0;
		_val = if(count (Halv_spawns select _value) > 1)then{(Halv_spawns select _value)select 1}else{0};
		_cityname = if(count (Halv_spawns select _value) > 2)then{(Halv_spawns select _value)select 2}else{_spawn call Halv_near_cityname};
	};
	_pUID = getPlayerUID player;

	closeDialog 0;
	
	// Remove default items from player
	removeAllWeapons player;removeAllItems player;removeAllAssignedItems player;
	{player removeMagazine _x;}count (magazines player);
	removeUniform player;removeVest player;removeBackpack player;removeGoggles player;removeHeadGear player;
	
	if (!(HALV_GEAR_TOADD isEqualTo [[],[],[],[],[],[],[],[],[],[]]) && !(HALV_GEAR_TOADD isEqualTo (profileNamespace getVariable ["HALVSPAWNLASTGEAR",[[],[],[],[],[],[],[],[],[],[]]])))then{
		profileNamespace setVariable ["HALVSPAWNLASTGEAR",HALV_GEAR_TOADD];
	};
	diag_log str['HALV_GEAR_TOADD',HALV_GEAR_TOADD];
	
	// Add player gear
	_addedgear = [[],[],[],[],[],[],[],[],[],[]];;
	if(count (HALV_GEAR_TOADD select 9) < 1)then{
		_item = (_geararr select 9) call BIS_fnc_selectRandom;
		player addbackpack _item;
		(_addedgear select 9) pushBack ['random',_item];
	}else{
		player addbackpack ((HALV_GEAR_TOADD select 9)select 0);
		(_addedgear select 9) pushBack ((HALV_GEAR_TOADD select 9)select 0);
	};

	if(count (HALV_GEAR_TOADD select 8) < 1)then{
		_item = (_geararr select 8) call BIS_fnc_selectRandom;
		player addgoggles _item;
		(_addedgear select 8) pushBack ['random',_item];
	}else{
		player addgoggles ((HALV_GEAR_TOADD select 8)select 0);
		(_addedgear select 8) pushBack ((HALV_GEAR_TOADD select 8)select 0);
	};
	_sel = if((typeOf player) isEqualTo "Epoch_Female_F")then{1}else{0};
	if(count (HALV_GEAR_TOADD select 7) < 1)then{
		_item = ((_geararr select 7) select _sel) call BIS_fnc_selectRandom;
		player forceAddUniform _item;
		(_addedgear select 7) pushBack ['random',_item];
	}else{
		player forceAddUniform ((HALV_GEAR_TOADD select 7)select 0);
		(_addedgear select 7) pushBack ((HALV_GEAR_TOADD select 7)select 0);
	};

	if(count (HALV_GEAR_TOADD select 6) < 1)then{
		_item = (_geararr select 6) call BIS_fnc_selectRandom;
		player addVest _item;
		(_addedgear select 6) pushBack ['random',_item];
	}else{
		player addVest ((HALV_GEAR_TOADD select 6)select 0);
		(_addedgear select 6) pushBack ((HALV_GEAR_TOADD select 6)select 0);
	};

	if(count (HALV_GEAR_TOADD select 5) < 1)then{
		_item = (_geararr select 5) call BIS_fnc_selectRandom;
		player addheadgear _item;
		(_addedgear select 5) pushBack ['random',_item];
	}else{
		player addheadgear ((HALV_GEAR_TOADD select 5)select 0);
		(_addedgear select 5) pushBack ((HALV_GEAR_TOADD select 5)select 0);
	};

	if(count (HALV_GEAR_TOADD select 4) < (_geararr select 4) select 1)then{
		_missing = ((_geararr select 4) select 1) - (count (HALV_GEAR_TOADD select 4));
		for "_i" from 1 to _missing do {
			_item = ((_geararr select 4) select 0) call BIS_fnc_selectRandom;
			player addMagazine _item; 
			(_addedgear select 4) pushBack ['random',_item];
		};
		{player addMagazine _x;(_addedgear select 4) pushBack _x;}forEach (HALV_GEAR_TOADD select 4);
	}else{
		{player addMagazine _x;(_addedgear select 4) pushBack _x;}forEach (HALV_GEAR_TOADD select 4);
	};

	if(count (HALV_GEAR_TOADD select 3) < (_geararr select 3) select 1)then{
		_missing = ((_geararr select 3) select 1) - (count (HALV_GEAR_TOADD select 3));
		for "_i" from 1 to _missing do {
			_item = ((_geararr select 3) select 0) call BIS_fnc_selectRandom;
			_radios = ["EpochRadio0","EpochRadio1","EpochRadio2","EpochRadio3","EpochRadio4","EpochRadio5","EpochRadio6","EpochRadio7","EpochRadio8","EpochRadio9"];
			_hasradio = if((_item in _radios) && {_x in _radios}count((weapons player)+(assignedItems player)) > 0)then{true}else{false};
			if(_item in ((weapons player)+(assignedItems player)) || _hasradio)then{
				player addItem _item;
			}else{
				player addWeapon _item;
			};
			(_addedgear select 3) pushBack ['random',_item];
		};
		{
			_item = _x;
			_radios = ["EpochRadio0","EpochRadio1","EpochRadio2","EpochRadio3","EpochRadio4","EpochRadio5","EpochRadio6","EpochRadio7","EpochRadio8","EpochRadio9"];
			_hasradio = if((_item in _radios) && {_x in _radios}count((weapons player)+(assignedItems player)) > 0)then{true}else{false};
			if(_item in ((weapons player)+(assignedItems player)) || _hasradio)then{
				player addItem _item;
				(_addedgear select 3) pushBack ['addItem',_item];
			}else{
				player addWeapon _item;
				(_addedgear select 3) pushBack ['addWeapon',_item];
			};
		}forEach (HALV_GEAR_TOADD select 3);
	}else{
		{
			_item = _x;
			_radios = ["EpochRadio0","EpochRadio1","EpochRadio2","EpochRadio3","EpochRadio4","EpochRadio5","EpochRadio6","EpochRadio7","EpochRadio8","EpochRadio9"];
			_hasradio = if((_item in _radios) && {_x in _radios}count((weapons player)+(assignedItems player)) > 0)then{true}else{false};
			if(_item in ((weapons player)+(assignedItems player)) || _hasradio)then{
				player addItem _item;
				(_addedgear select 3) pushBack ['addItem',_item];
			}else{
				player addWeapon _item;
				(_addedgear select 3) pushBack ['addWeapon',_item];
			};
		}forEach (HALV_GEAR_TOADD select 3);
		
	};

	if(count (HALV_GEAR_TOADD select 2) < (_geararr select 2) select 1)then{
		_missing = ((_geararr select 2) select 1) - (count (HALV_GEAR_TOADD select 2));
		for "_i" from 1 to _missing do {
			_item = ((_geararr select 2) select 0) call BIS_fnc_selectRandom;
			player addItem _item;
			(_addedgear select 2) pushBack ['random',_item];
		};
		{player addItem _x;(_addedgear select 2) pushBack _x;}forEach (HALV_GEAR_TOADD select 2);
	}else{
		{player addItem _x;(_addedgear select 2) pushBack _x;}forEach (HALV_GEAR_TOADD select 2);
	};

	if(count (HALV_GEAR_TOADD select 0) < 1)then{
		_item = ((_geararr select 0) select 0) call BIS_fnc_selectRandom;
		_item call HALV_addiweaponwithammo;
		(_addedgear select 0) pushBack ['random',_item];
	}else{
		((HALV_GEAR_TOADD select 0)select 0) call HALV_addiweaponwithammo;
		(_addedgear select 0) pushBack ((HALV_GEAR_TOADD select 0)select 0);
	};

	if(count (HALV_GEAR_TOADD select 1) < 1)then{
		_item = ((_geararr select 1) select 0) call BIS_fnc_selectRandom;
		_item call HALV_addiweaponwithammo;
		(_addedgear select 1) pushBack ['random',_item];
	}else{
		((HALV_GEAR_TOADD select 1)select 0) call HALV_addiweaponwithammo;
		(_addedgear select 1) pushBack ((HALV_GEAR_TOADD select 1)select 0);
	};
	diag_log str['_addedgear:',_addedgear];
	player addWeapon "ItemMap"; // Add map as default item

	_spawn set [2,0];
	_position = [0,0,0];
	_t = diag_tickTime;
	_try = 0;
	while{true}do{
		_try = _try +1;
		_area = 200; // Distance to spawn
		_position = [_spawn,0,_area,2,0,2000,0] call BIS_fnc_findSafePos;
		if(_position distance _spawn > 0 && _position distance _spawn < _area || _try isEqualTo 100)exitWith{if(_try isEqualTo 100)then{_position = _spawn;};};
	};

	if(_try isEqualTo 100)then{
		_failtxt = "[halv_spawn] BIS_fnc_findSafePos Failed to find position in 100 try's ... reverted to exact position!";
		systemChat _failtxt;
		diag_log format["%1 %2",_failtxt,_spawn];
	};

	// Spawn player on ground
	player setPos _position;
	titleText[format[localize "STR_HALV_SPAWNEDNEAR",_cityname,name player],"PLAIN DOWN"];
	
	[] execVM "halv_spawn\credits.sqf";
	
	call Halv_clear_vars;
};

Halv_clear_vars = {
	Halv_moveMap = nil;Halv_fill_spawn = nil;Halv_near_cityname = nil;Halv_spawn_player = nil;Halv_spawns = nil;HALV_Center = nil;HALV_senddeftele = nil;HALV_SELECTSPAWN = nil;HALV_fill_gear = nil;HALV_fill_gear = nil;HALV_GEAR_TOADD = nil;HALV_player_removelisteditem = nil;HALV_addiweaponwithammo = nil;
};

Halv_fill_spawn = {
	HALV_SELECTSPAWN = true;
	disableSerialization;
	_ctrl = (findDisplay 7777) displayCtrl 7779;_ctrl ctrlShow false;
	_ctrl = (findDisplay 7777) displayCtrl 7781;
	if(_HALV_forcespawnMode > 0)then{
		if(_HALV_forcespawnMode isEqualTo 2)then{_ctrl ctrlSetChecked true;};
		_ctrl ctrlEnable false;
	}else{
		_ctrl ctrlEnable true;
	};
	
	// Select random gear
	_ctrl = (findDisplay 7777) displayCtrl 7780;
	if !(ctrlChecked _ctrl)then{_ctrl ctrlSetChecked true;};
	_ctrl ctrlEnable false;
	_ctrl ctrlSetTooltip "";

	_ctrl = (findDisplay 7777) displayCtrl 7775;_ctrl ctrlShow true;
	_ctrl = (findDisplay 7777) displayCtrl 7776;
	lbClear _ctrl;
	_pUID = getPlayerUID player;
	{
		_pos = _x select 0;
		_lvl = if(count _x > 1)then{_x select 1}else{0};
		_name = if(count _x > 2)then{_x select 2}else{_pos call Halv_near_cityname};
		_fi = _forEachIndex;
		_index = _ctrl lbAdd _name;
		_ctrl lbSetValue [_index,_fi];
		_ctrl lbSetTooltip [_index, localize "STR_HALV_DOUBLECLICKTOSPAWN"];

		switch (_lvl) do{
			case 6:{
				_ctrl lbSetColor [_index,[0,0.5,1,.7]];
				_ctrl lbSetPicture [_index,"\A3\ui_f\data\gui\Rsc\RscDisplayMultiplayer\sessions_star_ca.paa"];
				_ctrl lbSetTooltip [_index,localize "STR_HALV_DOUBLECLICKTOSPAWNJAM"];
				_ctrl lbSetPictureColorSelected [_index, [1, 1, 1, 1]];
			};
			case 7:{
				_ctrl lbSetColor [_index,[0,0.5,1,.7]];//Blue
				_ctrl lbSetPicture [_index,"\A3\ui_f\data\gui\Rsc\RscDisplayMultiplayer\sessions_star_ca.paa"];
				_ctrl lbSetTooltip [_index, "STR_HALV_DOUBLECLICKTOSPAWNGROUP"];
				_ctrl lbSetPictureColorSelected [_index, [0, 0, 0, 1]];
			};
			default{
				_ctrl lbSetPicture [_index,"\A3\ui_f\data\gui\Rsc\RscDisplayMultiplayer\sessions_none_ca.paa"];
				_ctrl lbSetPictureColorSelected [_index, [1, 1, 1, 1]];
			};
		};
		_ctrl lbSetPictureColor [_index, [1, 1, 1, 1]];
	}forEach Halv_spawns;
	
	lbSort _ctrl;
	
	_index = _ctrl lbAdd "";
	_ctrl lbSetValue [_index,-1];
	_index = _ctrl lbAdd (localize "STR_HALV_RANDOM");
	_ctrl lbSetColor [_index,[0,0.5,1,.7]];
	_ctrl lbSetValue [_index,-3];
	_ctrl lbSetPicture [_index,"\a3\Ui_f\data\IGUI\Cfg\Actions\ico_cpt_start_on_ca.paa"];
	_ctrl lbSetPictureColor [_index, [1, 1, 1, 1]];
	_ctrl lbSetPictureColorSelected [_index, [0, 0, 0, 1]];
	_ctrl lbSetTooltip [_index,localize "STR_HALV_DOUBLECLICKFORRANSPAWN"];
	_ctrl lbSetCurSel _index;
};

HALV_player_removelisteditem = {
	disableSerialization;
	_ctrl = _this select 0;
	_lb = _this select 1;
	if(_lb isEqualTo 0)exitWith{call Halv_fill_spawn;};
	if(_lb isEqualTo 1)exitWith{
		HALV_GEAR_TOADD = profileNamespace getVariable ["HALVSPAWNLASTGEAR",[[],[],[],[],[],[],[],[],[],[]]];
		call Halv_fill_spawn;
	};
};

diag_log format["Spawn Menu Loaded ... %1 - %2",diag_tickTime,diag_tickTime - _diagTiackTime];