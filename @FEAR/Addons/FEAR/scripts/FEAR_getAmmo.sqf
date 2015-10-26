/*
	Return ammo for weapon, passed as argument
*/
private "_ret";
_ret = [] + getArray(configFile >> "cfgWeapons" >> _this >> "magazines");
_ret