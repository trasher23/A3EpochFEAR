private ["_prefix","_key","_value","_bitIndex"];

_prefix = _this select 0;
_key = _this select 1;
_bitIndex = _this select 2;
_value = _this select 3;

"epochserver" callExtension format["141|%1:%2|%3|%4", _prefix, _key, _bitIndex, _value];
