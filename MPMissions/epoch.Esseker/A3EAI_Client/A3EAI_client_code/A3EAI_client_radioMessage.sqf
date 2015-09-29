private ["_dialogueType", "_dialogueParams", "_paramCount", "_dialogueTextTemplate", "_dialogueTextFormat"];

_dialogueType = _this select 0;
_dialogueParams = _this select 1;

if (((diag_tickTime - (missionNamespace getVariable ["A3EAI_client_lastRadioMessage",-10])) > 10) or {_dialogueType in [20,30,31,32,33,34,35,41,42,43,44,45,51,52,53,54,55]}) then {
	_paramCount = (count _dialogueParams);
	_dialogueTextTemplate = missionNamespace getVariable [format ["A3EAI_client_radioMessage%1",_dialogueType],""];
	_dialogueTextFormat = call {
		if (_paramCount isEqualTo 0) exitWith {
			_dialogueTextTemplate
		};
		if (_paramCount isEqualTo 1) exitWith {
			format [_dialogueTextTemplate,_dialogueParams select 0]
		};
		if (_paramCount isEqualTo 2) exitWith {
			format [_dialogueTextTemplate,_dialogueParams select 0,_dialogueParams select 1]
		};
		""
	};
	if !(_dialogueTextFormat isEqualTo "") then {
		systemChat _dialogueTextFormat;
		if (A3EAI_client_radioSounds) then {
			playSound [format ["UAV_0%1",(floor (random 5) + 1)],false];
		};
		A3EAI_client_lastRadioMessage = diag_tickTime;
	};
};

true