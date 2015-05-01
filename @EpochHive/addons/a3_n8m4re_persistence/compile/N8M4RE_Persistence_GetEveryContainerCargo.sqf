private ["_container","_cargo","_class"];
_container = everyContainer _this;
_cargo = [];
{_class = _x select 0;_cargo pushBack [( (_x select 1) call N8M4RE_Persistence_GetCargo )];} forEach _container;
_cargo
