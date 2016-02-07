if (hasInterface) then
{
	private "_ret";
	_ret = false;
	if (goggles player == "Mask_M50" or goggles player == "Mask_M40" or goggles player == "Mask_M40_OD" or goggles player == "G_mas_wpn_gasmask") then {
		_ret = true;
	};
	_ret
};