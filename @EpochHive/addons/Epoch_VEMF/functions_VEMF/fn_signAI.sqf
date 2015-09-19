/*
    Author: IT07

    Description:
    marks given group(!) as VEMF AI which will then be used by REMOTEguard for monitor of groupOwner

    Params:
    _this: ARRAY
    _this select 0: GROUP - group to sign as VEMF AI

    Returns:
    BOOL - true if OK
*/

private["_signed","_abort"];
_ok = false;
_group = [_this, 0, grpNull, [grpNull]] call BIS_fnc_param;
if not isNull _group then
{
    (uiNamespace getVariable "vemfGroups") pushBack _group;
    _ok = true
};
_ok
