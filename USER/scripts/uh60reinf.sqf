params ["_start", "_position", "_type"];

if (!isServer) exitWith {
    [[_helicopter, _position], _thisScript] remoteExec ["BIS_fnc_execVM", 2];
};

private _helicopter = _type createVehicle _start;
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

_helicopter flyInHeight 20;



private _unitTypes = ["squad"] call GRAD_zeusmodules_fnc_getReinforcementUnits;
private _group = createGroup west;
{ 
	_group createUnit [_x, [0,0,0], [], 0, "NONE"];
} forEach _unitTypes;

_group setVariable ["lambs_danger_dangerFormation", "DIAMOND"];

_helicopter setVariable ["GRAD_WP_cargo", units _group, true];

{ _x assignAsCargo _helicopter; } forEach units _group;
{ _x moveInCargo _helicopter; } forEach units _group;


_helicopter setCombatMode "RED";
_helicopter enableAttack false;
group _helicopter setVariable ["lambs_danger_disableGroupAI", true, true];
_helicopter setVariable ["lambs_danger_disableAI", true, true];
_helicopter disableAI "AUTOCOMBAT";
_helicopter disableAI "Autotarget";
_helicopter allowFleeing 0;
_helicopter setskill ["courage",1];



_helicopter doMove _position; //start move to lz, note: move looks better than a real waypoint for landing

// NNS / porcinus rip 
[_helicopter] spawn { //progressive slow down to limit heli pitch
	_heli = _this select 0; 
	_lz_pos = _heli getVariable ["GRAD_WP_targetPos", [0,0,0]];
	_ramp_start = 3000; _ramp_end = 200; //slow down ramp start / end
	_speed_max = 300; _speed_min = 10; //initial / final speed
	_alt_max = 40; _alt_min = 15; //initial / final altitude
	
	_heli forceSpeed _speed_max; _heli flyInHeight _alt_max; //set starting speed / altitude
	
	waitUntil{sleep 1; ((alive _heli) && (_heli distance2D _lz_pos) < _ramp_start) || !(alive _heli)}; //wait until ramp start distance
	while {(_heli distance2D _lz_pos) > _ramp_end && (alive _heli)} do { //while over ramp end
		_distance=_heli distance2D _lz_pos; //current distance to lz
		
		_tmp_speed = (((_distance-_ramp_end)/(_ramp_start-_ramp_end))*(_speed_max-_speed_min))+_speed_min; //compute new speed
		_tmp_alt = (((_distance-_ramp_end)/(_ramp_start-_ramp_end))*(_alt_max-_alt_min))+_alt_min; //compute new altitude
		
		_heli forceSpeed _tmp_speed; _heli flyInHeight _tmp_alt; //set new speed / altitude
		//[format["_tmp_speed: %1 ,_tmp_alt: %2",_tmp_speed,_tmp_alt]] call NNS_fnc_debugOutput; //debug
		sleep 1;
	};
};


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

		_unit enableAI "AUTOCOMBAT";
		_unit enableAI "Autotarget";

        private _startpoint = _unit getVariable ["GRAD_WP_originPos", [0,0,0]];
        private _waypoint = group _unit addWaypoint [_startpoint, 1];
        group _unit setCurrentWaypoint [group _unit, 0];


        private _hpad = "Land_HelipadEmpty_F" createVehicle [0,0,0];
        _hpad setPosASL _startpoint;
        _unit landAt [_hpad, "LAND"];

        0
    };
}];