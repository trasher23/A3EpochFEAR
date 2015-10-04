/*
	spawn dialog
	By Halv
	Copyright (C) 2015  Halvhjearne > README.md
*/
#define CT_MAP_MAIN 101
#define ST_PICTURE 0x30

class HALV_IGUIBack {
	type = 0;
	idc = -1;
	style = 80;
	text = "";
	colorText[] = {0,0,0,1};
	font = "PuristaSemibold";
	sizeEx = 0;
	shadow = 0;
	x = 0.1;
	y = 0.1;
	w = 0.1;
	h = 0.1;
	colorbackground[] = {0,0,0,1};
};

class HALV_RscFrame {
	type = 0;
	idc = -1;
	style = 64;
	shadow = 2;
	colorBackground[] = {0,0,0,1};
	colorText[] = {0,0,0,1};
	font = "PuristaSemibold";
	sizeEx = 0.02;
	text = "";
};

class HALV_RscListBox {
	access = 0;
	type = 5;
	w = 0.4;
	h = 0.4;
	rowHeight = 0;
	colorText[] = {0.34,0.98,0.34,1};
	colorDisabled[] = {0.34,0.98,0.34,0.25};
	colorScrollbar[] = {1,0,0,0};
	colorSelect[] = {0,0,0,1};
	colorSelect2[] = {0,0,0,1};
	colorSelectBackground[] = {0.95,0.95,0.95,1};
	colorSelectBackground2[] = {1,1,1,0.5};
	colorBackground[] = {0,0,0,1};
	pictureColor[] = {1,1,1,1}; // Picture color
	pictureColorSelect[] = {1,1,1,1}; // Selected picture color
	pictureColorDisabled[] = {1,1,1,0.5}; // Disabled picture color
	soundSelect[] = {"\A3\ui_f\data\sound\RscListbox\soundSelect", 0.09, 1};
	arrowEmpty = "#(argb,8,8,3)color(1,1,1,1)";
	arrowFull = "#(argb,8,8,3)color(1,1,1,1)";
	
	class ListScrollBar {
		color[] = {1,1,1,0.6};
		colorActive[] = {1,1,1,1};
		colorDisabled[] = {1,1,1,0.3};
		shadow = 0;
		thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
		arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
		arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
		border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
	};
	
	style = 16;
	font = "PuristaSemibold";
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	shadow = 0;
	colorShadow[] = {0,0,0,0.5};
	color[] = {0.34,0.98,0.34,1};
	period = 1.2;
	maxHistoryDelay = 1;
	autoScrollSpeed = -1;
	autoScrollDelay = 5;
	autoScrollRewind = 0;
};

class HALV_RscCheckbox {
	idc = -1;
	type = 7;
	style = 2;
	x = "LINE_X(XVAL)";
	y = "LINE_Y";
	w = "LINE_W(WVAL)";
	h = 0.029412;
	colorText[] = {0,0.5,1,1};
	color[] = {1,1,1,1};
	colorBackground[] = {0,0,0,1};
	colorTextSelect[] = {0, 0.8, 0,0.8};
	colorSelectedBg[] = {0.1,0.1,0.1,0.6};
	colorSelect[] = {0.7,0.7,0.7,0.5};
	colorTextDisable[] = {0,0.5,1,1};
	colorDisable[] = {0,0.8,0,0.8};
	font = "PuristaSemibold";
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	rows = 1;
	columns = 1;
};

