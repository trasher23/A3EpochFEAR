//Return array of human players
private "_allPlayers";
// Get list of player-controlled units
_allPlayers = [];
{
	if (isPlayer _x) then {
		_allPlayers pushBack _x;
	};
}forEach playableUnits;
_allPlayers
