/*
	Author: Aaron Clark - EpochMod.com

    Contributors:

	Description:
	Request loot event and setup mirror

    Licence:
    Arma Public License Share Alike (APL-SA) - https://www.bistudio.com/community/licenses/arma-public-license-share-alike

    Github:
    https://github.com/EpochModTeam/Epoch/tree/master/Sources/epoch_code/compile/EPOCH_LootIT.sqf
*/
if (!isNull _this) then {
	[_this,player,Epoch_personalToken] remoteExec ["EPOCH_server_lootContainer",2];

	if (typeof _this == "wardrobe_EPOCH") then {
		if !(_this getVariable["MIRROR_SETUP", false]) then {
			_this spawn {
				_this setVariable ["MIRROR_SETUP", true];
				_cam = "camera" camCreate (_this modelToWorld [0,0.25,1.5]);
				_cam camSetTarget (_this modelToWorld [0,-30,1]);
				_cam camSetFov 0.3;
				_cam camCommit 0;
				"rendertargetwardrobe0" setPiPEffect [0];
				_cam cameraEffect ["Internal", "FRONT","rendertargetwardrobe0"];
				_this setObjectTexture [0,"#(argb,512,512,1)r2t(rendertargetwardrobe0,1.0)"];

				waitUntil {
					uiSleep 5;
					(isNull _this) || ((_this distance player) > 20)
				};

				_cam cameraEffect ["terminate","back"];
				camDestroy _cam;
				_this setVariable["MIRROR_SETUP", nil];
				_this setObjectTexture [0,""];
			};
		};
	};
};
