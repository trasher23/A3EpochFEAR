/*
	spawn dialog location settings
	By Halv
	
	Copyright (C) 2015  Halvhjearne > README.md
*/

//allow spawn near players jammer? only one is registered, so no point in multiple jammers
//I have had reports about players not loading when using this, so if you have problems, try to set this to false
_spawnNearJammer = true;
//this is the area to search for jammers, reduce if you do not want players spawning on the edge of the map
//Increas with care as it can increase load times with high numbers default: 10000
_jamarea = 10000;

//This will allow spawn near group leader, but group system in epoch is bugged
_spawnNearGroup = true;

//adds the default spawns locations
_adddefaultspawns = false;

Halv_spawns = switch(toLower worldName)do{
	case "chernarus":
	{
		[
//these are old a2 positions taken directly from ebays essv2 (thanks ebay) 
//... Richie says they will work, so ill leave them here for now ...
			//Chernarus
			[[4932,1989]],		//"Balota",
			[[12048,8352]],		//"Berezino",
			[[6901,2509]],		//"Chernogorsk",
			[[10294,2191]],		//"Elektrozavodsk",
			[[2236,1923]],		//"Kamenka",
			[[12071,3591]],		//"Kamyshovo",
			[[3608,2152]],		//"Komarovo",
			[[7952,3205]],		//"Prigorodky",
			[[9153,3901]],		//"Pusta",
			[[13510,5249]],		//"Solnichny",
			// Above are defaults
			[[7068,11221]],	//"Devil's Castle",
			[[9711,8962]],	//"Gorka",
			[[5939,10195]],	//"Grishino",
			[[8421,6643]],	//"Guglovo",
			[[8812,11642]],	//"Gvozdno",
			[[5301,8548]],	//"Kabanino",
			[[11053,12361]],	//"Krasnostav",
			[[13407,4175]],	//"Krutoy",
			[[2718,10094]],	//"Lopatino",
			[[4984,12492]],	//"Petrovka",
			[[4582,6457]],	//"Pogorevka",
			[[3626,8976]],	//"Vybor",
			[[6587,6026]],	//"Vyshnoye",
			[[2692,5284]]	//"Zelenogorsk",
		]
	};
	
	case "esseker":{
		[
			[[11082,10280]],	//Camp Spencer
			[[9500,5600]],		//Esseker
			[[2655,1269]],		//Grozna Mountain
			[[9950,10725]],		//Gromada Caves
			[[2000,4180]],		//Krupa
			[[11900,7950]],		//Novi Grad
			[[6470,5445]],		//Neptun Resort
			[[2710,4660]],		//Kupres
			[[5090,4700]],		//Plomino Power Station
			[[10065,4790]],		//Adela Airfield
			[[6680,3900]],		//Plava Vrana Military Complex
			[[10070,9880]],		//Borosh
			[[1170,10280]],		//Camp Spencer
			[[4825,8070]],		//Chokory
			[[2070,7760]]		//Rama
		]
	};
	
/* //create new world spawns, use lower case letters only or it will not be detected (only [x,y] needed)
	case "myworldname":{
		[
			[[0,0],2,"customname"],	//spawn locked for everyone but lvl 2, customname is "customname"
			[[0,0],1],				//spawn locked for everyone but lvl 1
			[[0,0],0,"customname"],	//spawn open for all, customname is "customname"
			[[0,0]]					//minimal spawn, open for all
		]
	};
*/
	default{[]};
};