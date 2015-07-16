if (typeName (_this select 1) == "ARRAY") then {
	{
		_magSize = (((_this select 1) select 1) select _forEachIndex);
		if( (typeName _x == "STRING") && (typeName _magSize == "SCALAR"))then {
			_magSizeMax = getNumber(configFile >> "CfgMagazines" >> _x >> "count");
			(_this select 0) addMagazineAmmoCargo[_x,floor(_magSize / _magSizeMax),_magSizeMax];
			if((_magSize % _magSizeMax)> 0)then{(_this select 0) addMagazineAmmoCargo[_x,1,floor(_magSize % _magSizeMax)];};
		};
	} forEach ((_this select 1) select 0);
};	
true
