// for better convoy mod

params ["_unitArray", "_waypoint"];

private _logicCenter = createCenter sideLogic;
private _logicGroup = createGroup _logicCenter;
private _convoy = _logicGroup createUnit ["Logic", [0,0,0], [], 0, "NONE"];
_convoy setVariable ["maxSpeed", 45];
_convoy setVariable ["convSeparation", 20];
_convoy setVariable ["stiffnessCoeff", 0.2];
_convoy setVariable ["dampingCoeff", 0.6];
_convoy setVariable ["curvatureCoeff", 0.3];
_convoy setVariable ["stiffnessLinkCoeff", 0.1];
_convoy setVariable ["pathFrequecy", 0.05];
_convoy setVariable ["speedFrequecy", 0.2];
_convoy setVariable ["speedModeConv", "FULL"];
_convoy setVariable ["behaviourConv", "pushThroughContact"];
_convoy setVariable ["debug", false];


// Execute the convoy initialization script
[_convoy, _unitArray] execVM "\nagas_Convoy\functions\fn_initConvoy.sqf";

// _convoy setVariable ["maxSpeed", 40];

(group (_unitArray#0)) addWaypoint [_waypoint, 0];

/*
// stop the convoy without erasing its waypoints
_convoy setVariable ["maxSpeed", 0];
sleep 5; // wait for all vehicles to stop

// disband the convoy
vehicleLead setVariable ["convoy_terminate", true];
sleep .5; // wait for script to finish

// create a new convoy with only the first two vehicles
call{ 0 = [_convoy,[vehicleLead,vehicle2]] execVM "\nagas_Convoy\functions\fn_initConvoy.sqf" };

// resume
_convoy setVariable ["maxSpeed", 40];
*/