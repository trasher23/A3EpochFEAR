_zombie = _this select 0

if !(isServer) then {goto "finish"}
if (ryanzombiesdeletion == 0.7) then {goto "loopblufor"}
if (ryanzombiesdeletion == 0.5) then {goto "loopopfor"}
if (ryanzombiesdeletion == 0.3) then {goto "loopindep"}
goto "finish"

#loopblufor
~15
_trg = createTrigger ["EmptyDetector", getpos _zombie]
_trg setTriggerArea [ryanzombiesdeletionradius, ryanzombiesdeletionradius, 0, false]
_trg setTriggerActivation ["WEST", "NOT PRESENT", false]
~2
if (triggeractivated _trg) then {goto "end"}
deletevehicle _trg
~15
goto "loopblufor"

#loopopfor
~15
_trg = createTrigger ["EmptyDetector", getpos _zombie]
_trg setTriggerArea [ryanzombiesdeletionradius, ryanzombiesdeletionradius, 0, false]
_trg setTriggerActivation ["EAST", "NOT PRESENT", false]
~2
if (triggeractivated _trg) then {goto "end"}
deletevehicle _trg
~15
goto "loopopfor"

#loopindep
~15
_trg = createTrigger ["EmptyDetector", getpos _zombie]
_trg setTriggerArea [ryanzombiesdeletionradius, ryanzombiesdeletionradius, 0, false]
_trg setTriggerActivation ["GUER", "NOT PRESENT", false]
~2
if (triggeractivated _trg) then {goto "end"}
deletevehicle _trg
~15
goto "loopindep"

#end
deletevehicle _trg
_zombie setdammage 1
~70 + random 40
deletevehicle _zombie

#finish