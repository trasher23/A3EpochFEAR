waitUntil {!isNull player};
waitUntil {player == player};

while {true} do {
	_player = player;
	
	player addEventHandler ["Respawn", {
		player addVest "V_41_EPOCH";				
		player forceAddUniform "U_C_Poor_1";
		player addWeapon "EpochRadio0"; 
		player addWeapon "ItemMap";
		player addWeapon "ItemWatch";
		player addItemToBackpack "HeatPack";
		player addItemToBackpack "FirstAidKit";
		player addWeapon "hgun_Pistol_heavy_01_F";
		player addMagazine "11Rnd_45ACP_Mag";
		EPOCH_playerCrypto = 100;
	}];
	
	waitUntil {_player != player};
};
