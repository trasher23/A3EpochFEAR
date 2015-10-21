// Earplugs code
removeAllActions inCaseofDeath;
removeAllActions theOneTrueName;
inCaseofDeath setVariable["HasEarplugMenu","hasNoMenu"];
theOneTrueName setVariable["HasEarplugMenu","hasNoMenu"];
1 fadeSound 1;
earplugsout = true;

systemChat "Your soul is dragged to HELL...";

(findDisplay 46) displayRemoveEventHandler["KeyDown", cmKeyPress];
