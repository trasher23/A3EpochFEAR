if (typeName (_this select 1) == "ARRAY") then {	
	{	
		_qty = (((_this select 1) select 1) select _forEachIndex);
		if ((typeName _x == "STRING")&&(typeName _qty == "SCALAR")) then {
			(_this select 0) addBackpackCargoGlobal [_x,(((_this select 1) select 1) select _forEachIndex)];
			
		};
	} forEach ((_this select 1) select 0);
};	
true
