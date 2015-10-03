_zombie = _this select 0

if !(isServer) then {goto "finish"}
if (ryanzombiesdeletiondemons == 0.7) then {goto "loopblufordemons"}
if (ryanzombiesdeletiondemons == 0.5) then {goto "loopopfordemons"}
if (ryanzombiesdeletiondemons == 0.3) then {goto "loopindepdemons"}
goto "finish"

#loopblufordemons
~15
_trg = createTrigger ["EmptyDetector", getpos _zombie]
_trg setTriggerArea [ryanzombiesdeletionradiusdemons, ryanzombiesdeletionradiusdemons, 0, false]
_trg setTriggerActivation ["WEST", "NOT PRESENT", false]
~2
if (triggeractivated _trg) then {goto "end"}
deletevehicle _trg
~15
goto "loopblufordemons"

#loopopfordemons
~15
_trg = createTrigger ["EmptyDetector", getpos _zombie]
_trg setTriggerArea [ryanzombiesdeletionradiusdemons, ryanzombiesdeletionradiusdemons, 0, false]
_trg setTriggerActivation ["EAST", "NOT PRESENT", false]
~2
if (triggeractivated _trg) then {goto "end"}
deletevehicle _trg
~15
goto "loopopfordemons"

#loopindepdemons
~15
_trg = createTrigger ["EmptyDetector", getpos _zombie]
_trg setTriggerArea [ryanzombiesdeletionradiusdemons, ryanzombiesdeletionradiusdemons, 0, false]
_trg setTriggerActivation ["GUER", "NOT PRESENT", false]
~2
if (triggeractivated _trg) then {goto "end"}
deletevehicle _trg
~15
goto "loopindepdemons"

#end
deletevehicle _trg
_zombie setdammage 1
~70 + random 40
deletevehicle _zombie

#finish