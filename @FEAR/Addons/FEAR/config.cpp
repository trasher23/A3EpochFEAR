class CfgPatches 
{
	class FEAR {
		units[] = {};
		weapons[] = {};
		requiredVersion = 1.0;
		FEARVersion = "1.0";
		requiredAddons[] = {"a3_epoch_code"};
	};
};

class CfgFunctions
{
	class FEAR 
	{
		class FEAR_Server 
		{
			file = "FEAR";	
			class FEAR_init { preInit = 1; };
		};
	};
	// Reinstate BIS mp functions
	class A3
	{
		tag = "BIS";
		class MP
		{
			file = "A3\functions_f\MP";
			class MP {
				file = "A3\functions_f\MP\fn_mp.sqf";
			};
			class MPexec {
				file = "A3\functions_f\MP\fn_MPexec.sqf";
			};
			class initMultiplayer {
				file = "A3\functions_f\MP\fn_initMultiplayer.sqf";
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

class cfgWorlds
{
	class CAWorld;
	class Esseker: CAWorld
	{
		class CfgEnvSounds;
		class EnvSounds: CfgEnvSounds
		{
			class Meadows // default - no trees, no sea, no hills ...
			{
				name = "Meadows";
				sound[]={"",0,1};
				soundNight[]={"",0,1};
			};
			class MeadowsNight // default - no trees, no sea, no hills ...
			{
				name = "Meadows Night";
				sound[]={"",0,1};
			};
			class Trees // trees
			{
				name = "Trees";
				sound[]={"",0,1};
				soundNight[]={"",0,1};
			};
			class TreesNight // trees
			{
				name = "Trees Night";
				sound[]={"",0,1};
			};
			class Hills
			{
				name = "Hills";
				sound[] = {"", 0, 1};
			};

			class HillsNight
			{
				name = "HillsNight";
				sound[] = {"", 0, 1};
				soundNight[] = {"", 0, 1};
			};
		};
	};
};