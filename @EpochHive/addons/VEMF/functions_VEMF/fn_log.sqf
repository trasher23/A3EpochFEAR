/*
    Author: IT07

    Description:
    will log given data if debug is enabled

    Params:
    _this: ARRAY - contains data required for logging
    _this select 0: STRING - prefix. Use "" if none
    _this select 1: SCALAR - 0 for error, 1 for info
    _this select 2: STRING - the thing to log

    Returns:
    nothing
*/

private ["_param","_prefix","_mode","_logThis","_logModesAllowed","_loggingEnabled"];
_loggingEnabled = "enableDebug" call VEMF_fnc_getSetting;
if (_loggingEnabled < 0) exitWith {}; // Silently fail if disabled
_logModesAllowed = [];
switch _loggingEnabled do
{
    case 0:
    {
        _logModesAllowed pushBack 0;
    };
    case 1:
    {
        _logModesAllowed pushBack 1;
    };
    case 2:
    {
        _logModesAllowed pushBack [0,1];
    };
};
_param = _this;
if not(typeName _param isEqualTo "ARRAY") exitWith { diag_log format["[VEMF] fn_handleDebug ERROR: _param (%1) is not an ARRAY!", _param]; };
_prefix = _this select 0;
_mode = _this select 1;
if (_mode < 0 OR _mode > 2) exitWith { diag_log format["[VEMF] fn_handleDebug ERROR: invalid _mode (%1) given! Use 0 for ERROR and 1 for INFO", _mode]; };
_logThis = _this select 2;
if (not(typeName _prefix isEqualTo "STRING") OR not(typeName _mode isEqualTo "SCALAR") OR not(typeName _logThis isEqualTo "STRING")) exitWith { diag_log"[VEMF] fn_handleDebug ERROR: incorrect params given! Can not log"; };

// Correct typenames given. Build log line and log it
switch (_mode) do
{
    case 0:
    {
        _mode = "ERROR";
    };
    case 1:
    {
        _mode = "INFO";
    };
    default{};
};
diag_log format["[VEMF] %1 %2: %3", _prefix, _mode, _logThis];
