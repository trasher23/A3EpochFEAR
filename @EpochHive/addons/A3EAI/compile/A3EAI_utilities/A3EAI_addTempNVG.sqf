#include "\A3EAI\globaldefines.hpp"

if (_this hasWeapon NVG_ITEM_PLAYER) exitWith {false};
_this addWeapon NVG_ITEM_AI;

if (A3EAI_debugLevel > 1) then {diag_log format ["A3EAI Debug: Generated temporary NVGs for AI %1.",_this];};

true