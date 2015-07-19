/*
	despawnBandits
	
	Description: Deletes all AI units spawned by a trigger once all players leave the trigger area.
	
	Usage: Called by a static trigger when all players have left the trigger area.
	
	Last updated: 10:16 PM 5/26/2014
	
*/
private ["_trigger","_grpArray","_isCleaning","_grpCount","_triggerStatements","_deactStatements","_permDelete"];

_trigger = _this select 0;							//Get the trigger object

_grpArray = _trigger getVariable ["GroupArray",[]];	//Find the groups spawned by the trigger.
_isCleaning = _trigger getVariable ["isCleaning",true];	//Find whether or not the trigger has been marked for cleanup. Triggers will flag themselves for cleaning after a successful spawn/respawn with setVariable ["isCleaning",false];
_triggerStatements = triggerStatements _trigger;
_grpCount = count _grpArray;

if (A3EAI_debugLevel > 1) then {diag_log format ["A3EAI Debug: Trigger %1 Group Array: %2. isCleaning: %3. In static trigger array: %4",triggerText _trigger,_grpArray,_isCleaning,(_trigger in A3EAI_staticTriggerArray)];};
if (!(_trigger in A3EAI_staticTriggerArray) or {_isCleaning}) exitWith {if (A3EAI_debugLevel > 1) then {diag_log format ["A3EAI Debug: Trigger %1 has a despawn script already running. Exiting despawn script.",triggerText _trigger];};};	

_trigger setVariable["isCleaning",true];		//Mark the trigger as being in a cleanup state so that subsequent requests to despawn for the same trigger will not run.
_deactStatements = _triggerStatements select 2;
_triggerStatements set [2,""];
_trigger setTriggerStatements _triggerStatements;


if (A3EAI_debugLevel > 1) then {diag_log format["A3EAI Debug: No players remain in trigger area at %3. Deleting %1 AI groups in %2 seconds.",_grpCount, A3EAI_despawnWait,(triggerText _trigger)];};

if (A3EAI_debugMarkersEnabled) then {
	_nul = _trigger spawn {
		_tMarker = str (_this);
		_tMarker setMarkerText "STATIC TRIGGER (DESPAWNING)";
		_tMarker setMarkerColor "ColorOrange";
	};
};

if (({isNull _x} count _grpArray) < _grpCount) then {uiSleep A3EAI_despawnWait};

if (isNull _trigger) exitWith {[_trigger,"A3EAI_staticTriggerArray"] call A3EAI_updateSpawnCount};

if ((triggerActivated _trigger) && {({isNull _x} count _grpArray) < _grpCount}) exitWith {			//Exit script if trigger has been reactivated since A3EAI_despawnWait seconds has passed.
	_trigger setVariable ["isCleaning",false];	//Allow next despawn request.
	_triggerStatements set [2,_deactStatements];
	_trigger setTriggerStatements _triggerStatements;
	if (A3EAI_debugLevel > 1) then {diag_log format ["A3EAI Debug: A player has entered the trigger area at %1. Cancelling despawn script.",(triggerText _trigger)];};
	if (A3EAI_debugMarkersEnabled) then {
		_nul = _trigger spawn {
			_tMarker = str (_this);
			_tMarker setMarkerText "STATIC TRIGGER (ACTIVE)";
			_tMarker setMarkerColor "ColorRed";
		};
	};
};			

_trigger setTriggerStatements ["this","true","false"]; //temporarily disable trigger from activating or deactivating while cleanup is performed
_permDelete = _trigger getVariable ["permadelete",false];
{
	if (!isNull _x) then {
		_groupSize = (_x getVariable ["GroupSize",0]);
		if ((_groupSize > 0) or {_permDelete}) then { //If trigger is not set to permanently despawn, then ignore empty groups.
			if (A3EAI_debugLevel > 1) then {diag_log format ["A3EAI Debug: Despawning group %1 with %2 active units.",_x,(_x getVariable ["GroupSize",0])];};
			_x setVariable ["GroupSize",-1];
			if (A3EAI_HCIsConnected) then {
				A3EAI_updateGroupSize_PVC = [_x,-1];
				A3EAI_HCObjectOwnerID publicVariableClient "A3EAI_updateGroupSize_PVC";
			};
			_grpArray set [_forEachIndex,grpNull];
		};
	};
} forEach _grpArray;

[_trigger,"A3EAI_staticTriggerArray"] call A3EAI_updateSpawnCount;
if !(_permDelete) then {
	//Cleanup variables attached to trigger
	_trigger setVariable ["GroupArray",_grpArray - [grpNull]];
	_trigger setVariable ["isCleaning",false];
	_trigger setVariable ["unitLevelEffective",(_trigger getVariable ["unitLevel",1])];
	_trigger setTriggerArea [600,600,0,false];
	_trigger setTriggerStatements (_trigger getVariable "triggerStatements"); //restore original trigger statements
	if !((_trigger getVariable ["respawnLimitOriginal",-1]) isEqualTo -1) then {_trigger setVariable ["respawnLimit",_trigger getVariable ["respawnLimitOriginal",-1]];};
	if (A3EAI_debugMarkersEnabled) then {
			_nul = _trigger spawn {
			_tMarker = str (_this);
			_tMarker setMarkerText "STATIC TRIGGER (INACTIVE)";
			_tMarker setMarkerColor "ColorGreen";
		};
	};
	if (A3EAI_debugLevel > 0) then {diag_log format ["A3EAI Debug: Despawned AI units at %1. Reset trigger's group array to: %2.",(triggerText _trigger),_trigger getVariable "GroupArray"];};
} else {
	if (A3EAI_debugMarkersEnabled) then {
		deleteMarker (str (_trigger));
	};
	if (A3EAI_debugLevel > 0) then {diag_log format ["A3EAI Debug: Permanently deleting a static spawn at %1.",triggerText _trigger]};
	deleteVehicle _trigger;
};

true
