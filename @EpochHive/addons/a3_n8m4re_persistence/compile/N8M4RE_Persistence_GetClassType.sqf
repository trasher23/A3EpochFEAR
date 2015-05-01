private ["_class","_classType","_kindOf"];
_class = _this select 0;
_classType = "UNKNOW";
if(isClass(configFile>>"CfgWeapons">>_class))then {_kindOf = [(configFile>>"CfgWeapons">>_class),true] call BIS_fnc_returnParents;if("ItemCore" in _kindOf) then {_classType = "ITEM";}else{_classType = "WEAPON";};};
if(isClass(configFile>>"cfgMagazines">>_class))then{_classType = "MAGAZINES";};
if((getText(configFile>>"cfgVehicles">>_class>>"vehicleClass")) == "Backpacks")then{_classType = "BACKPACKS";};
_classType
