waitUntil {isNull (objectParent player)};
waituntil {!isnull (finddisplay 46)};

// Earplugs code
0 fadeSound 1;
earplugsout=true;

waitUntil{(isPlayer player) && (alive player) && (!isNil "EPOCH_loadingScreenDone")};

// Start with apocalyptic environment
_sound = MISSION_directory + "FEAR\fx\dimensionfold.ogg";
playSound3D [_sound,player,false,getPosWorld player,1,0.5];
[] spawn FEAR_fnc_nukeFlash;
[] spawn FEAR_fnc_nukeAsh;

["run script: onPlayerRespawn"] call FEARserverLog;