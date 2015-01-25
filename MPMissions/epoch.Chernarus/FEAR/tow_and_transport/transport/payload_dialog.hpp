class DLG_TAT_Transporter
{
	idd = 20100;
	movingEnable = true;
	controlsBackground[] = {};
	objects[] = {};
	controls[] = 
	{
		DialogBackground,
		DialogTitle,
		DialogLabelBackground,
		CapacityLabel,
		CapacityValue,
		ControlInventoryList,
		DialogFooter,
		ButtonUnload,
		ButtonCancel
	};
	
	// Background for dialog
	class DialogBackground : DialogBackgroundBase
	{
		idc = 20101;
		x = 0.25;
		y = 0.25;
		w = 0.5;
		h = 0.6;
	};
	
	// Title bar for dialog
	class DialogTitle : RscTitle
	{
		idc = 20102;
		x = 0.25;
		y = 0.25;
		w = 0.5;
		moving = true;
		text = "Vehicle Payload";
	};
	
	// Label area background
	class DialogLabelBackground : DialogBackgroundBase
	{
		idc = -1;
		x = 0.25;
		w = 0.5;
		y = 0.3; 
		h = 0.05;
	};
	
	// Vehicle capacity text
	class CapacityLabel : RscText
	{
		idc = 20103;
		x = 0.255;
		w = 0.23;
		y = 0.3; 
		h = 0.05;
		text = "Capacity: ";
	};
	
	// Vehicle capacity value
	class CapacityValue : RscText
	{
		idc = 20104;
		x = 0.515;
		w = 0.23;
		y = 0.3;
		h = 0.05;
		text = "";
	};
	
	// List box for stored vehicles
	class ControlInventoryList : ListBase
	{
		idc = 20105;
		w = 0.5;
		h = 0.4;
		x = 0.25;
		y = 0.36;
		onLBDblClick = "execVM ""addons\tow_and_transport\transport\unload_vehicle.sqf"";";
	};
	
	// Footer
	class DialogFooter : DialogBackgroundBase
	{
		idc = 20106;
		x = 0.25;
		y = 0.77;
		w = 0.5;
		h = 0.08;
	};
	
	// Unload button
	class ButtonUnload : RscButton
	{
		idc = 20107;
		x = 0.26;
		y = 0.785;
		text = "Unload";
		action = "execVM ""addons\tow_and_transport\transport\unload_vehicle.sqf"";";
	};
	
	// Close button
	class ButtonCancel : RscButton
	{
		idc = 20108;
		x = 0.640;
		y = 0.785;
		text = "Cancel";
		action = "closeDialog 0;";
	};
};