/*
	Author: IT07

	Description:
	mission for VEMF
*/

if (isNil"VEMF_HeliCrashHistory") then
{
	VEMF_HeliCrashHistory = [];
};

// Define settings
_aiSkill = (["aiSkill"] call VEMF_fnc_getSetting) select 0;
_redropDistanceMin = (["redropDistanceMin"] call VEMF_fnc_getSetting) select 0;
_redropTimeMin = (["redropTimeMin"] call VEMF_fnc_getSetting) select 0;

// Try 10 times to find a proper destination
private ["_foundIt"];
_dest = [position (playableUnits select floor random count playableUnits), 1500, 4000, 5, 0, 5, 0] call BIS_fnc_findSafePos; // Just define it. It will replace anyways if history not empty
if (count VEMF_HeliCrashHistory > 0) then
{
	for "_i" from 1 to 10 do
	{
		if ((_dest distance ((VEMF_HeliCrashHistory select 0) select 0)) > _redropDistanceMin AND (serverTime - ((VEMF_HeliCrashHistory select 0) select 1)) > _redropTimeMin*60) exitWith
		{
			_foundIt = true;
			VEMF_HeliCrashHistory = []; // Clear history
		};
		_dest = [position (playableUnits select floor random count playableUnits), 1500, 4000, 5, 0, 5, 0] call BIS_fnc_findSafePos;
		uiSleep 1;
	};
};

// If the _dest finder made _abort TRUE, exit
if (isNil"_foundIt" AND (count VEMF_HeliCrashHistory) > 0) exitWith
{
	diag_log "[VEMF] HeliCrash INFO: canceled. Too close and too soon...";
};

// Script did not exit, good _dest found. Add found _dest to history.
VEMF_HeliCrashHistory pushBack [_dest, serverTime];

// Create the _heli
_pos = [_dest,1000,3000,0,0,1200,0] call BIS_fnc_findSafePos;
_heli = createVehicle ["B_Heli_Transport_01_camo_F", [_pos select 0, _pos select 1, 800], [], 0, "FLY"];
_heli call EPOCH_server_setVToken;

// Give _heli a color
_heli setObjectTextureGlobal [0, "#(argb,8,8,3)color(0.494,0.063,0.063,0.2)"];
_heli setObjectTextureGlobal [1, "#(argb,8,8,3)color(0,0,0,0.2)"];

// Create the _crew
_crew = createGroup RESISTANCE;
_crew setBehaviour "AWARE";
_crew setCombatMode "RED";

_crewLoadout =
{
	removeAllWeapons _crewUnit;
	removeAllItems _crewUnit;
	removeAllAssignedItems _crewUnit;
	removeUniform _crewUnit;
	removeVest _crewUnit;
	removeBackpack _crewUnit;
	removeHeadgear _crewUnit;
	removeGoggles _crewUnit;

	_crewUnit forceAddUniform "U_B_HeliPilotCoveralls";
	for "_i" from 1 to 3 do {_crewUnit addItemToUniform "9Rnd_45ACP_Mag";};
	_crewUnit addVest "V_TacVest_camo";
	for "_i" from 1 to 3 do {_crewUnit addItemToVest "20Rnd_762x51_Mag";};
	_crewUnit addBackpack "B_Parachute";
	_crewUnit addHeadgear "H_38_EPOCH";
	_crewUnit addWeapon "srifle_DMR_03_F";
	_crewUnit addWeapon "hgun_ACPC2_F";

	[_crewUnit,"BI"] call bis_fnc_setUnitInsignia;
};

