params ["_uh60"];

private _position = _uh60 getVariable ["GRAD_WP_targetPos", [0,0,0]];
private _originPos = _uh60 getVariable ["GRAD_WP_originPos", [0,0,0]];
_position set [2,2];
private _helipad = "Land_HelipadEmpty_F" createVehicle _position;

{
  _x addCuratorEditableObjects [[_helipad],false];
} forEach allCurators;

_uh60 land "GET OUT";
_uh60 flyInHeight 4;

[{
    params ["_uh60"];
    getPos _uh60 select 2 < 0.5
},{
    params ["_uh60", "_originPos"];
    doStop _uh60;
    private _cargo = _uh60 getVariable ['GRAD_WP_cargo', []];
    {
        private _unit = _x;
        [{
            params ["_uh60", "_unit"];
            _unit action ["EJECT", _uh60];
            unassignVehicle (_unit);
            _unit setFormation "DIAMOND";
        }, [_uh60, _unit], (random 7)] call CBA_fnc_waitAndExecute;
    } forEach _cargo;



    [{
        params ["_uh60"];
        (count (fullCrew [ _uh60, "cargo" ] apply { _x select 0 })) < 1
    },{
            params ["_uh60", "_originPos", "_helipad"];
            [_uh60] doFollow _uh60;
            private _wp = (group _uh60) addWaypoint [_originPos, 0];
            _uh60 forceSpeed 100;
            _uh60 flyInHeight 20;
            deleteVehicle _helipad;
            _wp setWaypointStatements ["true", "
                { deleteVehicle _x } foreach  thislist + [vehicle this]
            "];

    }, [_uh60, _originPos, _helipad]] call CBA_fnc_waitUntilAndExecute;

}, [_uh60, _originPos, _helipad]] call CBA_fnc_waitUntilAndExecute;

