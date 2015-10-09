// Start earplugs code
5 fadeSound 1;
earplugsout = true;
removeAllActions inCaseofDeath;
removeAllActions theOneTrueName;
inCaseofDeath setVariable["HasEarplugMenu","hasNoMenu"];
theOneTrueName setVariable["HasEarplugMenu","hasNoMenu"];
player setVariable["Has_EPEH_Loop", "Yep"];
systemChat "Your soul is dragged to HELL...";

(findDisplay 46) displayRemoveEventHandler["KeyDown", cmKeyPress];
