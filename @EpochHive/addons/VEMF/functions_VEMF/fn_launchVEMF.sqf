/*
	Author: Vampire

	Description:
	launches VEMF (duuuuuuuuuuuuuuuuh) :P
*/

_missionSpawner = [] spawn
{
	_version = ([["cfgPatches","VEMF"],["VEMF_version"]] call VEMF_fnc_getSetting) select 0;
	diag_log "///////////////////////////////////////////";
	["Launcher", 1, format["Starting version %1", _version]] call VEMF_fnc_log;
	diag_log "\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\";

	uiNamespace setVariable ["vemfUsedLocs", []];
	uiNamespace setVariable ["vemfHCload", []];
	[] spawn VEMF_fnc_checkLoot; // Check loot tables if enabled
	[] spawn VEMF_fnc_missionTimer; // Launch mission timer
};
