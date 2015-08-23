private ["_hiveResponse","_hiveStatus","_hiveMessage","_whileCount"];
//_PREFIX = _this select 0;
//_KEY = _this select 1;

_hiveStatus = -1;
_hiveMessage = "";
_hiveTTL = -1;
_hiveResponse = "";
_whileCount = 0;
while {_hiveStatus < 0 || _hiveStatus == 2} do {
	if (_whileCount == 0) then {
		_hiveResponse = "epochserver" callExtension format ["210|%1:%2", _this select 0, _this select 1];
	}
	else {
		_hiveResponse = "epochserver" callExtension format ["200|%1:%2", _this select 0, _this select 1];
	};

	_hiveStatus = 0;
	if (_hiveResponse != "") then {
		_hiveResponse = call compile _hiveResponse;
		if !(isNil "_hiveResponse") then {
			if (typeName _hiveResponse == "ARRAY" && !(_hiveResponse isEqualTo [])) then {
				_hiveStatus = _hiveResponse select 0;
				if (_hiveStatus >= 1) then {
					if (_whileCount == 0) then {
						_hiveTTL = _hiveResponse select 1;
						_hiveMessage = _hiveMessage + (_hiveResponse select 2);
					}
					else {
						_hiveMessage = _hiveMessage + (_hiveResponse select 1);
					};
				};
			};
		};
	};

	_whileCount = _whileCount + 1;
};

if (_hiveStatus > 0 && _hiveMessage find "<null>" == -1) then {
	_hiveMessage = call compile _hiveMessage;
	if (isNil "_hiveMessage") then { _hiveMessage = [];}
}
else {
	_hiveMessage = [];
};

[_hiveStatus, _hiveMessage, _hiveTTL]