class HALV_RscMapControl {
	type = CT_MAP_MAIN;
	style = ST_PICTURE;
	idc = -1;
	colorBackground[] = {0,0,0,1};
	colorOutside[] = {0,0,0,1};
	colorText[] = {0,0,0,1};
	font = "PuristaSemibold";
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.04)";
	colorSea[] = {0.467, 0.631, 0.851, 0.5};
	colorForest[] = {0.624, 0.78, 0.388, 0.5};
	colorRocks[] = {0, 0, 0, 0.3};
	colorCountlines[] = {0.572, 0.354, 0.188, 0.25};
	colorMainCountlines[] = {0.572, 0.354, 0.188, 0.5};
	colorCountlinesWater[] = {0.491, 0.577, 0.702, 0.3};
	colorMainCountlinesWater[] = {0.491, 0.577, 0.702, 0.6};
	colorForestBorder[] = {0, 0, 0, 0};
	colorRocksBorder[] = {0, 0, 0, 0};
	colorPowerLines[] = {0.1, 0.1, 0.1, 1};
	colorRailWay[] = {0.8, 0.2, 0, 1};
	colorNames[] = {0.1, 0.1, 0.1, 0.9};
	colorInactive[] = {1, 1, 1, 0.5};
	colorLevels[] = {0.286, 0.177, 0.094, 0.5};
	colorTracks[] = {0.84, 0.76, 0.65, 0.15};
	colorRoads[] = {0.7, 0.7, 0.7, 1};
	colorMainRoads[] = {0.9, 0.5, 0.3, 1};
	colorTracksFill[] = {0.84, 0.76, 0.65, 1};
	colorRoadsFill[] = {1, 1, 1, 1};
	colorMainRoadsFill[] = {1, 0.6, 0.4, 1};
	colorGrid[] = {0.1, 0.1, 0.1, 0.6};
	colorGridMap[] = {0.1, 0.1, 0.1, 0.6};
	stickX[] = {0.2, {"Gamma", 1, 1.5}};
	stickY[] = {0.2, {"Gamma", 1, 1.5}};
	moveOnEdges = 1;
	x = 0;
	y = 0;
	w = 1;
	h = 1;
	shadow = 0;
	ptsPerSquareSea = 5;
	ptsPerSquareTxt = 20;
	ptsPerSquareCLn = 10;
	ptsPerSquareExp = 10;
	ptsPerSquareCost = 10;
	ptsPerSquareFor = 9;
	ptsPerSquareForEdge = 9;
	ptsPerSquareRoad = 6;
	ptsPerSquareObj = 9;
	showCountourInterval = 0;
	scaleMin = 0.001;
	scaleMax = 1;
	scaleDefault = 0.16;
	maxSatelliteAlpha = 0.85;
	alphaFadeStartScale = 2;
	alphaFadeEndScale = 2;
	fontLabel = "PuristaSemibold";
	sizeExLabel = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
	fontGrid = "PuristaSemibold";
	sizeExGrid = 0.02;
	fontUnits = "PuristaSemibold";
	sizeExUnits = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
	fontNames = "PuristaSemibold";
	sizeExNames = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8) * 2";
	fontInfo = "PuristaSemibold";
	sizeExInfo = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
	fontLevel = "PuristaSemibold";
	sizeExLevel = 0.02;
	text = "#(argb,8,8,3)color(1,1,1,1)";
	onMouseMoving = "mouseX = (_this Select 1);mouseY = (_this Select 2)";
	onMouseButtonDown = "mouseButtonDown = _this Select 1";
	onMouseButtonUp = "mouseButtonUp = _this Select 1";
	class Legend {
		colorBackground[] = {1, 1, 1, 0.5};
		color[] = {0, 0, 0, 1};
		x = "SafeZoneX + (((safezoneW / safezoneH) min 1.2) / 40)";
		y = "SafeZoneY + safezoneH - 4.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		w = "10 * (((safezoneW / safezoneH) min 1.2) / 40)";
		h = "3.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		font = "PuristaSemibold";
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
	};
	class ActiveMarker {
		color[] = {0.3, 0.1, 0.9, 1};
		size = 50;
	};
	class Command {
		color[] = {1, 1, 1, 1};
		icon = "\A3\ui_f\data\map\mapcontrol\waypoint_ca.paa";
		size = 18;
		importance = 1;
		coefMin = 1;
		coefMax = 1;
	};
	class Task {
		colorCreated[] = {1, 1, 1, 1};
		colorCanceled[] = {0.7, 0.7, 0.7, 1};
		colorDone[] = {0.7, 1, 0.3, 1};
		colorFailed[] = {1, 0.3, 0.2, 1};
		color[] = {"(profilenamespace getvariable ['IGUI_TEXT_RGB_R',0])", "(profilenamespace getvariable ['IGUI_TEXT_RGB_G',1])", "(profilenamespace getvariable ['IGUI_TEXT_RGB_B',1])", "(profilenamespace getvariable ['IGUI_TEXT_RGB_A',0.8])"};
		icon = "\A3\ui_f\data\map\mapcontrol\taskIcon_CA.paa";
		iconCreated = "\A3\ui_f\data\map\mapcontrol\taskIconCreated_CA.paa";
		iconCanceled = "\A3\ui_f\data\map\mapcontrol\taskIconCanceled_CA.paa";
		iconDone = "\A3\ui_f\data\map\mapcontrol\taskIconDone_CA.paa";
		iconFailed = "\A3\ui_f\data\map\mapcontrol\taskIconFailed_CA.paa";
		size = 27;
		importance = 1;
		coefMin = 1;
		coefMax = 1;
	};
	class CustomMark {
		color[] = {0, 0, 0, 1};
		icon = "\A3\ui_f\data\map\mapcontrol\custommark_ca.paa";
		size = 24;
		importance = 1;
		coefMin = 1;
		coefMax = 1;
	};
	class Tree {
		color[] = {0.45, 0.64, 0.33, 0.4};
		icon = "\A3\ui_f\data\map\mapcontrol\bush_ca.paa";
		size = 12;
		importance = "0.9 * 16 * 0.05";
		coefMin = 0.25;
		coefMax = 4;
	};
	class SmallTree {
		color[] = {0.45, 0.64, 0.33, 0.4};
		icon = "\A3\ui_f\data\map\mapcontrol\bush_ca.paa";
		size = 12;
		importance = "0.6 * 12 * 0.05";
		coefMin = 0.25;
		coefMax = 4;
	};
	class Bush {
		color[] = {0.45, 0.64, 0.33, 0.4};
		icon = "\A3\ui_f\data\map\mapcontrol\bush_ca.paa";
		size = "14/2";
		importance = "0.2 * 14 * 0.05 * 0.05";
		coefMin = 0.25;
		coefMax = 4;
	};
	class Church {
		color[] = {1, 1, 1, 1};
		icon = "\A3\ui_f\data\map\mapcontrol\church_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1;
	};
	class Chapel {
		color[] = {0, 0, 0, 1};
		icon = "\A3\ui_f\data\map\mapcontrol\Chapel_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1;
	};
	class Cross {
		color[] = {0, 0, 0, 1};
		icon = "\A3\ui_f\data\map\mapcontrol\Cross_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1;
	};
	class Rock {
		color[] = {0.1, 0.1, 0.1, 0.8};
		icon = "\A3\ui_f\data\map\mapcontrol\rock_ca.paa";
		size = 12;
		importance = "0.5 * 12 * 0.05";
		coefMin = 0.25;
		coefMax = 4;
	};
	class Bunker {
		color[] = {0, 0, 0, 1};
		icon = "\A3\ui_f\data\map\mapcontrol\bunker_ca.paa";
		size = 14;
		importance = "1.5 * 14 * 0.05";
		coefMin = 0.25;
		coefMax = 4;
	};
	class Fortress {
		color[] = {0, 0, 0, 1};
		icon = "\A3\ui_f\data\map\mapcontrol\bunker_ca.paa";
		size = 16;
		importance = "2 * 16 * 0.05";
		coefMin = 0.25;
		coefMax = 4;
	};
	class Fountain {
		color[] = {0, 0, 0, 1};
		icon = "\A3\ui_f\data\map\mapcontrol\fountain_ca.paa";
		size = 11;
		importance = "1 * 12 * 0.05";
		coefMin = 0.25;
		coefMax = 4;
	};
	class ViewTower {
		color[] = {0, 0, 0, 1};
		icon = "\A3\ui_f\data\map\mapcontrol\viewtower_ca.paa";
		size = 16;
		importance = "2.5 * 16 * 0.05";
		coefMin = 0.5;
		coefMax = 4;
	};
	class Lighthouse {
		color[] = {1, 1, 1, 1};
		icon = "\A3\ui_f\data\map\mapcontrol\lighthouse_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1;
	};
	class Quay {
		color[] = {1, 1, 1, 1};
		icon = "\A3\ui_f\data\map\mapcontrol\quay_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1;
	};
	class Fuelstation {
		color[] = {1, 1, 1, 1};
		icon = "\A3\ui_f\data\map\mapcontrol\fuelstation_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1;
	};
	class Hospital {
		color[] = {1, 1, 1, 1};
		icon = "\A3\ui_f\data\map\mapcontrol\hospital_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1;
	};
	class BusStop {
		color[] = {1, 1, 1, 1};
		icon = "\A3\ui_f\data\map\mapcontrol\busstop_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1;
	};
	class Transmitter {
		color[] = {1, 1, 1, 1};
		icon = "\A3\ui_f\data\map\mapcontrol\transmitter_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1;
	};
	class Stack {
		color[] = {0, 0, 0, 1};
		icon = "\A3\ui_f\data\map\mapcontrol\stack_ca.paa";
		size = 20;
		importance = "2 * 16 * 0.05";
		coefMin = 0.9;
		coefMax = 4;
	};
	class Ruin {
		color[] = {0, 0, 0, 1};
		icon = "\A3\ui_f\data\map\mapcontrol\ruin_ca.paa";
		size = 16;
		importance = "1.2 * 16 * 0.05";
		coefMin = 1;
		coefMax = 4;
	};
	class Tourism {
		color[] = {0, 0, 0, 1};
		icon = "\A3\ui_f\data\map\mapcontrol\tourism_ca.paa";
		size = 16;
		importance = "1 * 16 * 0.05";
		coefMin = 0.7;
		coefMax = 4;
	};
	class Watertower {
		color[] = {1, 1, 1, 1};
		icon = "\A3\ui_f\data\map\mapcontrol\watertower_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1;
	};
	class Waypoint {
		color[] = {0, 0, 0, 1};
		size = 24;
		importance = 1;
		coefMin = 1;
		coefMax = 1;
		icon = "\A3\ui_f\data\map\mapcontrol\waypoint_ca.paa";
	};
	class WaypointCompleted {
		color[] = {0, 0, 0, 1};
		size = 24;
		importance = 1;
		coefMin = 1;
		coefMax = 1;
		icon = "\A3\ui_f\data\map\mapcontrol\waypointCompleted_ca.paa";
	};
	class power {
		icon = "\A3\ui_f\data\map\mapcontrol\power_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1;
		color[] = {1, 1, 1, 1};
	};
	class powersolar {
		icon = "\A3\ui_f\data\map\mapcontrol\powersolar_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1;
		color[] = {1, 1, 1, 1};
	};
	class powerwave {
		icon = "\A3\ui_f\data\map\mapcontrol\powerwave_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1;
		color[] = {1, 1, 1, 1};
	};
	class powerwind {
		icon = "\A3\ui_f\data\map\mapcontrol\powerwind_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1;
		color[] = {1, 1, 1, 1};
	};
	class Shipwreck {
		icon = "\A3\ui_f\data\map\mapcontrol\Shipwreck_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1;
		color[] = {0, 0, 0, 1};
	};
};	
	
