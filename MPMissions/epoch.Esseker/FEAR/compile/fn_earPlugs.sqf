//============================================
// cmEarplugs Script - edited
// written by computermancer
// superfunserver.com
// switch technique inspired by mgm
//============================================

fnc_earplugs = {
	if (earplugsout) then {
		1 fadeSound 0.1;
		systemchat "Earplugs inserted.";
		earplugsout=false;
	} else {
		1 fadeSound 1;
		systemchat "Earplugs removed.";
		earplugsout=true;
	};
};

_earplugLoop = {
	while {true} do {
		
		waitUntil {uisleep 0.5; !isNull (objectParent player)}; // In vehicle
		
		_cm_whatImInATM = vehicle player;
		inCaseofDeath = _cm_whatImInATM;

		if (earplugsout) then {[] call fnc_earplugs};
		
		if (isNil {_cm_whatImInATM getVariable "HasEarplugMenu"}) then {_cm_whatImInATM setVariable["HasEarplugMenu", "hasNoMenu"];};
		
		_checkington = (_cm_whatImInATM getVariable "HasEarplugMenu");
		if (_checkington == "hasNoMenu") then {
			_null = _cm_whatImInATM addaction ["<img image='FEAR\earplugs.paa' /><t color=""#38eeff""> Earplugs</t>","[] call fnc_earplugs","",0,false,false,"","!isNull (objectParent player)"];							
			_cm_whatImInATM setVariable ["HasEarplugMenu","hasMenu"];
		};
			
		waitUntil {uisleep 0.5; isNull (objectParent player)}; 

		theOneTrueName = _cm_whatImInATM;
		theOneTrueName setVariable ["HasEarplugMenu","hasMenu"]; // On foot
		if (RemoveAutoEarplugs) then {
		if (!earplugsout) then {[] call fnc_earplugs};
		};
	};
};

if (hasInterface) then {[] spawn _earplugLoop};