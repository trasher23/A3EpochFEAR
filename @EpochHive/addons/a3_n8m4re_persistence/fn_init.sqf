if !(isNil "N8M4RE_PERSISTENCE_START1")exitWith{false};
N8M4RE_PERSISTENCE_START1=true;
diag_log "[N8M4RE PERSISTENCE]: Init Compiles";
call compile preprocessFileLineNumbers "\x\addons\a3_n8m4re_persistence\init\N8M4RE_Persistence_Init_Compiles.sqf";
true
