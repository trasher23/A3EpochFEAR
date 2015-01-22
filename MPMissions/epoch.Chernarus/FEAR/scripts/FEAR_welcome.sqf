if (isDedicated) exitWith {};

_sizeTitle      = 0.75; // 0.55 Font Size of the Title Messages
_sizeSubText    = 0.65;  // 0.45 Font Size of the SubTitle Messages
_colorTitle     = "#FFFFFF"; // HTML Color Code of the Title Messages (must start with '#' )
_colorSubText   = "#EFEFEF"; // HTML Color Code of the SubTitle Messages (must start with '#' )
_alignTitle     = "left"; // Alignment of the Title Message (right or left)
_alignSubText   = "left"; // Alignment of the SubTitle Message (right or left)
_fontTitle      = "PuristaSemibold"; // Font Type Of Title Messages
_fontSubText    = "PuristaLight"; // Font Type Of SubTitle Messages

_Delay          = 10; // Wait in seconds before the credits start after player IS ingame
_FadeIn         = 5; // 2 how long one role should stay on screen. Use value from 0 to 10 where 0 is almost instant transition to next role

_IntroMusic     = true; // Welcome Intro Song During the credits (true or false)

_posDefault     = [0.3,0.55,0.5]; // Defualt Positions of all Credits


_title          = "Welcome to";
_shorttext      = "Epoch F.E.A.R.";
_posText        = [0.25,0.5,0.4];

/*
_title2         = "Website";
_shorttext2     = "www.my-site.com";
_posText2       = [0.38,0.5,0.25];

_title3         = "Teamspeak 3";
_shorttext3     = "ts.my-site.com";
_posText3       = [0.18,0.5,0.7];

_title4         = "Donate";
_shorttext4     = "Support the server and Help it stay up";
_posText4       = [0.37,0.5,0.28];

_title5         = "Custom Scripts";
_shorttext5     = "Welcome Messages<br />AI Missions<br />Custom Traders<br /> Anti Hack";
_posText5       = [0.35,0.5,0.335];

_title6         = "Play Fair & Enjoy";
_shorttext6     = "Admins are Always Empty";
_posText6       = [0.32,0.5,0.4];
*/













/***********************************************************************************************************************************************/
/***********************************************************************************************************************************************/
/*                                        /!\ DO NOT EDIT BELOW THIS LINE. DO NOT REMOVE CREDITS /!\
/*
/*                                            SCRIPTING BY:        GR8 [GhostzGamerz.com]
/*                                            VERSION:            2.1
/*                                            DATE:            21 December 2014
/*
/***********************************************************************************************************************************************/
/***********************************************************************************************************************************************/
_ms = [];
for "_i" from 1 to 50 do
{
    _t = if (_i!=1) then { format["_title%1",_i] } else { "_title" };
    _s = if (_i!=1) then { format["_shorttext%1",_i] } else { "_shorttext" };
    _p = if (_i!=1) then { format["_postext%1",_i] } else { "_postext" };
    if (!isNil _t or !isNil _s) then
    {
        _at = if (!isNil _t) then { call compile _t } else { "" };
        _as = if (!isNil _s) then { call compile _s } else { "" };
        _ap = if (!isNil _p) then { call compile _p } else { _posDefault };
        _ms = _ms + [[_at,_as,_ap]];
    }
};
waitUntil {!isNuLL(uiNameSpace getVariable ["EPOCH_loadingScreen",displayNull])};
waitUntil {isNuLL(uiNameSpace getVariable ["EPOCH_loadingScreen",displayNull])};
sleep _Delay;
if (_IntroMusic) then { playMusic "Intro";};
player enableSimulation true;
{
    _t = _x select 0;
    _s = _x select 1;
    _pX = _x select 2 select 0;
    _pY = _x select 2 select 1;
    _pW = _x select 2 select 2;
    _m = format ["<t size='%1' color='%2' align='%3' font='%4'>%5<br /></t>", _sizeTitle, _colorTitle, _alignTitle, _fontTitle, _t];
    _m = _m + format ["<t size='%1' color='%2' align='%3' font='%4'>%5<br /></t>", _sizeSubText, _colorSubText, _alignSubText, _fontSubText, _s];
    _tm = round (count toArray (_t+_s) / 6 / 2) + 3;
    [ _m, [_pX * safeZoneW + safeZoneX, _pW], [_pY * safezoneH + safezoneY, 1 * safezoneH + safezoneY], _tm, _FadeIn ] spawn BIS_fnc_dynamicText;
    sleep (_tm+_FadeIn+4);
} forEach _ms;
