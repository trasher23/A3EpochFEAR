/*
	VEMF AI Killed by Vampire, rewritten by IT07

	Description:
	removes launchers if desired and announces the kill if enabled in config.cpp
*/

private ["_unit","_killer","_unitType","_settings","_aiGear","_remLaunchers","_launchers","_say","_kMsg","_mags","_allowSmall"];
_unit = _this select 0;
_killer = _this select 1;
_say = if ("sayKilled" call VEMF_fnc_getSetting isEqualTo 1) then { true } else { false };
// Send kill message if enabled
if _say then
{
	if not(isPlayer _killer) exitWith {}; // Should prevent Error:NoUnit
	_kMsg = format["%1 was killed by %2", name _unit, name _killer];
	_sent = [_kMsg, "sys"] call VEMF_fnc_broadCast;
	if not(_sent) then { ["fn_broadCast", 0, "failed to send message to players"] call VEMF_fnc_log };
};

_settings = [["removeLaunchers","removeAIbodies"]] call VEMF_fnc_getSetting;
_launchers = ([["VEMFconfig","aiGear"],["aiLaunchers"]] call VEMF_fnc_getSetting) select 0;
_remLaunchers = _settings select 0;
if (_remLaunchers isEqualTo 1) then
{
	{
		if (_unit hasWeapon _x) then
		{
			_unit removeWeaponGlobal _x;
			_mags = getArray (configFile >> "cfgWeapons" >> _x >> "magazines");
			{
				if (_x in _mags) then
				{
					_unit removeMagazine _x;
				};
			} forEach (magazines _unit);
		};
	} forEach _launchers;
};

_killEffect = _settings select 1;
if (_killEffect isEqualTo 1) then
{
	playSound3D ["A3\Missions_F_Bootcamp\data\sounds\vr_shutdown.wss", _unit, false, getPosASL _unit, 2, 1, 60];
	for "_u" from 1 to 8 do
	{
		if not(isObjectHidden _unit) then
		{
			_unit hideObjectGlobal true;
		} else
		{
			_unit hideObjectGlobal false;
		};
		uiSleep 0.15;
	};

	_unit hideObjectGlobal true;
	removeAllWeapons _unit;
	// Automatic cleanup yaaay
	deleteVehicle _unit;
};
