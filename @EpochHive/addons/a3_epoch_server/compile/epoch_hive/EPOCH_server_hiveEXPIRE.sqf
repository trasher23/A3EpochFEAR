private ["_prefix","_key","_expires","_call"];
_prefix = _this select 0;
_key = _this select 1;
_expires = _this select 2;

_call = 131;
if !(EPOCH_hiveAsync) then {
	_call = 130;
};

"epochserver" callExtension format ["%1|%2:%3|%4", _call, _prefix, _key, _expires];
