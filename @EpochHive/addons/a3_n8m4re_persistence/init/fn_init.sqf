if !(isNil "N8M4RE_PERSISTENCE_START1")exitWith{false};
N8M4RE_PERSISTENCE_START1=true;
call compile preprocessFileLineNumbers "\x\addons\a3_n8m4re_persistence\init\scripts_compiles.sqf";
diag_log "[N8M4RE PERSISTENCE]: Init Compiles";
true
