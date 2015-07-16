if(isNil "N8M4RE_PERSISTENCE_START2")then{
N8M4RE_PERSISTENCE_START2=true;
diag_log "[N8M4RE PERSISTENCE]: Init Scripts";
[]spawn{ call compile preprocessFileLineNumbers "\x\addons\a3_n8m4re_persistence\init\N8M4RE_Persistence_Init_Scripts.sqf";};
};
true
