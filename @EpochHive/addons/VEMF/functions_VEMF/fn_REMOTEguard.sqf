/*
    Author: IT07

    Description:
    this function makes sure that AI spawned by VEMF does NOT become local to the server.
    On detection of a local group, it will reassign it to a client or Headless Client if enabled.

    Params:
    none, this is a Standalone function

    Returns:
    nothing
*/

[] spawn
{
    uiNamespace setVariable ["vemfHcLoad", []];
    uiNamespace setVariable ["vemfGroups", []];
    while {true} do
    {
        _groups = uiNamespace getVariable "vemfGroups";
        waitUntil { uiSleep 2; count _groups > 0 };
        {
            if (local _x) then
            {
                if ((count units _x) isEqualTo 0) exitWith
                {
                    deleteGroup _x;
                };
                // Group still has units, check if there is anyone that can be the owner
                for "_o" from 1 to 2 do
                {
                    _success = [_x] call VEMF_fnc_transferOwner;
                    if _success exitWith {};
                };
            };
        } forEach _groups;
    };
};
