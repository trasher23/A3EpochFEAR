private ["_path","_fncNames"];
if(isNil"N8M4RE_DevelMode")then{N8M4RE_DevelMode=false;};
if(N8M4RE_DevelMode)then{_path ="compile";}else{_path="\x\addons\a3_n8m4re_persistence\compile";};
N8M4RE_CompileFinal = { 
// [_fncNames,_path,_prefix] call N8M4RE_CompileFinal
{ 
missionNamespace setVariable[format["%1_%2",(_this select 2),_x],compileFinal preprocessFileLineNumbers format["%1\%2_%3.sqf",(_this select 1),(_this select 2),_x]];
} forEach (_this select 0);
true
};

_fncNames = [
	"PublicEH",
	"Variables",
	"AddWeaponCargo",
	"AddItemCargo",
	"AddMagazinesCargo",
	"AddBackpackCargo",
	"DayTime",
	"GetCargo",
	"GetEveryContainerCargo",
	"GetClassType",
	"Holder_Load",
	"Holder_PutTake",
	"Mines_Load",
	"Mines_Deploy"
];


[_fncNames,_path,"N8M4RE_Persistence"] call N8M4RE_CompileFinal;
