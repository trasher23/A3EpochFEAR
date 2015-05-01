if !(isNil "SDROP_START1")exitWith{false};
SDROP_START1=true;
diag_log "[SDROP]: Init Compiles";
call compile preprocessFileLineNumbers "\x\addons\a3_sdrop\init\compiles.sqf";
true
