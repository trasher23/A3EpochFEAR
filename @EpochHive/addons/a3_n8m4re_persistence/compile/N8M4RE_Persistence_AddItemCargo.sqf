//hint format["%1",_this select 2];
if (typeName (_this select 1) isEqualTo "ARRAY") then {
	{	
		_qty = (((_this select 1) select 1) select _forEachIndex);
		if ((typeName _x isEqualTo "STRING")&&(typeName _qty isEqualTo "SCALAR")) then {
			(_this select 0) addItemCargoGlobal [_x,(((_this select 1) select 1) select _forEachIndex)];
		};
	} forEach ((_this select 1) select 0);
};	
true
