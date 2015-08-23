/*
    Author: IT07

    Description:
    selects random element from given ARRAY

    Params:
    _this: ARRAY(s)

    Returns:
    ARRAY - result of random selection(s)
*/

private ["_array","_amount","_return"];
if not(typeName _this isEqualTo "ARRAY") exitWith { diag_log "VEMF_fnc_random ERROR: Given param _this NOT an ARRAY!"; };
if ((count _this) isEqualTo 0) exitWith { diag_log "VEMF_fnc_random ERROR: Given array has no elements!"; _return = false };
_return = _this select floor random count _this;
_return
