params ["_box"];

private _magazines = [];
private _weapons = [];

{ 
private _player = _x; 

if (isNull getAssignedCuratorLogic _player) then {
private _loadout = getUnitLoadout _player; 
_loadout params ["_primaryArray", "_secondaryArray", "_pistolArray", ["_uniform", []], ["_vest", []], ["_backpack", []]];

{
_weapons pushBackUnique (_x select 0);
}forEach [_primaryArray, _secondaryArray, _pistolArray];

private _container = [];
{
if (count _x >= 2) then {
_container append (_x select 1);
};
}forEach [_uniform, _vest, _backpack];

{ 
if (count _x > 2) then { 
private _type = _x select 0;

private _number = -1;
{
_number = switch (_x) do {
case "HandGrenade" : {GRAD_zeus_numberHandgrenades};
case "CA_LauncherMagazine" : {GRAD_zeus_numberRPG};
case "CA_Magazine" : {GRAD_zeus_numberRifle};
default {-1};
};

if (_number > -1) exitWith {};
}forEach ([configFile >> "CfgMagazines" >> _type, true] call BIS_fnc_returnParents);

_magazines pushBackUnique [_type, _number]; 
}; 
}forEach _container; 
};
}forEach playableUnits + switchableUnits;

{
private _allowedMagazines = [configFile >> "CfgWeapons" >> _x >> "magazines", "ARRAY", []] call CBA_fnc_getConfigEntry;
private _foundCompatibleMag = true;
{
_x params ["_type"];

if (_type in _allowedMagazines) exitWith {
_foundCompatibleMag = false;
};
}forEach _magazines;

if (_foundCompatibleMag) then {
private _type = selectRandom _allowedMagazines;

private _number = -1;
{
_number = switch (_x) do {
case "HandGrenade" : {GRAD_zeus_numberHandgrenades};
case "CA_LauncherMagazine" : {GRAD_zeus_numberRPG};
case "CA_Magazine" : {GRAD_zeus_numberRifle};
default {-1};
};

if (_number > -1) exitWith {};
}forEach ([configFile >> "CfgMagazines" >> _type, true] call BIS_fnc_returnParents);

	_magazines pushBackUnique [_type, _number];
	};
}forEach _weapons;

{	
	_x params ["_type", "_number"];

	_box addMagazineCargoGlobal [_type, _number];
}forEach _magazines;
