params ["_vehicle"];

private _selections = selectionNames _vehicle;
private _minePositions = [];

{
	_minePositions pushBackUnique (_vehicle selectionPosition _x);
} forEach _selections;

private _mine = createMine ["gm_minestatic_ap_pfm1", [0,0,0], [], 0];

["ace_allowDefuse", [_mine, true]] call CBA_fnc_globalEventJIP;
_mine attachTo [_vehicle, selectRandom _minePositions];
_mine allowDamage false;
hideObjectGlobal _mine;

private _driver = (creategroup civilian) createUnit ["UK3CB_TKC_C_WORKER", [0,0,0], [], 0, "NONE"];
_driver assignAsDriver _vehicle;
_driver moveInDriver _vehicle;
_driver setVariable ["lambs_danger_disableAI", true];
