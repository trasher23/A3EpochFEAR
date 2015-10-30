private ["_object","_xPos","_yPos"];

_object = _this select 0;
_xPos = getPos _object select 0;
_yPos = getPos _object select 1;
RadiationRadius = 1400;

[_object] execvm "FEAR\nuke\script\destroy.sqf";
[_xPos,_yPos] execvm "FEAR\nuke\script\escape.sqf";

// Nuke wind effect
NukeWindActive = true;
[] spawn FEAR_fnc_nukeWind;

sleep 2;

// Nuke blast sound fx
_nukeBlast = MISSION_directory + "FEAR\fx\" + "nuke.ogg";
playSound3D [_nukeBlast,player,false,_object,10,0.5,0];

// Earthquake
[4] spawn BIS_fnc_earthquake;

[_xPos,_yPos] execvm "FEAR\nuke\script\glare.sqf";
[_xPos,_yPos] execvm "FEAR\nuke\script\light.sqf";
[_xPos,_yPos] exec "FEAR\nuke\script\blast_1.sqs";
[_xPos,_yPos] exec "FEAR\nuke\script\blast1.sqs";
[_xPos,_yPos] exec "FEAR\nuke\script\hat.sqs";
[_xPos,_yPos] execvm "FEAR\nuke\script\aperture.sqf";
sleep 0.5;
[_xPos,_yPos] exec "FEAR\nuke\script\hatnod.sqs";
[_xPos,_yPos] exec "FEAR\nuke\script\blast1.sqs";
//[_xPos,_yPos] execvm "FEAR\nuke\script\damage.sqf";
[_xPos,_yPos] exec "FEAR\nuke\script\ring1.sqs";
sleep 0.5;
[_xPos,_yPos] exec "FEAR\nuke\script\ring2.sqs";
[_xPos,_yPos] exec "FEAR\nuke\script\blast2.sqs";
sleep 0.4;
[_xPos,_yPos] exec "FEAR\nuke\script\blast3.sqs";
sleep 5;
//[_xPos,_yPos] execvm "FEAR\nuke\script\heartbeat.sqf";
sleep 60;
[_xPos,_yPos] execvm "FEAR\nuke\script\dust.sqf";
[_xPos,_yPos] execvm "FEAR\nuke\script\snow.sqf";
sleep 300;
NukeWindActive = false; // Stop nuke wind
