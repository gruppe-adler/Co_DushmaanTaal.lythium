params ["_start", "_position"];

if (!isServer) exitWith {
    [[_helicopter, _position], _thisScript] remoteExec ["BIS_fnc_execVM", 2];
};

private _helicopter = "RHS_UH60M_d" createVehicle _start;
createVehicleCrew _helicopter;


if (!(_helicopter getVariable ["GRAD_WP_originPos", [0,0,0]] isEqualTo [0,0,0])) exitWith {
    diag_log format ["helicopter already tasked to loiter"];
};


private _startpoint = getPos _helicopter;
_helicopter setVariable ["GRAD_WP_originPos", _startpoint, true];

private _waypoint = group _helicopter addWaypoint [_position, 0];

_waypoint setWaypointType "TR UNLOAD";
_waypoint setWaypointStatements ["true", "
    [vehicle this] execvm 'USER\scripts\uh60land.sqf';
"];

private _hpad = "Land_HelipadEmpty_F" createVehicle [0,0,0];
_hpad setPosASL _position;

_helicopter flyInHeight 50;



private _unitTypes = ["squad"] call GRAD_zeusmodules_fnc_getReinforcementUnits;
private _group = createGroup west;
{ 
	_group createUnit [_x, [0,0,0], [], 0, "NONE"];
} forEach _unitTypes;

_helicopter setVariable ["GRAD_WP_cargo", units _group, true];

{ _x assignAsCargo _helicopter; } forEach units _group;
{ _x moveInCargo _helicopter; } forEach units _group;


_helicopter setCombatMode "RED";
_helicopter disableAI "AUTOCOMBAT";
_helicopter disableAI "Autotarget";
_helicopter allowFleeing 0;
_helicopter setskill ["courage",1];




_helicopter addEventHandler ["HandleDamage", {
	params ["_unit", "_selection", "_damage", "_source", "_projectile", "_hitIndex", "_instigator", "_hitPoint", "_directHit", "_context"];

    // systemchat str _context;
    if (!local _unit) exitWith {};

    private _islanding = _unit getVariable ["GRAD_isLanding", false];

    if (_damage > 0.1 && !_islanding) exitWith {
        _unit setVariable ["GRAD_isLanding", true, true];

        if (random 2 > 1) then {
            [_unit, "USER\scripts\hitVehicleFX.sqf"] remoteExec ["BIS_fnc_execVM", 0, _unit];
        };

        private _startpoint = _unit getVariable ["GRAD_WP_originPos", [0,0,0]];
        private _waypoint = group _unit addWaypoint [_startpoint, 1];
        group _unit setCurrentWaypoint [group _unit, 0];


        private _hpad = "Land_HelipadEmpty_F" createVehicle [0,0,0];
        _hpad setPosASL _pos;
        _unit landAt [_hpad, "LAND"];

        0
    };
}];