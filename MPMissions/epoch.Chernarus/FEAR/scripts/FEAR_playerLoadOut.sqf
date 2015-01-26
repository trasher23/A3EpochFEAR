waitUntil {!isNull player};
waitUntil {player == player};

while {true} do {
	_player = player;
	
	player addEventHandler ["Respawn", {
		
		// Clothes
		_modelMale = (typeOF player == "Epoch_Male_F");
                _modelFemale = (typeOF player == "Epoch_Female_F");    

		if (_modelFemale) then {
			player forceAddUniform "U_BasicBodyFemale";
		};
		
		if (_modelMale) then {
			player forceAddUniform "U_C_Poor_1";
		};                                                    
                
                // Equipment
		player addVest "V_41_EPOCH";
		player addWeapon "EpochRadio0"; 
		player addWeapon "ItemMap";
		player addWeapon "ItemWatch";
		player addItemToBackpack "HeatPack";
		player addItemToBackpack "FirstAidKit";
		EPOCH_playerCrypto = 100;
	}];
	
	waitUntil {_player != player};
};
