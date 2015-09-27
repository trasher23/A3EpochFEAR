/*
	Spawn wolf pack
	Called from client FEAR_ambientFX.sqf
*/

private["_getTarget","_spawnPos","_wolfPos","_packSize","_wolf","_target","_id"];

_getTarget = {
	private["_wolf","_nrstTrgt","_lowDist","_currDist","_target","_range"];
	_wolf = _this select 0;
	_range = 200;
	_nrstTrgt = objNull;
	
	_nrTrgts = getPosATL _wolf nearEntities [["Epoch_Man_Base_F","Epoch_Female_base_F"], _range];
	_lowDist = _range;

	{
	if ((alive _x) && (isPlayer _x)) then {
	_currDist = _x distance _wolf;
		if (_currDist < _lowDist) then {
		_nrstTrgt = _x;
		_lowDist = _currDist;
		};
	};
	}forEach _nrTrgts;

	_target = _nrstTrgt;
	_target
};

_spawnPos = _this; // Starting location for wolfpack
_wolfPos = nil;
_packSize = 3 + floor(random 5); // Wolfpack size

// Spawn wolfpack	
diag_log format["[FEAR] spawning wolfpack at %1",_spawnPos];

for "_i" from 1 to _packSize do {			
	_wolfPos = [_spawnPos,[5,10],random 360] call SHK_pos; // Random spawn position for each wolf
	_wolf = createAgent["Alsatian_Random_EPOCH", _wolfPos, [], 5, "NONE"];
	_wolf setVariable["BIS_fnc_animalBehaviour_disable", true];
	
	EPOCH_TEMPOBJ_PVS = _wolf;
	publicVariableServer "EPOCH_TEMPOBJ_PVS";
	
	_target = [_wolf] call _getTarget;
	_id = [_wolf, _target] execFSM format["%1\scripts\ai_dog.fsm",FEAR_directory];

	diag_log format["[FEAR] spawned wolf at %1", _wolfPos];
	diag_log format["[FEAR] target: %1", _target];
};