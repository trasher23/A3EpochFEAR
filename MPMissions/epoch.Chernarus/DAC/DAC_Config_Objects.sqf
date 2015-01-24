//////////////////////////////
//    Dynamic-AI-Creator    //
//    Version 3.1b - 2014   //
//--------------------------//
//    DAC_Config_Objects    //
//--------------------------//
//    Script by Silola      //
//    silola@freenet.de     //
//////////////////////////////

private ["_TypNumber","_TempArray","_Object_Pool"];

_TypNumber = _this select 0;_TempArray = [];

switch (_TypNumber) do
{
//-------------------------------------------------------------------------------------------------
	// use this config if you want to create positions only
	case 0:
	{
		_Object_Pool =	[
							[12,1],
							["LOGIC",1,0,0,0,0,""]
						];
	};
//-------------------------------------------------------------------------------------------------
	case 1:
	{
		_Object_Pool =	[
							[15,1],
							["Box_NATO_Ammo_F",2,0,0,0,0,""],
							["Box_NATO_Wps_F",1,0,0,0,0,""],
							["Box_NATO_Grenades_F",1,0,0,0,0,""],
							["Box_NATO_AmmoOrd_F",1,0,0,0,0,""],
							["Box_NATO_WpsSpecial_F",2,0,0,0,0,""],
							["Box_NATO_Support_F",2,0,0,0,0,""]
						];
	};
//-------------------------------------------------------------------------------------------------
	case 2:
	{
		_Object_Pool =	[
							[0,1],
							["O_Truck_02_transport_F",1,0,0,0,0,""],
							["I_Truck_02_covered_F",1,0,0,0,0,""],
							["B_G_Offroad_01_F",1,0,0,0,0,""],
							["B_G_Offroad_01_armed_F",1,0,0,0,0,""]
						];
	};
//-------------------------------------------------------------------------------------------------
	Default {
				if(DAC_Basic_Value != 5) then
				{
					DAC_Basic_Value = 5;publicvariable "DAC_Basic_Value";
					hintc "Error: DAC_Config_Objects > No valid config number";
				};
				if(true) exitwith {};
			};
};

_TempArray = _Object_Pool;
_TempArray