params ["_vehicle"];

private _source01 = "#particlesource" createVehicleLocal [0,0,0];
_source01 setParticleClass "SmallWreckSmoke";
_source01 attachTo [_vehicle,[.2,1.7,1.3]];

private _source02 = "#particlesource" createVehicleLocal [0,0,0];
_source02 setParticleClass "SmallFireFPlace";
_source02 attachTo [_vehicle,[.2,1.7,1.3]];

private _source03 = "#particlesource" createVehicleLocal [0,0,0];
_source03 setParticleClass "RHS_FireSparks";
_source03 attachTo [_vehicle,[.2,1.7,1.3]];

[{ 
	params ["_vehicle"];
	!alive _vehicle 
}, {

	params ["_vehicle", "_source01", "_source02", "_source03"];
	deleteVehicle _source01;
	deleteVehicle _source02;
	deleteVehicle _source03;

}, [_vehicle, _source01, _source02, _source03]] call CBA_fnc_waitUntilAndExecute;
