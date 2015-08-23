/*
    Author: IT07

    Description:
    handles the transfer of ownership to another given unit/client/object.
    Will transfer complete group to the same (new) owner.

    Params:
    _this: ARRAY - of GROUP(s) or OBJECT(s) - how many and which order does not matter. NOTE: given groups must be close to eachother for best performance balancing

    Returns:
    BOOLEAN - true if transfer was successful
*/

private ["_toTransfer","_hcSettings","_hcEnabled","_hcUIDs","_hcClients","_to","_transfer"];
_toTransfer = _this;
if not(typeName _toTransfer isEqualTo "ARRAY") exitWith
{
    ["fn_transferOwner", 0, "_toTransfer is not an ARRAY. Transfer failed!"] call VEMF_fnc_log; false
};
if (count _this isEqualTo 0) exitWith { ["fn_transferOwner", 0, "_toTransfer is EMPTY"] call VEMF_fnc_log; false };
// Check if HC is enabled
_hcSettings = [["VEMFconfig"],["allowHeadLessClient","hcUIDs"]] call VEMF_fnc_getSetting;
_hcEnabled = if ((_hcSettings select 0) isEqualTo 1) then { true } else { false };
_forceClients = uiNamespace getVariable "VEMF_forceAItoClients";
if not(isNil"_forceClients") then
{
    _hcEnabled = false;
    uiNamespace setVariable ["VEMF_forceAItoClients", nil];
};
if _hcEnabled then
{ // Gather the Headless Client(s)
    _hcUIDs = _hcSettings select 1;
    _hcClients = [];
    {
		if (typeOf _x isEqualTo "HeadlessClient_F") then // it is an HC
    	{
    		_hcClients pushBack [_x, owner _x];
        };
    } forEach playableUnits;
    if ((count _hcClients) isEqualTo 0) exitWith
    {
        ["fn_transferOwner", 0, "Failed to find Headless Clients! Falling back to default mode. (AI load-off to clients)"] call VEMF_fnc_log;
        _transfer = false; _recall = true;
        uiNamespace setVariable ["VEMF_forceAItoClients", true];
    };
    _to = call VEMF_fnc_headLessClient; // Select a random hc
} else
    {
        if (not(call VEMF_fnc_playerCount)) exitWith { _transfer = false; };
        _dist = 99999;
        {
            if (isPlayer _x AND (side _x) isEqualTo EAST) then
            {
                _pos = (position (leader (_toTransfer select floor random count _toTransfer))) distance _x;
                if (_pos < _dist) then
                { // Find the closest player
                    _dist = _pos;
                    _to = _x;
                };
            };
        } forEach playableUnits;
    };

if not isNil"_transfer" exitWith
{
    _transfer
};
{ // Do the transfer
    if (typeName _x isEqualTo "GROUP") then
    {
        _transfer = _x setGroupOwner (owner _to);
    };
    if (typeName _x isEqualTo "OBJECT") then
    {
        _transfer = _x setOwner (owner _to);
    };
} forEach _toTransfer;

_transfer // Return the value of this var to the calling script
