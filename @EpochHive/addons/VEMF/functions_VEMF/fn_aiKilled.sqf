/*
	VEMF AI Killed by Vampire

	Description:
	 - Alerts Nearby AI to an AI Death
*/
private ["_unit","_killer","_tracker","_grpUnits"];

_unit = _this select 0;
_killer = _this select 1;
//_tracker = _unit getVariable ["VEMFUArray", "VEMFNoUArr"];
_remLaunchers = (["remLaunchers"] call VEMF_fnc_getSetting) select 0;
_launchers = (["aiLaunchers"] call VEMF_fnc_getSetting) select 0;

// Remove launcher if option is enabled
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
