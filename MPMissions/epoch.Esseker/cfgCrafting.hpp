class CfgCrafting
{
	class Default
	{
		usedIn[] = {};
		recipe[] = {};
		nearby[] = {};
	};
	class ItemCoolerE: Default{};
	class ItemCooler0 : Default
	{
		recipe[] = { "ItemCoolerE", { "SnakeMeat_EPOCH", 2 }, "sweetcorn_epoch" };
	};
	class ItemCooler1 : Default
	{
		recipe[] = { "ItemCoolerE", { "CookedRabbit_EPOCH", 2 }, "sweetcorn_epoch" };
	};
	class ItemCooler2 : Default
	{
		recipe[] = { "ItemCoolerE", "CookedChicken_EPOCH", "sweetcorn_epoch" };
	};
	class ItemCooler3 : Default
	{
		recipe[] = { "ItemCoolerE", "CookedGoat_EPOCH", "sweetcorn_epoch" };
	};
	class ItemCooler4 : Default
	{
		recipe[] = { "ItemCoolerE", "CookedSheep_EPOCH", "sweetcorn_epoch" };
	};
	class EnergyPack: Default
	{
		usedIn[] = {"EnergyPackLg"};
		nearby[] = {{ "fire",{ "ALL" },3,1,"Fire","fire" }};
		recipe[] = {{ "CircuitParts",1 },{ "clean_water_epoch",1 }};
	};
	class EnergyPackLg : Default
	{
		nearby[] = { { "fire", { "ALL" }, 3, 1, "Fire", "fire" } };
		recipe[] = { { "EnergyPack", 3 }, { "CircuitParts", 1 } };
	};

	class PartOre: Default
	{
		usedIn[] = {"ItemScraps"};
	};
	class ItemRock : Default
	{
		usedIn[] = { "KitFirePlace" , "MeleeMaul", "CrudeHatchet" };
	};
	class ItemStick : Default
	{
		usedIn[] = { "WoodClub","MeleeMaul", "CrudeHatchet", "KitFirePlace" };
		recipe[] = { { "WoodLog_EPOCH", 1 } };
	};
	class ItemKiloHemp : Default
	{
		usedIn[] = { "ItemRope" };
	};
	class MeleeMaul : Default
	{
		recipe[] = { { "ItemRock", 1 }, { "ItemStick", 2 }, { "ItemRope", 1 } };
	};
	class CrudeHatchet : Default
	{
		recipe[] = { { "ItemRock", 1 }, { "ItemStick", 1 }, { "ItemRope", 1 } };
	};
	class WoodClub : Default
	{
		recipe[] = { { "ItemStick", 2 } };
	};
	
	class WoodLog_EPOCH : Default
	{
		usedIn[] = { "PartPlankPack", "ItemStick" };
	};
	class MortarBucket : Default
	{
		usedIn[] = {"KitFoundation","KitCinderWall"};
	};
	
////// Custom Part start//////
	class ItemRope : Default
	{
		usedIn[] = { "WoodClub", "MeleeMaul", "CrudeHatchet", "V_10_EPOCH", "V_30_EPOCH", "V_39_EPOCH" };
		recipe[] = { { "ItemKiloHemp", 1 } };
	};
	class Pelt_EPOCH : Default
	{
		usedIn[] = { "KitTiPi", "V_10_EPOCH", "V_30_EPOCH", "V_39_EPOCH" };
	};
	class ItemScraps : Default
	{
		usedIn[] = { "ItemCorrugated", "optic_LRPS", "NVG_EPOCH", "optic_tws" };
		nearby[] = { { "fire", { "ALL" }, 3, 1, "Fire", "fire" } };
		recipe[] = { { "PartOre", 2 } };
	};
	class ItemCorrugated : Default
	{
		usedIn[] = {"KitShelf","ItemCorrugatedLg", "V_39_EPOCH", "VehicleRepairLg"};
		nearby[] = { { "fire", { "ALL" }, 3, 1, "Fire", "fire" } };
		recipe[] = { { "ItemScraps", 2 } };
	};
	class optic_LRPS : Default
	{
		recipe[] = { {"ItemScraps",2}, {"Binocular",1} };
		nearby[] = { { "fire", { "ALL" }, 3, 1, "Fire", "fire" } };
	};
	class optic_tws : Default
	{
		recipe[] = { {"ItemScraps",2}, {"Rangefinder",1}, { "CircuitParts", 1 } };
		nearby[] = { { "fire", { "ALL" }, 3, 1, "Fire", "fire" } };
	};
	class NVG_EPOCH : Default
	{
		recipe[] = { {"ItemScraps",1}, {"Binocular",1}, { "CircuitParts", 1 } };
		nearby[] = { { "fire", { "ALL" }, 3, 1, "Fire", "fire" } };
	};
	class Binocular : Default
	{
		usedIn[] = { "optic_LRPS", "NVG_EPOCH" };
	};
	class Rangefinder : Default
	{
		usedIn[] = { "optic_tws" };
	};
	class CircuitParts : Default
	{
		usedIn[] = { "NVG_EPOCH", "optic_tws", "EnergyPack", "EnergyPackLg", "KitPlotPole"};
	};
	class V_10_EPOCH : Default
	{
		recipe[] = { {"Pelt_EPOCH",1}, {"ItemRope",1} };
	};
		class V_30_EPOCH : Default
	{
		recipe[] = { {"Pelt_EPOCH",2}, {"ItemRope",2}, {"ItemScraps",1} };
		nearby[] = { { "fire", { "ALL" }, 3, 1, "Fire", "fire" } };
	};
		class V_39_EPOCH : Default
	{
		recipe[] = { {"Pelt_EPOCH",2}, {"ItemRope",2}, {"ItemCorrugated",1} };
		nearby[] = { { "fire", { "ALL" }, 3, 1, "Fire", "fire" } };
	};
	class SatchelCharge_Remote_Mag : Default
	{
		recipe[] = {{"HandGrenade",2}, {"ItemSilverBar",1}, {"ItemWatch",1}};
		nearby[] = {{ "fire", {"ALL"}, 3, 1, "Fire","fire" }}; 
	};
	class HandGrenade : Default
	{
		usedIn[] = { "SatchelCharge_Remote_Mag" };
	};
	class ItemSilverBar : Default
	{
		usedIn[] = { "SatchelCharge_Remote_Mag" };
	};
	class ItemWatch : Default
	{
		usedIn[] = { "SatchelCharge_Remote_Mag" };
	};
////// Custom Part end//////

	class CinderBlocks : Default
	{
		usedIn[] = { "KitCinderWall" };
	};
	class ItemMixOil : Default
	{
		usedIn[] = { "CSGAS" };
	};
	class jerrycan_epoch : Default
	{
		usedIn[] = { "CSGAS" };
	};
	class VehicleRepair : Default
	{
		usedIn[] = { "VehicleRepairLg" };
	};
	class VehicleRepairLg : Default
	{
		recipe[] = { "VehicleRepair", "ItemCorrugated" };
	};
	class EpochRadio0: Default
	{
		usedIn[] = {"EpochRadio1"};
	};
	class EpochRadio1: Default
	{
		usedIn[] = {"EpochRadio2"};
		recipe[] = {"EpochRadio0","ItemGarnet"};
	};
	class EpochRadio2: Default
	{
		usedIn[] = {"EpochRadio3"};
		recipe[] = {"EpochRadio1","ItemCitrine"};
	};
	class EpochRadio3: Default
	{
		usedIn[] = {"EpochRadio4"};
		recipe[] = {"EpochRadio2","ItemAmethyst"};
	};
	class EpochRadio4: Default
	{
		usedIn[] = {"EpochRadio5"};
		recipe[] = {"EpochRadio3","ItemTopaz"};
	};
	class EpochRadio5: Default
	{
		usedIn[] = {"EpochRadio6"};
		recipe[] = {"EpochRadio4","ItemSapphire"};
	};
	class EpochRadio6: Default
	{
		usedIn[] = {"EpochRadio7"};
		recipe[] = {"EpochRadio5","ItemOnyx"};
	};
	class EpochRadio7: Default
	{
		usedIn[] = {"EpochRadio8"};
		recipe[] = {"EpochRadio6","ItemEmerald"};
	};
	class EpochRadio8: Default
	{
		usedIn[] = {"EpochRadio9"};
		recipe[] = {"EpochRadio7","ItemRuby"};
	};
	class EpochRadio9: Default
	{
		recipe[] = {"EpochRadio8","ItemJade"};
	};
	// raw meats
	class SnakeCarcass_EPOCH : Default
	{
		usedIn[] = { "SnakeMeat_EPOCH" };
	};
	class SnakeMeat_EPOCH : Default
	{
		usedIn[] = { "ItemCooler0" };
		nearby[] = {{ "fire", {"ALL"}, 3, 1, "Fire","fire" }};
		recipe[] = { "SnakeCarcass_EPOCH" };
	};
	class RabbitCarcass_EPOCH : Default
	{
		usedIn[] = { "CookedRabbit_EPOCH" };
	};
	class CookedRabbit_EPOCH : Default
	{
		usedIn[] = { "ItemCooler1" };
		nearby[] = {{ "fire", {"ALL"}, 3, 1, "Fire","fire" }};
		recipe[] = { "RabbitCarcass_EPOCH" };
	};
	class ChickenCarcass_EPOCH : Default
	{
		usedIn[] = { "CookedChicken_EPOCH" };
	};
	class CookedChicken_EPOCH : Default
	{
		usedIn[] = { "ItemCooler2" };
		nearby[] = {{ "fire", {"ALL"}, 3, 1, "Fire","fire" }};
		recipe[] = { "ChickenCarcass_EPOCH" };
	};
	class GoatCarcass_EPOCH : Default
	{
		usedIn[] = { "CookedGoat_EPOCH" };
	};
	class CookedGoat_EPOCH : Default
	{
		usedIn[] = { "ItemCooler3" };
		nearby[] = {{ "fire", {"ALL"}, 3, 1, "Fire","fire" }};
		recipe[] = { "GoatCarcass_EPOCH" };
	};
	class SheepCarcass_EPOCH : Default
	{
		usedIn[] = { "CookedSheep_EPOCH" };
	};
	class CookedSheep_EPOCH : Default
	{
		usedIn[] = { "ItemCooler4" };
		nearby[] = {{ "fire", {"ALL"}, 3, 1, "Fire","fire" }};
		recipe[] = { "SheepCarcass_EPOCH" };
	};

	class emptyjar_epoch : Default
	{
		usedIn[] = { "water_epoch" };
	};
	class water_epoch : Default
	{
		usedIn[] = { "clean_water_epoch" };
		nearby[] = {{"noclass", {"barrelwater_f.p3d", "water_source_f.p3d", "pumpa.p3d", "misc_wellpump.p3d"}, 3, 1, "Water Source","water"}};
		recipe[] = { "emptyjar_epoch" };
	};
	class clean_water_epoch : Default
	{
		usedIn[] = {"EnergyPack"};
		nearby[] = {{ "fire",{ "ALL" },3,1,"Fire","fire" }};
		recipe[] = {"water_epoch"};
	};
	// recipes 
	class CSGAS : Default
	{
		recipe[] = { "ItemMixOil", "jerrycan_epoch" };
	};
	class ItemCorrugatedLg : Default
	{
		usedIn[] = { "KitPlotPole" };
		recipe[] = { { "ItemCorrugated", 3 } };
	};
	class PartPlankPack : Default
	{
		usedIn[] = {"KitStudWall","KitWoodFloor","KitWoodFoundation","KitWoodStairs","KitWoodRamp","KitTiPi"};
		recipe[] = {{"WoodLog_EPOCH",2}};
	};
	class KitFirePlace : Default
	{
		recipe[] = {{"ItemRock",2},{"ItemStick",1}};
	};
	class KitStudWall : Default
	{
		recipe[] = {{"PartPlankPack",4}};
	};
	class KitWoodFloor : Default
	{
		recipe[] = {{"PartPlankPack",4}};
	};
	class KitWoodRamp : Default
	{
		recipe[] = { { "PartPlankPack", 6 } };
	};
	class KitWoodStairs : Default
	{
		recipe[] = {{"PartPlankPack",4}};
	};
	class KitTiPi : Default
	{
		recipe[] = { { "Pelt_EPOCH", 4 }, { "PartPlankPack", 2 } };
	};
	class KitShelf : Default
	{
		recipe[] = {{"ItemCorrugated",3}};
	};
	class KitFoundation : Default
	{
		recipe[] = {{"MortarBucket",4}};
	};
	class KitWoodFoundation : Default
	{
		recipe[] = {{"PartPlankPack",8}};
	};
	
	class KitCinderWall : Default
	{
		recipe[] = {{ "CinderBlocks",2 },{ "MortarBucket",2 }};
	};
	class KitPlotPole : Default
	{
		recipe[] = {{"ItemCorrugatedLg",2}, {"CircuitParts",2} };
	};
};

