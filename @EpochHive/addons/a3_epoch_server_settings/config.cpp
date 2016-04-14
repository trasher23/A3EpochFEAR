#include "BIS_AddonInfo.hpp"
/*
	Author: Aaron Clark - EpochMod.com

    Contributors:

	Description:
	Epoch Server Settings Config

    Licence:
    Arma Public License Share Alike (APL-SA) - https://www.bistudio.com/community/licenses/arma-public-license-share-alike

    Github:
    https://github.com/EpochModTeam/Epoch/tree/master/Sources/epoch_server_settngs/config.cpp
*/

#define _ARMA_

class CfgPatches {
	class A3_server_settings {
		units[] = {};
		weapons[] = {};
		requiredVersion = 0.1;
		epochVersion = "0.3.8.0";
		requiredAddons[] = {};
		#include "build.hpp"
	};
};

// inport loot tables
#include "configs\CfgMainTable.h"
#include "configs\CfgLootTable.h"
#include "configs\CfgLootTable_CUP.h"
// security checks
#include "configs\security\security_checks.h"
// props template
#include "configs\templates\CfgPropTemplate.h"

// import settings
class CfgEpochServer
{
	#include "\@epochhive\epochah.hpp"
	#include "\@epochhive\epochconfig.hpp"
};

// map config
class CfgEpoch
{
	class Default
	{
		worldSize = 12000;
		plantLimit = 10;
		vehicleSpawnTypes[] = {
			{"FlatAreaCity",1},
			{"FlatAreaCitySmall",1},
			{"NameCity",2},
			{"NameVillage",1},
			{"NameCityCapital",4},
			{"Airport",5}
		};
		traderBlds[] = {};
		containerPos[] = {};
		telePos[] = {};
		propsPos[] = {};
		staticNpcPos[] = {};
		allowedVehiclesList[] = {
		    // Boats
			{"C_Rubberboat_EPOCH",1},
			{"C_Rubberboat_02_EPOCH",1},
			{"C_Rubberboat_03_EPOCH",1},
			{"C_Rubberboat_04_EPOCH",1},
			{"C_Boat_Civil_01_EPOCH",1},
			{"jetski_epoch",1},

			// Bikes
			{"C_Quadbike_01_EPOCH",2},
			{"ebike_epoch",2},

			// Cars
			{"C_Offroad_01_EPOCH",2},
			{"C_Hatchback_01_EPOCH",2},
			{"C_Hatchback_02_EPOCH",2},
			{"C_SUV_01_EPOCH",2},

			{"B_G_Offroad_01_F",2},
			{"I_G_Offroad_01_F",2},
			{"I_G_Offroad_01_armed_F",2},

			// Vans
			{"C_Van_01_box_EPOCH",2},
			{"C_Van_01_transport_EPOCH",2},

			// Military Wheeled
			{"B_MRAP_01_EPOCH",2},
			{"O_MRAP_02_F",2},
			{"I_MRAP_03_F",2},
			{"B_UGV_01_rcws_F",2},
			{"I_MRAP_03_EPOCH",2},
			
			// Military Trucks
			{"B_Truck_01_transport_EPOCH",2},
			{"B_Truck_01_covered_EPOCH",2},
			{"B_Truck_01_mover_EPOCH",2},
			{"B_Truck_01_box_EPOCH",2},
			{"O_Truck_02_covered_EPOCH",2},
			{"O_Truck_02_transport_EPOCH",2},
			{"O_Truck_03_covered_EPOCH",2},
			{"O_Truck_02_box_EPOCH",2},
			{"O_Truck_03_ammo_F",2},
			{"O_Truck_03_fuel_F",2},
			{"O_Truck_03_medical_F",2},
			{"O_Truck_03_repair_F",2},

			// Helicopters
			{"B_Heli_Light_01_EPOCH",2},
			{"I_Heli_light_03_unarmed_EPOCH",2},
			{"O_Heli_Light_02_unarmed_EPOCH",2},
			{"O_Heli_Transport_04_F",2},
			{"O_Heli_Transport_04_medevac_F",2},
			{"I_Heli_light_03_unarmed_F",2},
			{"mosquito_epoch",10},
			{"B_Heli_Light_01_armed_F",2},
			{"O_Heli_Attack_02_black_F",2},
			{"C_Heli_Light_01_civil_EPOCH",5},
			{"C_Heli_Light_01_civil_F",2},
			{"O_Heli_Light_02_v2_F",2},

			// APC
			{"B_APC_Wheeled_01_cannon_F",2},
			{"I_APC_Wheeled_03_cannon_F",2},
			{"O_APC_Wheeled_02_rcws_F",2},
			{"I_APC_tracked_03_cannon_F",2},
			{"B_APC_Tracked_01_CRV_F",2},
			
			// Tanks
			{"O_MBT_02_cannon_F",2},
			{"B_MBT_01_arty_F",2},
			{"B_MBT_01_mlrs_F",2},
			
			// Planes
			{"B_Plane_CAS_01_F",2},
			{"O_Plane_CAS_02_F",2},
			
			/* MAS
			----------------
			*/
			
			// Tanks
			{"I_mas_T72B_Early_AAF_01",2},
			{"I_mas_T55_AAF_01",2},
			{"I_mas_ZSU_AAF_01",2},
			{"I_mas_T34_AAF_01",2},
			{"O_mas_ZSU_OPF_01",2},
			
			// APC
			{"I_mas_BMP1_AAF_01",2},
			{"O_mas_BMP2_Ambul_01",2},
			{"O_mas_BMP2_HQ_OPF_01",2},
			
			{"I_mas_BRDM2",2},
			{"I_mas_BTR60",2},
			{"O_mas_BRDM2",2},
			{"O_mas_BTR60",2},
			
			// Humvee
			{"B_mas_HMMWV_UNA",2},
			{"B_mas_HMMWV_Stinger_des",2},
			
			// Ural
			{"I_mas_cars_Ural_repair",2},
			{"I_mas_cars_Ural_fuel",2},
			{"O_mas_cars_Ural_repair",2},
			{"O_mas_cars_Ural_fuel",2},
			{"I_mas_cars_Ural_ammo",2},
			
			// Landrovers
			{"B_mas_cars_LR_Unarmed",5},
			{"B_mas_cars_LR_Med",5},
			{"B_mas_cars_LR_M2",2},
			{"B_mas_cars_LR_Mk19",2},
			{"B_mas_cars_LR_TOW",2},
			{"B_mas_cars_LR_Stinger",2},
			{"B_mas_cars_LR_SPG9",2},
			{"I_mas_cars_LR_soft_Unarmed",5},
			{"I_mas_cars_LR_soft_Med",5},
			{"I_mas_cars_LR_soft_M2",2},
			{"I_mas_cars_LR_soft_Mk19",2},
			{"I_mas_cars_LR_soft_TOW",2},
			{"I_mas_cars_LR_soft_Stinger",2},
			{"I_mas_cars_LR_soft_SPG9",2},
			
			// Helicopters
			{"I_mas_MI8",2},
			{"I_mas_MI8MTV",2},
			{"O_mas_MI8",2},
			{"O_mas_MI8MTV",2},
			{"I_mas_MI24V",2},
			{"O_mas_MI24V",2},
			{"B_mas_CH_47F",2},
			{"B_mas_UH1Y_F",2},
			{"B_mas_UH1Y_UNA_F",2},
			{"B_mas_UH1Y_MEV_F",2},
			{"B_mas_UH60M",2},
			{"B_mas_UH60M_SF",2},
			{"B_mas_UH60M_MEV",2}
		};
		allowedVehiclesList_CUP[] = {
			{"C_Offroad_01_EPOCH",4},
		    {"C_Quadbike_01_EPOCH",4},
		    {"C_Hatchback_01_EPOCH",5},
		    {"C_Hatchback_02_EPOCH",5},
		    {"C_SUV_01_EPOCH",5},
		    {"C_Rubberboat_EPOCH",2},
		    {"C_Rubberboat_02_EPOCH",2},
		    {"C_Rubberboat_03_EPOCH",2},
		    {"C_Rubberboat_04_EPOCH",2},
		    {"C_Van_01_box_EPOCH",4},
		    {"C_Van_01_transport_EPOCH",4},
		    {"C_Boat_Civil_01_EPOCH",5},
		    {"C_Boat_Civil_01_police_EPOCH",2},
		    {"C_Boat_Civil_01_rescue_EPOCH",2},
		    {"B_Heli_Light_01_EPOCH",2},
		    {"B_SDV_01_EPOCH",2},
		    {"B_MRAP_01_EPOCH",2},
			{"I_MRAP_03_EPOCH", 2},
		    {"B_Truck_01_transport_EPOCH",1},
		    {"B_Truck_01_covered_EPOCH",2},
		    {"B_Truck_01_mover_EPOCH",1},
		    {"B_Truck_01_box_EPOCH",1},
		    {"O_Truck_02_covered_EPOCH",2},
		    {"O_Truck_02_transport_EPOCH",1},
		    {"O_Truck_03_covered_EPOCH",1},
		    {"O_Truck_02_box_EPOCH",1},
		    {"I_Heli_light_03_unarmed_EPOCH",1},
		    {"O_Heli_Light_02_unarmed_EPOCH",1},
		    {"I_Heli_Transport_02_EPOCH",1},
		    {"O_Heli_Transport_04_EPOCH",1},
		    {"O_Heli_Transport_04_bench_EPOCH",1},
		    {"O_Heli_Transport_04_box_EPOCH",1},
		    {"O_Heli_Transport_04_covered_EPOCH",1},
		    {"B_Heli_Transport_03_unarmed_EPOCH",1},
		    {"jetski_epoch",3},
		    {"K01",1},
		    {"K02",1},
		    {"K03",1},
		    {"K04",1},
		    {"ebike_epoch",3},
		    {"mosquito_epoch",3},
			{"C_Heli_Light_01_civil_EPOCH",2},
			{"CUP_C_Fishing_Boat_Chernarus",2},
			{"CUP_C_LR_Transport_CTK",2},
			{"CUP_B_Zodiac_USMC",2},
			{"CUP_C_Skoda_Red_CIV",2},
			{"CUP_C_Skoda_White_CIV",2},
			{"CUP_C_Skoda_Blue_CIV",2},
			{"CUP_C_Skoda_Green_CIV",2},
			{"CUP_C_SUV_CIV",2},
			{"CUP_B_HMMWV_Transport_USA",2},
			{"CUP_B_HMMWV_Unarmed_USA",2},
			{"CUP_C_SUV_TK",2},
			{"CUP_B_LR_Transport_CZ_D",2},
			{"CUP_C_Datsun_Covered",2},
			{"CUP_C_Datsun_Plain",2},
			{"CUP_C_Datsun_Tubeframe",2},
			{"CUP_C_Datsun_4seat",2},
			{"CUP_C_Datsun",2},
			{"CUP_C_Golf4_green_Civ",2},
			{"CUP_C_Golf4_red_Civ",2},
			{"CUP_C_Golf4_blue_Civ",2},
			{"CUP_C_Golf4_black_Civ",2},
			{"CUP_C_Golf4_kitty_Civ",2},
			{"CUP_C_Golf4_reptile_Civ",2},
			{"CUP_C_Golf4_camodigital_Civ",2},
			{"CUP_C_Golf4_camodark_Civ",2},
			{"CUP_C_Golf4_camo_Civ",2},
			{"CUP_B_M1030",2},
			{"CUP_C_Ural_Civ_03",2},
			{"CUP_C_Ural_Open_Civ_03",2},
			{"CUP_C_Ural_Civ_02",2},
			{"CUP_B_TowingTractor_USMC",2},
			{"CUP_C_C47_CIV",2},
			{"CUP_B_LR_Transport_CZ_W",2},
			{"CUP_C_Golf4_white_Civ",2},
			{"CUP_C_Golf4_whiteblood_Civ",2},
			{"CUP_C_Golf4_yellow_Civ",2},
			{"CUP_C_Octavia_CIV",2},
			{"CUP_C_Ural_Civ_01",2},
			{"CUP_C_Ural_Open_Civ_01",2},
			{"CUP_B_Ural_CDF",2},
			{"CUP_B_Ural_Open_CDF",2},
			{"CUP_C_Ural_Open_Civ_02",2},
			{"CUP_B_HMMWV_Ambulance_USA",2},
			{"CUP_C_UAZ_Unarmed_TK_CIV",2},
			{"CUP_C_UAZ_Open_TK_CIV",2},
			{"CUP_B_UAZ_Unarmed_CDF",2},
			{"CUP_B_Ural_Empty_CDF",2},
			{"CUP_C_DC3_CIV",2}
		};
	};
	#include "configs\maps\bornholm.h"
	#include "configs\maps\stratis.h"
	#include "configs\maps\altis.h"
	#include "configs\maps\chernarus.h"
	#include "configs\maps\chernarus_summer.h"
	#include "configs\maps\australia.h"
	#include "configs\maps\takistan.h"
	#include "configs\maps\Zargabad.h"
	#include "configs\maps\esseker.h"
	#include "configs\maps\Sara.h"
	#include "configs\maps\SaraLite.h"
	#include "configs\maps\Sara_dbe1.h"
	#include "configs\maps\Bootcamp_ACR.h"
	#include "configs\maps\Desert_E.h"
	#include "configs\maps\Mountains_ACR.h"
	#include "configs\maps\Porto.h"
	#include "configs\maps\ProvingGrounds_PMC.h"
	#include "configs\maps\Shapur_BAF.h"
	#include "configs\maps\Utes.h"
	#include "configs\maps\Woodland_ACR.h"
	#include "configs\maps\Napf.h"
};
