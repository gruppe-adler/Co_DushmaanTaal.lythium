private _classname = selectRandom [
	"UK3CB_TKC_C_Ikarus",
	"UK3CB_TKC_C_Datsun_Civ_Closed",
	"UK3CB_TKC_C_Datsun_Civ_Open",
	"UK3CB_TKC_C_Hatchback",
	"UK3CB_TKC_C_Hilux_Civ_Closed",
	"UK3CB_TKC_C_Hilux_Civ_Open",
	"UK3CB_TKC_C_Kamaz_Covered",
	"UK3CB_TKC_C_Kamaz_Fuel",
	"UK3CB_TKC_C_Kamaz_Repair",
	"UK3CB_TKC_C_Lada",
	"UK3CB_TKC_C_Lada_Taxi",
	"UK3CB_TKC_C_Lada",
	"UK3CB_TKC_C_Lada_Taxi",
	"UK3CB_TKC_C_Lada",
	"UK3CB_TKC_C_Lada_Taxi",
	"UK3CB_TKC_C_LR_Open",
	"UK3CB_TKC_C_LR_Closed",
	"UK3CB_TKC_C_Pickup",
	"UK3CB_TKC_C_V3S_Reammo",
	"UK3CB_TKC_C_V3S_Refuel",
	"UK3CB_TKC_C_V3S_Repair",
	"UK3CB_TKC_C_V3S_Closed",
	"UK3CB_TKC_C_V3S_Open",
	"UK3CB_TKC_C_Sedan",
	"UK3CB_TKC_C_Sedan",
	"UK3CB_TKC_C_Sedan",
	"UK3CB_TKC_C_Skoda",
	"UK3CB_TKC_C_Skoda",
	"UK3CB_TKC_C_Skoda",
	"UK3CB_TKC_C_UAZ_Closed",
	"UK3CB_TKC_C_Ural_Open",
	"UK3CB_TKC_C_Ural_Repair",
	"gm_ge_civ_w123",
	"gm_ge_civ_w123",
	"gm_ge_civ_typ251"
];

private _path = call grad_zeusmodules_fnc_trafficpath_1;

private _firstPathPos = _path select 0;
private _secondPathPos = _path select 1;
_firstPathPos deleteAt 3;
_secondPathPos deleteAt 3;
private _dir = _firstPathPos getDir _secondPathPos;

private _vehicle = createVehicle [_classname, _firstPathPos, [], 0, "NONE" ];
_vehicle setDir _dir;
private _crew = createVehicleCrew _vehicle;
_vehicle forceFollowRoad true;

{
	_x setVariable ["lambs_danger_disableAI", true, true];
	_x setBehaviour "CARELESS";
	
} forEach units _crew;
doStop _vehicle;

[{
	params ["_vehicle", "_path"];
	_vehicle setDriveOnPath _path;
	
}, [_vehicle, _path], 3] call cba_fnc_waitandexecute;



private _existingTraffic = missionNamespace getVariable ["grad_traffic", []];
_existingTraffic pushBackUnique _vehicle;
missionNamespace setVariable ["grad_traffic", _existingTraffic, true];


[{
	params ["_args", "_handle"];
	_args params ["_vehicle"];

	// Parameters
	private _coneDistance = 50;                 // Distance of the cone
	private _coneAngle = 90;                    // Half-angle of the cone (in degrees)
	private _existingTraffic = missionNamespace getVariable ["grad_traffic", []];
	
	// Get the direction of the cone
	private _coneDir = getDir _vehicle;
	private _objPos = getPos _vehicle;
	private _posInFront = _objPos getPos [20, _coneDir];

	// Filter objects within the cone
	private _objectsInCone = _existingTraffic select {
		(_x inArea [_posInFront, _coneDistance, 5, _coneDir, true, 10])
	};

	private _foundVehicles = count _objectsInCone > 0;
	// debug cone
	// [_vehicle, _posInFront, _coneAngle, _coneDistance, _foundVehicles] call grad_traffic_debug;

	if ((count _objectsInCone) > 0 || _vehicle getVariable ["grad_traffic_stopped", false]) then {
		_vehicle limitSpeed 0.001;
	} else {
		if (_vehicle distance controlPoint < 150) then {
			_vehicle limitSpeed ((_vehicle distance _controlPoint) / 2);
		} else {
			_vehicle limitSpeed 70;
		};
	};

}, 0.5, [_vehicle]] call CBA_fnc_addPerFrameHandler;


grad_traffic_debug = {
	params ["_vehicle", "_posInFront", "_coneAngle", "_coneDistance", "_foundVehicles"];

	// Parameters
	private _width = 5;                                    // Half-width of the rectangle
	private _coneDir = vectorNormalized vectorDir _vehicle; // Normalize the cone direction
	private _coneColor = if (_foundVehicles) then { [1, 0, 0, 1] } else { [0, 1, 0, 1] };

	// Calculate perpendicular vector
	private _perpendicular = _coneDir vectorCrossProduct (vectorUp _vehicle);

	// Debug: Log cone direction and perpendicular vector
	diag_log format ["Normalized Cone Direction: %1", _coneDir];
	diag_log format ["Perpendicular Vector: %1", _perpendicular];

	// Calculate rectangle corners
	private _topLeft = _posInFront vectorAdd ((_coneDir vectorMultiply (_coneDistance / 2)) vectorAdd (_perpendicular vectorMultiply _width));
	private _topRight = _posInFront vectorAdd ((_coneDir vectorMultiply (_coneDistance / 2)) vectorAdd (_perpendicular vectorMultiply -_width));
	private _bottomLeft = _posInFront vectorAdd ((_coneDir vectorMultiply -(_coneDistance / 2)) vectorAdd (_perpendicular vectorMultiply _width));
	private _bottomRight = _posInFront vectorAdd ((_coneDir vectorMultiply -(_coneDistance / 2)) vectorAdd (_perpendicular vectorMultiply -_width));

	// Debug: Log rectangle corners
	diag_log format ["TopLeft: %1, TopRight: %2, BottomLeft: %3, BottomRight: %4", _topLeft, _topRight, _bottomLeft, _bottomRight];

	// Draw debug lines
	drawLine3D [_topLeft, _topRight, _coneColor, 10];    // Top edge
	drawLine3D [_bottomLeft, _bottomRight, _coneColor, 10]; // Bottom edge
	drawLine3D [_topLeft, _bottomLeft, _coneColor, 10];  // Left edge
	drawLine3D [_topRight, _bottomRight, _coneColor, 10]; // Right edge
};