Thank you for downloading my Zombie AI!

Please note that this is a very early version of this AI. It
does not do work perfectly yet and can be buggy. Feel free to
report these bugs to me on Armaholic or the BI Forums.

To initialize the AI, put this line in the init of your zombie:
null = [this] execVM "shaun.sqf";
Make sure that it is not allied to you, or else it will not
attack you. This is on purpose so that zombies don't attack each
other.

This AI was inspired by DayZ and ShackTac's "Shacker".
The code was inspired by zorilya's CQC AI, I did not copy any of
his code though.
All sounds were recorded by me.

Feel free to change the code, sounds, etc and use it in your own
missions, but please mention me (BlueBär or BlueBaer) as the
creator of the AI and the sounds, I would greatly appreciate it.
________________________________________________________________

The way the zombies work:
The zombies can spot a player that is standing from 100m, less
when he is crouching or proning and even less when there is fog.
Zombies can see perfectly fine at nighttime though. Zombies
cannot see a player if he is behind it (their FOV is less than
180°), but they can smell him if he gets closer than 20m. The
zombie will then start attacking the player until the player or
the zombie dies - losing a zombie is not possible.

Planned features:
-Adding movement while idle
-Adding idle sounds
-Adding aggro sounds

Known bugs:
-Zombies can punch through walls and objects