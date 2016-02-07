class FEAR
{
	tag = "FEAR";
	class FEARclient
	{
		file = "FEAR\functions";
		class nukeDetonate {};
		class nukeSiren {};
		class nukeFlash {};
		class hasGasMask {};
		class nukeGeiger {};
		class nukeColorCorrection {};
		class nukeAsh {};
		class incomingMissile {};
		class ambientFx { postInit = 1; };
		class statusBar { postInit = 1; };
		class clientLoop { postInit = 1; };
		class earPlugs { postInit = 1; };
	};
};