class HALV_RscStructuredText {
	access = 0;
	type = 13;
	idc = -1;
	style = 0;
	colorText[] = {0.34,0.98,0.34,1};
	colorBackground[] = {0,0,0,1};
	class Attributes
	{
		font = "PuristaSemibold";
		color = "#58FA58";
		align = "center";
		shadow = 1;
	};
	x = 0;
	y = 0;
	h = 0.035;
	w = 0.1;
	text = "";
	size = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	shadow = 1;
};

class Halv_spawn_dialog {
	idd=7777;
	moveingenabled=false;
	class controls
	{
		class HALV_spawn_backtext: HALV_IGUIBack
		{
			idc = -1;
			x = 0.195876 * safezoneW + safezoneX;
			y = 0.840914 * safezoneH + safezoneY;
			w = 0.159794 * safezoneW;
			h = 0.0219945 * safezoneH;
		};
		class HALV_spawn_frametext: HALV_RscFrame
		{
			idc = -1;
			x = 0.195876 * safezoneW + safezoneX;
			y = 0.840914 * safezoneH + safezoneY;
			w = 0.159794 * safezoneW;
			h = 0.0219945 * safezoneH;
		};
		class HALV_spawn_back: HALV_IGUIBack
		{
			idc = -1;
			x = 0.180412 * safezoneW + safezoneX;
			y = 0.115097 * safezoneH + safezoneY;
			w = 0.628866 * safezoneW;
			h = 0.769807 * safezoneH;
		};
		class HALV_spawn_frame: HALV_RscFrame
		{
			idc = -1;
			text = "Spawn Menu by Halv";
			x = 0.180412 * safezoneW + safezoneX;
			y = 0.115097 * safezoneH + safezoneY;
			w = 0.628866 * safezoneW;
			h = 0.769807 * safezoneH;
		};
		class HALV_spawn_mapframe: HALV_RscFrame
		{
			idc = -1;
			x = 0.35567 * safezoneW + safezoneX;
			y = 0.137091 * safezoneH + safezoneY;
			w = 0.438144 * safezoneW;
			h = 0.725818 * safezoneH;
		};
		class HALV_spawn_map: HALV_RscMapControl
		{
			idc = 7775;
			text = "";
			x = 0.35567 * safezoneW + safezoneX;
			y = 0.137091 * safezoneH + safezoneY;
			w = 0.438144 * safezoneW;
			h = 0.725818 * safezoneH;
		};
		class HALV_spawn_listboxframe: HALV_RscFrame
		{
			idc = -1;
			x = 0.195876 * safezoneW + safezoneX;
			y = 0.18108 * safezoneH + safezoneY;
			w = 0.159794 * safezoneW;
			h = 0.659834 * safezoneH;
		};
		class HALV_spawn_list: HALV_RscListBox
		{
			idc = 7776;
			x = 0.195876 * safezoneW + safezoneX;
			y = 0.18108 * safezoneH + safezoneY;
			w = 0.159794 * safezoneW;
			h = 0.659834 * safezoneH;
			onLBSelChanged = "if(HALV_SELECTSPAWN)then{_this call Halv_moveMap}; false";
			onLBDblClick = "if(HALV_SELECTSPAWN)then{_this call Halv_spawn_player}else{_this call HALV_player_removelisteditem;}; false";
		};
		class HALV_spawn_butframe: HALV_RscFrame
		{
			idc = -1;
			x = 0.273196 * safezoneW + safezoneX;
			y = 0.137091 * safezoneH + safezoneY;
			w = 0.0824742 * safezoneW;
			h = 0.043989 * safezoneH;
		};
		class HALV_spawn_text: HALV_RscStructuredText
		{
			idc = -1;
			text = "$STR_HALV_TS3";
			x = 0.195876 * safezoneW + safezoneX;
			y = 0.840914 * safezoneH + safezoneY;
			w = 0.159794 * safezoneW;
			h = 0.0219945 * safezoneH;
		};
	};
};