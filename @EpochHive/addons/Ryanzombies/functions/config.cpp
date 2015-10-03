class CfgPatches
{
	class ryanzombiesfunctions
	{
		units[]=
		{
			"RyanZM_ModuleSpawn",
			"RyanZM_ModuleSpawner",
			"RyanZM_ModuleSpawnerDemon",
			"RyanZM_ModuleZombieHealth",
			"RyanZM_ModuleZombieDeletion",
			"RyanZM_ModuleInfection"
		};
		weapons[]={};
		requiredVersion=0;
		requiredAddons[]=
		{
			"A3_Modules_F"
		};
		version="1.0";
		projectName="ryanzombiesfunctions";
		author="Ryan";
	};
};

class CfgVehicles
{
	class Logic {};
	class Module_F: Logic
	{
		class ModuleDescription {};
	};
	class RyanZM_ModuleSpawn: Module_F
	{
		author="Ryan";
		_generalMacro="RyanZM_ModuleSpawn";
		scope=2;
		displayName="Spawner";
		category="Ryanzombiesfactionmodule";
		function="RyanZM_fnc_rzfunctionspawn";
		isGlobal=1;
		class Arguments
		{
			class Side
			{
				displayName="Side";
				description="Zombies will spawn on the selected side.";
				typeName="Number";
				class values
				{
					class indep	{name = "Independent"; value = 0.9; default = 1;};
					class opfor	{name = "Opfor"; value = 0.7; default = 0;};
					class blufor	{name = "Blufor"; value = 0.5; default = 0;};
				};
			};
			class Type
			{
				displayName="Type";
				description="Type of zombies that will be spawned.";
				typeName="Number";
				class values
				{
					class type1	{name = "Fast - Civilians"; value = 0.9; default = 1;};
					class type2	{name = "Fast - Soldiers"; value = 0.85; default = 0;};
					class type3	{name = "Fast - Civilians & Soldiers"; value = 0.8; default = 0;};
					class type4	{name = "Medium - Civilians"; value = 0.75; default = 0;};
					class type5	{name = "Medium - Soldiers"; value = 0.7; default = 0;};
					class type6	{name = "Medium - Civilians & Soldiers"; value = 0.65; default = 0;};
					class type7	{name = "Slow - Civilians"; value = 0.6; default = 0;};
					class type8	{name = "Slow - Soldiers"; value = 0.55; default = 0;};
					class type9	{name = "Slow - Civilians & Soldiers"; value = 0.5; default = 0;};
					class type10	{name = "DEMONS"; value = 0.45; default = 0;};
					class type11	{name = "SPIDER ZOMBIES"; value = 0.4; default = 0;};
					class type12	{name = "Zombies (MIXED)"; value = 0.35; default = 0;};
					class type13	{name = "Zombies (MIXED) - No Spiders"; value = 0.3; default = 0;};
				};
			};
			class Activation
			{
				displayName="Activation";
				description="Zombies will only spawn based on the selected option.";
				typeName="Number";
				class values
				{
					class normal	{name = "Default (Always)"; value = 0.9; default = 1;};
					class blufor	{name = "Blufor Present"; value = 0.7; default = 0;};
					class opfor	{name = "Opfor Present"; value = 0.5; default = 0;};
					class indep	{name = "Independent Present"; value = 0.3; default = 0;};
				};
			};
			class Activation2
			{
				displayName="Activation";
				description="Zombies will only spawn based on the selected option.";
				typeName="Number";
				class values
				{
					class normal	{name = "Same As Above"; value = 0.9; default = 1;};
					class blufor	{name = "Blufor Present"; value = 0.7; default = 0;};
					class opfor	{name = "Opfor Present"; value = 0.5; default = 0;};
					class indep	{name = "Independent Present"; value = 0.3; default = 0;};
				};
			};
			class ActivationRadius
			{
				displayName="Activation Radius";
				description="Distance in metres the selected side must be present to the spawner. Nothing changes if default is selected.";
				typeName="Number";
				defaultValue=100;
			};
			class AliveAmount
			{
				displayName="Alive Zombies Cap";
				description="When the limit is reached, spawning is paused until a zombie dies.";
				typeName="Number";
				defaultValue=100;
			};
			class TotalAmount
			{
				displayName="Total Zombies Cap";
				description="When the limit is reached, spawning is stopped completely.";
				typeName="Number";
				defaultValue=10000;
			};
			class Start
			{
				displayName="First Horde Delay";
				description="The delay in seconds before this spawner starts working.";
				typeName="Number";
				defaultValue=5;
			};
			class Frequency
			{
				displayName="Spawned Horde Delay";
				description="The delay in seconds before a new horde starts spawning.";
				typeName="Number";
				defaultValue=60;
			};
			class Delay
			{
				displayName="Spawned Zombie Delay";
				description="The delay in seconds between each zombie being spawned into its horde.";
				typeName="Number";
				defaultValue=0.5;
			};
			class Density
			{
				displayName="Spawned Horde Density";
				description="A random distance in metres zombies will spawn from the spawner.";
				typeName="Number";
				defaultValue=0;
			};
			class HordeSize
			{
				displayName="Zombies Per Horde";
				description="The amount of zombies spawned into each horde.";
				typeName="Number";
				defaultValue=14;
			};
		};
		class ModuleDescription: ModuleDescription
		{
			position=1;
			description="This module will spawn zombies wherever you place it. The settings you choose only affect this spawner.";
		};
	};
	class RyanZM_ModuleSpawner: Module_F
	{
		author="Ryan";
		_generalMacro="RyanZM_ModuleSpawner";
		scope=2;
		displayName="Game Logic Spawner Settings: Zombies";
		category="Ryanzombiesfactionmodule";
		function="RyanZM_fnc_rzfunctionspawner";
		isGlobal=1;
		class Arguments
		{
			class Amount
			{
				displayName="Alive Zombies Cap";
				description="When the limit is reached, spawning is paused until a zombie dies.";
				typeName="Number";
				defaultValue=100;
			};
			class TotalAmount
			{
				displayName="Total Zombies Cap";
				description="When the limit is reached, spawning is stopped completely.";
				typeName="Number";
				defaultValue=10000;
			};
			class Start
			{
				displayName="First Horde Delay";
				description="The delay in seconds before the spawner starts working.";
				typeName="Number";
				defaultValue=5;
			};
			class Frequency
			{
				displayName="Spawned Horde Delay";
				description="The delay in seconds before a new horde starts spawning.";
				typeName="Number";
				defaultValue=60;
			};
			class Delay
			{
				displayName="Spawned Zombie Delay";
				description="The delay in seconds between each zombie being spawned into its horde.";
				typeName="Number";
				defaultValue=0.5;
			};
			class Density
			{
				displayName="Spawned Horde Density";
				description="A random distance in metres zombies will spawn from the game logic.";
				typeName="Number";
				defaultValue=0;
			};
			class Activation
			{
				displayName="Activation";
				description="Zombies will only spawn based on the selected option.";
				typeName="Number";
				class values
				{
					class normal	{name = "Default (Always)"; value = 0.9; default = 1;};
					class blufor	{name = "Blufor Present"; value = 0.7; default = 0;};
					class opfor	{name = "Opfor Present"; value = 0.5; default = 0;};
					class indep	{name = "Independent Present"; value = 0.3; default = 0;};
				};
			};
			class ActivationRadius
			{
				displayName="Activation Radius";
				description="Distance in metres the selected side must be present to the spawner. Nothing changes if default is selected.";
				typeName="Number";
				defaultValue=100;
			};
			class HordeSize
			{
				displayName="Zombies Per Horde";
				description="The amount of zombies spawned into each horde.";
				typeName="Number";
				defaultValue=14;
			};
		};
		class ModuleDescription: ModuleDescription
		{
			position=1;
			description="This module changes the way the Horde Spawner Game Logics work for the zombies. The game logics will use the default settings if this module isn't used.";
		};
	};
	class RyanZM_ModuleSpawnerDemon: Module_F
	{
		author="Ryan";
		_generalMacro="RyanZM_ModuleSpawnerDemon";
		scope=2;
		displayName="Game Logic Spawner Settings: Demons";
		category="Ryanzombiesfactionmodule";
		function="RyanZM_fnc_rzfunctionspawnerdemon";
		isGlobal=1;
		class Arguments
		{
			class Amount
			{
				displayName="Alive Demons Cap";
				description="When the limit is reached, spawning is paused until a demon dies.";
				typeName="Number";
				defaultValue=100;
			};
			class TotalAmount
			{
				displayName="Total Demons Cap";
				description="When the limit is reached, spawning is stopped completely.";
				typeName="Number";
				defaultValue=10000;
			};
			class Start
			{
				displayName="First Horde Delay";
				description="The delay in seconds before the spawner starts working.";
				typeName="Number";
				defaultValue=5;
			};
			class Frequency
			{
				displayName="Spawned Horde Delay";
				description="The delay in seconds before a new horde starts spawning.";
				typeName="Number";
				defaultValue=60;
			};
			class Delay
			{
				displayName="Spawned Demon Delay";
				description="The delay in seconds between each demon being spawned into its horde.";
				typeName="Number";
				defaultValue=0.5;
			};
			class Density
			{
				displayName="Spawned Horde Density";
				description="A random distance in metres demons will spawn from the game logic.";
				typeName="Number";
				defaultValue=0;
			};
			class ActivationDemon
			{
				displayName="Activation";
				description="Demons will only spawn based on the selected option.";
				typeName="Number";
				class values
				{
					class normal	{name = "Default (Always)"; value = 0.9; default = 1;};
					class blufor	{name = "Blufor Present"; value = 0.7; default = 0;};
					class opfor	{name = "Opfor Present"; value = 0.5; default = 0;};
					class indep	{name = "Independent Present"; value = 0.3; default = 0;};
				};
			};
			class ActivationRadiusDemon
			{
				displayName="Activation Radius";
				description="Distance in metres the selected side must be present to the spawner. Nothing changes if default is selected.";
				typeName="Number";
				defaultValue=100;
			};
			class HordeSize
			{
				displayName="Demons Per Horde";
				description="The amount of demons spawned into each horde.";
				typeName="Number";
				defaultValue=14;
			};
		};
		class ModuleDescription: ModuleDescription
		{
			position=1;
			description="This module changes the way the Horde Spawner Game Logics work for the demons. The game logics will use the default settings if this module isn't used.";
		};
	};
	class RyanZM_ModuleZombieHealth: Module_F
	{
		author="Ryan";
		_generalMacro="RyanZM_ModuleZombieHealth";
		scope=2;
		displayName="Max Health Settings";
		category="Ryanzombiesfactionmodule";
		function="RyanZM_fnc_rzfunctionzombiehealth";
		isGlobal=1;
		class Arguments
		{
			class ZombieMaxHealth
			{
				displayName="Zombies Max Health";
				description="Changes the max health of the zombies.";
				typeName="Number";
				class values
				{
					class normal	{name = "Default"; value = 0.7; default = 1;};
					class stronger	{name = "Stronger"; value = 0.5; default = 0;};
					class weaker	{name = "Weaker"; value = 0.9; default = 0;};
					class weakest	{name = "Weakest"; value = 0.97; default = 0;};
				};
			};
			class DemonMaxHealth
			{
				displayName="Demons Max Health";
				description="Changes the max health of the demons.";
				typeName="Number";
				class values
				{
					class normal	{name = "Default"; value = 0.7; default = 1;};
					class stronger	{name = "Stronger"; value = 0.5; default = 0;};
					class weaker	{name = "Weaker"; value = 0.9; default = 0;};
					class weakest	{name = "Weakest"; value = 0.97; default = 0;};
				};
			};
		};
		class ModuleDescription: ModuleDescription
		{
			position=1;
			description="This module changes the max health for the zombies and demons. The zombies and demons will have default max health if this module isn't used.";
		};
	};
	class RyanZM_ModuleZombieDeletion: Module_F
	{
		author="Ryan";
		_generalMacro="RyanZM_ModuleZombieDeletion";
		scope=2;
		displayName="Deletion Settings";
		category="Ryanzombiesfactionmodule";
		function="RyanZM_fnc_rzfunctionzombiedeletion";
		isGlobal=1;
		class Arguments
		{
			class Deletion
			{
				displayName="Delete Zombies";
				description="Zombies are deleted when the selected side is not present from the zombie.";
				typeName="Number";
				class values
				{
					class normal	{name = "Default (Never)"; value = 0.9; default = 1;};
					class blufor	{name = "Blufor Not Present"; value = 0.7; default = 0;};
					class opfor	{name = "Opfor Not Present"; value = 0.5; default = 0;};
					class indep	{name = "Independent Not Present"; value = 0.3; default = 0;};
				};
			};
			class DeletionRadius
			{
				displayName="Delete Zombies Radius";
				description="Distance in metres the selected side must be not present to the zombies location. Nothing changes if default is selected.";
				typeName="Number";
				defaultValue=1000;
			};
			class DeletionDemons
			{
				displayName="Delete Demons";
				description="Demons are deleted when the selected side is not present from the demon.";
				typeName="Number";
				class values
				{
					class normal	{name = "Default (Never)"; value = 0.9; default = 1;};
					class blufor	{name = "Blufor Not Present"; value = 0.7; default = 0;};
					class opfor	{name = "Opfor Not Present"; value = 0.5; default = 0;};
					class indep	{name = "Independent Not Present"; value = 0.3; default = 0;};
				};
			};
			class DeletionRadiusDemons
			{
				displayName="Delete Demons Radius";
				description="Distance in metres the selected side must be not present to the demons location. Nothing changes if default is selected.";
				typeName="Number";
				defaultValue=1000;
			};
		};
		class ModuleDescription: ModuleDescription
		{
			position=1;
			description="This module allows zombies and demons to be deleted if the selected side is not present from the zombie or demons location. Zombies and demons are never deleted if this module isn't used (except for if the 'Dead Bodies Deleted' Game Logic is used).";
		};
	};
	class RyanZM_ModuleInfection: Module_F
	{
		author="Ryan";
		_generalMacro="RyanZM_ModuleInfection";
		scope=2;
		displayName="Infection Settings";
		category="Ryanzombiesfactionmodule";
		function="RyanZM_fnc_rzfunctioninfection";
		isGlobal=1;
		class Arguments
		{
			class Infection
			{
				displayName="Resurrect as";
				description="Victims will resurrect into the selected zombie type.";
				typeName="Number";
				class values
				{
					class fast	{name = "Fast Zombies"; value = 0.9; default = 1;};
					class medium	{name = "Medium Zombies"; value = 0.7; default = 0;};
					class slow	{name = "Slow Zombies"; value = 0.5; default = 0;};
					class demons	{name = "Demons"; value = 0.3; default = 0;};
					class spiders	{name = "Spider Zombies"; value = 0.1; default = 0;};
				};
			};
			class InfectionTimer
			{
				displayName="Infection Timer";
				description="The time it takes after the victim has died to resurrect.";
				typeName="Number";
				defaultValue=30;
			};
			class Uniform
			{
				displayName="Force Add Uniform";
				description="Forces the victims to resurrect with the victims uniform, however this stops the custom animations from working.";
				typeName="Number";
				class values
				{
					class no	{name = "No"; value = 0.9; default = 1;};
					class yes	{name = "Yes"; value = 0.7; default = 0;};
				};
			};
		};
		class ModuleDescription: ModuleDescription
		{
			position=1;
			description="This module allows victims of zombie attacks to resurrect as zombies.";
		};
	};
};

class CfgFunctions
{
	class RyanZM
	{
		class Ryanzombiesfactionmodule
		{
			class rzfunctionspawn
			{
				file = "\ryanzombies\functions\fn_ModuleSpawn.sqf";
			};
			class rzfunctionspawner
			{
				file = "\ryanzombies\functions\fn_ModuleSpawner.sqf";
			};
			class rzfunctionspawnerdemon
			{
				file = "\ryanzombies\functions\fn_ModuleSpawnerDemon.sqf";
			};
			class rzfunctionzombiehealth
			{
				file = "\ryanzombies\functions\fn_ModuleZombieHealth.sqf";
			};
			class rzfunctionzombiedeletion
			{
				file = "\ryanzombies\functions\fn_ModuleZombieDeletion.sqf";
			};
			class rzfunctioninfection
			{
				file = "\ryanzombies\functions\fn_ModuleInfection.sqf";
			};
		};
	};
};