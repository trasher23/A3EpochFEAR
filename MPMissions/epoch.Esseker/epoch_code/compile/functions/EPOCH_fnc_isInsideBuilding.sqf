/*
	Author: Aaron Clark - EpochMod.com

    Contributors:

	Description:
	Function to check if player is in a building.

    Licence:
    Arma Public License Share Alike (APL-SA) - https://www.bistudio.com/community/licenses/arma-public-license-share-alike

    Github:
    https://github.com/EpochModTeam/Epoch/tree/master/Sources/epoch_code/compile/functions/EPOCH_fnc_isInsideBuilding.sqf

    Example:
    _inBuilding = call EPOCH_fnc_isInsideBuilding;

    Parameter(s):
		NONE

	Returns:
	BOOL
*/
private ["_playerPosASL","_abovePlayerPosASL"];
_playerPosASL = visiblePositionASL player;
_abovePlayerPosASL = [_playerPosASL select 0,_playerPosASL select 1,(_playerPosASL select 2) + 10];
//Return:
lineIntersects[_playerPosASL, _abovePlayerPosASL, player]
