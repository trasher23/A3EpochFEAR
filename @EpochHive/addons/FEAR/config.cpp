class CfgPatches 
{
	class FEAR 
	{
		units[] = {};
		weapons[] = {};
		requiredVersion = 1.0;
		FEARVersion = "1.0";
		requiredAddons[] = {"a3_epoch_code","a3_epoch_server"};
	};
};

class CfgFunctions 
{
	class FEAR 
	{
		class FEAR_Server 
		{
			file = "FEAR";
			class FEAR_init 
			{
				preInit = 1;
			};
		};
	};
};


class CfgAmmo 
{	
	// Exploding barrel
	class RocketBase;
	class R_PG32V_F: RocketBase {};
	class R_TBG32V_F: R_PG32V_F
	{
		hit = 100;
		indirectHit = 50;
		indirectHitRange = 5;
		model = "\A3\weapons_f\launchers\RPG32\tbg32v_rocket.p3d";
		CraterEffects = "ArtyShellCrater";
		ExplosionEffects = "MortarExplosion";
		allowAgainstInfantry = 1;
		class CamShakeExplode
		{
			power = "(110*0.2)";
			duration = "((round (110^0.5))*0.2 max 0.2)";
			frequency = 20;
			distance = "((5 + 110^0.5)*8)";
		};
	};
};

class CfgEnvSounds
{
	class Meadows
	{
		name = "NAM meadows";
		sound[] = {"",0,1};
		volume = "meadow*(1-rain)*(1-night)";
	};
};