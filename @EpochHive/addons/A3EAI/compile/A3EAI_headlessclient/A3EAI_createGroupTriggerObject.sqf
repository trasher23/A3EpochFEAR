#include "\A3EAI\globaldefines.hpp"

private ["_unitGroup","_trigger","_triggerPos"];
_unitGroup = _this select 0;
_triggerPos = _this select 1;

_trigger = createTrigger [TRIGGER_OBJECT,_triggerPos,false];
_unitGroup setVariable ["trigger",_trigger];

if (A3EAI_debugLevel > 1) then {diag_log format ["A3EAI Debug: Created group trigger object for %1 at %2.",_unitGroup,_triggerPos];};

_trigger