for "_i" from 1 to 4 do
{
	_crewUnit = _crew createUnit ["I_Soldier_EPOCH", [0,0,0], [], 0, "NONE"];
	_crewUnit setSkill ["general", _aiSkill];
	_crewUnit setRank "Private";
	_crewUnit enableAI "TARGET";
	_crewUnit enableAI "AUTOTARGET";
	_crewUnit enableAI "MOVE";
	_crewUnit enableAI "ANIM";
	_crewUnit enableAI "FSM";
	_crewUnit enableAI "AIMINGERROR";
	_crewUnit enableAI "SUPRESSION";
	call
	{
		if (_i isEqualTo 1) exitWith
		{
			_crewUnit moveInDriver _heli;
			_crew selectLeader _crewUnit;
			removeAllWeapons _crewUnit;
			removeAllItems _crewUnit;
			removeAllAssignedItems _crewUnit;
			removeUniform _crewUnit;
			removeVest _crewUnit;
			removeBackpack _crewUnit;
			removeHeadgear _crewUnit;
			removeGoggles _crewUnit;
			_crewUnit forceAddUniform "U_I_pilotCoveralls";
			for "_i" from 1 to 3 do {_crewUnit addItemToUniform "11Rnd_45ACP_Mag";};
			_crewUnit addVest "V_TacVestIR_blk";
			for "_i" from 1 to 2 do {_crewUnit addItemToVest "11Rnd_45ACP_Mag";};
			_crewUnit addHeadgear "H_PilotHelmetHeli_I";
			_crewUnit addGoggles "G_Bandanna_aviator";
			_crewUnit addWeapon "hgun_Pistol_heavy_01_F";
			[_crewUnit,"BI"] call bis_fnc_setUnitInsignia;
		};
		if (_i isEqualTo 2) exitWith
		{
			_crewUnit moveInTurret [_heli, [0]];
			call _crewLoadout;
		};
		if (_i isEqualTo 3) exitWith
		{
			_crewUnit moveInTurret [_heli, [1]];
			call _crewLoadout;
		};
		if (_i isEqualTo 4) exitWith
		{
			_crewUnit moveInTurret [_heli, [2]];
			call _crewLoadout;
		};
	};
	uiSleep 0.05;
};

// Create the units
_grp = createGroup RESISTANCE;
_grp setBehaviour "AWARE";
_grp setCombatMode "RED";

private ["_unit"];
for "_b" from 1 to (_heli emptyPositions "Cargo") do
{
	_unit = _grp createUnit ["I_Soldier_EPOCH", [0,0,0], [], 0, "NONE"];
	_unit moveInCargo _heli;
	[_unit,"Para"] call VEMF_fnc_loadInv; // Load the AI's inventory
	_unit addBackpackGlobal "B_Parachute";
	_unit setSkill ["general", _aiSkill];
	_unit setRank "Private";
	_unit enableAI "TARGET";
	_unit enableAI "AUTOTARGET";
	_unit enableAI "MOVE";
	_unit enableAI "ANIM";
	_unit enableAI "FSM";
	_unit enableAI "AIMINGERROR";
	_unit enableAI "SUPRESSION";
	if (_b isEqualTo (_heli emptyPositions "Cargo")) then
	{
		_grp selectLeader _unit;
	};
	uiSleep 0.05;
};

// Set destination
_heli flyInHeight 300;
diag_log format["[VEMF] HeliCrash: _dest is %1 @ %2", _dest, mapGridposition _dest];
_wp = _crew addWaypoint [_dest, 10, 1];
_wp setWaypointType "LOITER";
_wp setWaypointSpeed "FULL";
_wp setWaypointLoiterType "CIRCLE";
_wp setWaypointLoiterRadius 0;

// Wait for _heli to reach 1st destionation
waitUntil { uiSleep 1; ((_heli distance _dest) < 1000) };
{
	[_x] allowGetIn false;
	unassignVehicle _x;
	_x action ["GETOUT", _heli];
	uiSleep 0.25;
} forEach (units _grp);

// Tell group to GUARD
_LZ = _grp addWaypoint [position _heli, 0];
_LZ setWaypointType "LOITER";
_LZ setWaypointSpeed "FULL";

// Kill the heli
_heli setDamage 0.99;
waitUntil { uiSleep 1; isTouchingGround _heli };

// Create/place the marker
_marker = createMarker [format["VEMF_HeliCrash_ID%1", floor random 9000], position _heli];
_marker setMarkerShape "ICON";
_marker setMarkerType "hd_objective";
_marker setMarkerColor "ColorBlack";
_marker setMarkerText " Heli Crash";

_LZ setWaypointPosition [getMarkerPos _marker, 0];
_magazines = (["magazinesLoot"] call VEMF_fnc_getSetting) select 0;
private ["_lootPos"];
for "_p" from 0 to 7 do
{
	_lootPos = [position _heli, 1, 2, 0, 0, 5, 0] call BIS_fnc_findSafePos;
	_loot = "groundWeaponHolder" createVehicle _lootPos;
	_mag = _magazines call BIS_fnc_selectRandom;
	_loot addMagazineCargoGlobal [_mag, floor random 5 + floor random 10];
};

// Mission ended, deduct it from missionCount
VEMF_missionCount = VEMF_missionCount - 1;

// Send message to all players
//["Activity sighted...", "A chopper has been downed, check the map.", "", [0], ""] call VEMF_fnc_broadCast;
_msg = ["Activity sighted...","A chopper has been downed, check the map."];
[_msg] call FEARBroadcast;