if(isNil "SDROP_START2")then{
SDROP_START2=true;
[]spawn{ call compile preprocessFileLineNumbers "\x\addons\a3_sdrop\init\scripts_init.sqf"; };
};
true
