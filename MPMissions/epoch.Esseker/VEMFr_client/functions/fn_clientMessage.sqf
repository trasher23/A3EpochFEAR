/*
	Author: IT07

	Description:
	shows VEMF_Reloaded messages

	Params:
	_this select 0: STRING - the message to display

	Returns:
	nothing
*/

_txt = toUpper ([_this, 0, "", [""]] call BIS_fnc_param);
if not(_txt isEqualTo "") then
{
	disableSerialization;
	_dsp = uiNamespace getVariable "RscDisplayVEMFrClient";
	_show =
	{
		private ["_txt","_ctrl"];
		_ctrl = _this select 0;
		_txt = _this select 1;
		for "_g" from 1 to (count _txt) do
		{
			_ctrl ctrlSetText (_txt select [0, _g]);
			if isNull(findDisplay 49) then { playSound"ReadOutClick" };
			uiSleep 0.07;
		};
		_chars = [];
		for "_t" from 1 to (count _txt) do
		{
			_char = _txt select [_t, 1];
			_chars pushBack _char;
		};
		_writeThis = +_chars;
		uiSleep 10;
		for "_i" from (count _chars) to 1 step -1 do
		{
			_charID = floor random count _chars;
			_deleted = _chars deleteAt _charID;
			if not(_deleted isEqualTo "") then
			{
				_charToSet = _writeThis find _deleted;
				_writeThis set [_charToSet, " "];
				_string = "";
				{
					_string = _string + _x;
				} forEach _writeThis;
				_ctrl ctrlSetText _string;
				if isNull(findDisplay 49) then { playSound"ReadOutHideClick1" };
				uiSleep 0.04;
			};
		};
		_qeue = uiNamespace getVariable "VEMFrClientMsgQeue";
		if not isNil"_qeue" then
		{
			if (typeName _qeue isEqualTo "ARRAY") then
			{
				_index = _qeue find _txt;
				if (_index > -1) then
				{
					_qeue deleteAt _index;
				};
			};
		};
		_ctrlBg ctrlSetPosition [(ctrlPosition _ctrlBg) select 0, (ctrlPosition _ctrlBg) select 1, 0 * safezoneW, (ctrlPosition _ctrlbG) select 3];
		_ctrlBg ctrlCommit 0.4;
		uiSleep 0.5;
		_ctrlTag ctrlSetPosition [(ctrlPosition _ctrlTag) select 0, (ctrlPosition _ctrlTag) select 1, 0 * safezoneW, (ctrlPosition _ctrlTag) select 3];
		_ctrlTag ctrlCommit 0.25;
		_ctrlTag ctrlSetText "";
		(["RscDisplayVEMFrClient"] call BIS_fnc_rscLayer) cutFadeOut 1;
	};
	if isNil"_dsp" then
	{
		_dsp = uiNamespace setVariable ["RscDisplayVEMFrClient", displayNull];
	};
	if not isNil"_dsp" then
	{
		_qeue = uiNamespace getVariable "VEMFrClientMsgQeue";
		if not isNil"_qeue" then
		{
			if (typeName _qeue isEqualTo "ARRAY") then
			{
				_qeue pushBack _txt;
				if not(isNull _dsp) then { waitUntil { uiSleep 2; isNull _dsp; (_qeue select 0) isEqualTo _txt } };
				(["RscDisplayVEMFrClient"] call BIS_fnc_rscLayer) cutRsc["RscDisplayVEMFrClient", "PLAIN", 0, true];
				_dsp = uiNamespace getVariable "RscDisplayVEMFrClient";
				_ctrlTag = _dsp displayCtrl 1001;
			    _ctrlTag ctrlSetPosition [(ctrlPosition _ctrlTag) select 0, (ctrlPosition _ctrlTag) select 1, 0.0625 * safezoneW, (ctrlPosition _ctrlTag) select 3];
			    _ctrlTag ctrlCommit 0.25;
			    uiSleep 0.5;
			    _ctrlBg = _dsp displayCtrl 2200;
			    _ctrlBg ctrlSetPosition [(ctrlPosition _ctrlBg) select 0, (ctrlPosition _ctrlBg) select 1, 0.4375 * safezoneW, (ctrlPosition _ctrlbG) select 3];
			    _ctrlBg ctrlCommit 0.4;
				_ctrl = _dsp displayCtrl 1000;
				uiSleep 0.5;
				[_ctrl, _txt] call _show;
			};
		};
	};
};
