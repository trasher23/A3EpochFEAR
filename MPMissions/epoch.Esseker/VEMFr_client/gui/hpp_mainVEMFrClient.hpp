class RscDisplayVEMFrClient
{
	idd = 2991;
	fadeIn = 0.2;
	fadeOut = 1;
	duration = 99999;
	onLoad = "uiNamespace setVariable ['RscDisplayVEMFrClient', _this select 0]; [] spawn VEMFr_fnc_clientRscOnLoad";
	movingEnable = 0;
	class controls
	{
		class IGUIBack {};
		class RscText {};
		#include "hpp_rscVEMFrClient.hpp"
	};
};
