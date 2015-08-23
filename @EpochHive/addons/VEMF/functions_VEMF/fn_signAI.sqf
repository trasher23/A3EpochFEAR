/*
    Author: IT07

    Description:
    marks given group(s) as VEMF AI which will then be used by REMOTEguard for monitor of groupOwner

    Params:
    _this: ARRAY
    _this select 0: GROUP - group to sign as VEMF AI
*/

if not(typeName _this isEqualTo "ARRAY") exitWith { ["fn_signAI", 0, "_this is not an ARRAY!"] call VEMF_fnc_log };
private["_signed","_abort"];
_signed = [];
for "_g" from 1 to (count _this) do
{
    _group = [_this, _g-1, grpNull, [grpNull]] call BIS_fnc_param;
    if (isNull _group) exitWith { ["fn_signAI", 0, "encountered null Group!"] call VEMF_fnc_log; _abort = true; };
    (uiNamespace getVariable "vemfGroups") pushBack _group;
    _signed pushBack _group;
};
if not isNil"_abort" exitWith { false };
true
