{		
if (typeName _x isEqualTo "ARRAY") then {
	//diag_log format["AddWeaponCargo=%1",_x];
	if((count _x) >=4 ) then {
		// weapon
		if !((_x select 0) isEqualTo "" ) then {
			(_this select 0) addWeaponCargoGlobal[(_x select 0),1];
		};
		// suppressor
		if !((_x select 1) isEqualTo "") then {
			(_this select 0) addItemCargoGlobal[(_x select 1),1];
		};		
		// laser
		if !((_x select 2) isEqualTo "" ) then {
			(_this select 0) addItemCargoGlobal[(_x select 2),1];
		};
		// optics
		if !((_x select 3) isEqualTo "" ) then {
			(_this select 0) addItemCargoGlobal[(_x select 3),1];
		};	
		// magazine
		if ((count _x) >=5) then {
			if( typeName (_x select 4) isEqualTo "ARRAY" && (count(_x select 4)) >= 2) then { 
				(_this select 0) addMagazineAmmoCargo[((_x select 4)select 0), 1, ((_x select 4)select 1)];
			};
		};
	};
};	
} forEach (_this select 1);
true
