params ["_units"];

private _leadunit = _units select { 
	!((_x getVariable ["grad_convoy_destination", [0,0,0]]) isEqualTo [0,0,0])
};

_leadunit params ["_leader"];

if (isNull _leader) exitWith {
	systemchat ("no leader found for " + str _units);
};

_units = _units select { (_x isKindOf "LandVehicle"); };

diag_log format ["%1", _units];

private _sortedUnits = [_units, [_leader], { _input0 distance _x }, "ASCEND"] call BIS_fnc_sortBy;
// [[_heli1,_heli2,_heli3], [], { player distance _x }, "ASCEND"] call BIS_fnc_sortBy;

// Optional: Verify the order (for debugging).
{
   _x setVariable ["grad_convoy_index", _foreachindex, true];
} forEach _sortedUnits;
